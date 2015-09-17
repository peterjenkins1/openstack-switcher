#!/bin/bash

# Switch openstack enviroments without prompting for passwords every time

ose() {
  # Bash sucks
  NEW_SERVICE=$1
  NEW_ENV=$2
  NEW_AUTH_URL=$3
  NEW_TENANT_ID=$4
  NEW_USERNAME=$5
  NEW_REGION_NAME=$6
  NEW_USERS_DOMAIN_NAME=$7

  # Check if we already have a password stored
  if [ "$NEW_SERVICE" != "$OS_SERVICE" ]; then
    echo "Please enter your OpenStack Password for $NEW_SERVICE: "
    read -sr OS_PASSWORD_INPUT
    if ! keystone --os-username $NEW_USERNAME --os-password $OS_PASSWORD_INPUT --os-auth-url $NEW_AUTH_URL token-get &> /dev/null
    then
      echo "Invalid credentials"
      return 1
    fi
    export OS_PASSWORD=$OS_PASSWORD_INPUT
  fi

  export OS_SERVICE=$NEW_SERVICE
  export OS_ENV=$NEW_ENV
  export OS_AUTH_URL=$NEW_AUTH_URL
  export OS_TENANT_ID=$NEW_TENANT_ID
  export OS_TENANT_NAME=$NEW_TENANT_ID # Same as above!
  export OS_USERNAME=$NEW_USERNAME
  export OS_REGION_NAME=$NEW_REGION_NAME
  export OS_USERS_DOMAIN_NAME=$NEW_USERS_DOMAIN_NAME

  PS1="$OS_SERVICE:$OS_ENV \[\033[01;32m\]\u@\h\[\033[00m\] \[\033[01;34m\]\W\[\033[00m\]\[\033[1;32m\]\$\[\033[m\] "
}

# Example for your .bashrc
#
# . path/to/osswitch.bash
#
#alias os_redprod="ose red prod https://red-prod:5001/v2.0 tenant user red-prod"
#alias os_reddevel="ose red devel https://red-devel:5001/v2.0 tenant user red-devel"
#alias os_blueprod="ose blue prod https://blue-prod:5001/v2.0 tenant user blue-prod"
