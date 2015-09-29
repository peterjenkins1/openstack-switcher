#!/bin/bash

# Switch openstack enviroments without prompting for passwords every time

ose() {
  # Bash sucks
  NEW_SERVICE=$1
  NEW_LDAP=$2
  NEW_ENV=$3
  NEW_AUTH_URL=$4
  NEW_TENANT_NAME=$5
  NEW_TENANT_ID=$6
  NEW_USERNAME=$7
  NEW_REGION_NAME=$8
  NEW_USER_DOMAIN_NAME=$9
  NEW_IDENTITY_API_VERSION=${10}

  # Check if we already have a password stored
  if [ "$NEW_LDAP" != "$OS_LDAP" ]; then
    echo "Please enter your OpenStack Password for $NEW_SERVICE: "
    read -sr OS_PASSWORD_INPUT

    if [ "$NEW_IDENTITY_API_VERSION" = "3" ]; then # Juno onwards
      if ! openstack token issue --os-username $NEW_USERNAME \
                                 --os-password $OS_PASSWORD_INPUT \
                                 --os-user-domain-name $NEW_USER_DOMAIN_NAME \
                                 --os-identity-api-version $NEW_IDENTITY_API_VERSION \
                                 --os-auth-url $NEW_AUTH_URL &> /dev/null
      then
        echo "Invalid credentials"
        return 1
      fi
    else # Older than Juno

      if ! keystone --os-username $NEW_USERNAME --os-password $OS_PASSWORD_INPUT \
                    --os-auth-url $NEW_AUTH_URL token-get  &> /dev/null
      then
        echo "Invalid credentials"
        return 1
      fi
    fi
    export OS_PASSWORD=$OS_PASSWORD_INPUT
  fi

  export OS_SERVICE=$NEW_SERVICE
  export OS_ENV=$NEW_ENV
  export OS_LDAP=$NEW_LDAP
  export OS_AUTH_URL=$NEW_AUTH_URL
  export OS_TENANT_NAME=$NEW_TENANT_NAME
  export OS_TENANT_ID=$NEW_TENANT_ID
  export OS_USERNAME=$NEW_USERNAME
  export OS_REGION_NAME=$NEW_REGION_NAME
  if [ "$NEW_IDENTITY_API_VERSION" = "3" ]; then # Juno onwards
    export OS_USER_DOMAIN_NAME=$NEW_USER_DOMAIN_NAME
    export OS_IDENTITY_API_VERSION=$NEW_IDENTITY_API_VERSION
  else # For when switching from Juno to older environments
    unset OS_USER_DOMAIN_NAME
    unset OS_IDENTITY_API_VERSION
  fi

  PS1="$OS_SERVICE:$OS_ENV \[\033[01;32m\]\u@\h\[\033[00m\] \[\033[01;34m\]\W\[\033[00m\]\[\033[1;32m\]\$\[\033[m\] "
}

# Example for your .bashrc
#
# . path/to/osswitch.bash
#
#alias os_redprod="ose red ldap1 prod https://red-prod:5001/v2.0 tenant tenant-id user red-prod domainA 2"
#alias os_reddevel="ose red ldap1 devel https://red-devel:5001/v2.0 tenant tenant-id user red-devel domainA 2"
#alias os_blueprod="ose blue ldap1 prod https://blue-prod:5001/v3 tenant tenant-id user blue-prod domainB 3"
