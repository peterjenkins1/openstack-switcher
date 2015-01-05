#!/bin/bash

# Switch openstack enviroments without prompting for passwords every time

ose() {
  # Bash sucks
  NEW_ENV=$1
  NEW_AUTH_URL=$2
  NEW_TENANT_ID=$3
  NEW_TENANT_NAME=$4
  NEW_USERNAME=$5
  NEW_REGION_NAME=$6

  # Check if we already have a password stored
  if [ "$NEW_ENV" != "$OS_ENV" ]; then
    echo "Please enter your OpenStack Password for $NEW_ENV: "
    read -sr OS_PASSWORD_INPUT
    export OS_PASSWORD=$OS_PASSWORD_INPUT
  fi

  export OS_ENV=$NEW_ENV
  export OS_AUTH_URL=$NEW_AUTH_URL
  export OS_TENANT_ID=$NEW_TENANT_ID
  export OS_TENANT_NAME=$NEW_TENANT_NAME
  export OS_USERNAME=$NEW_USERNAME
  export OS_REGION_NAME=$NEW_REGION_NAME
}

# Example for your .bashrc
#
# . path/to/osswitch.bash
#
#alias os_redprod="ose red https://red-prod:5001/v2.0 tenant tenant user red-prod"
#alias os_reddevel="ose red https://red-devel:5001/v2.0 tenant tenant user red-devel"
#alias os_blueprod="ose blue https://blue-prod:5001/v2.0 tenant tenant user blue-prod"
