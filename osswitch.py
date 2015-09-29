#!/bin/env python

import keyring
import getpass
import keystoneclient.v2_0.client as keystoneclient

username = "test"
auth_url = "https://pouta.csc.fi:5001/v2.0"
tenant_name = "test"

def validate_pw(password):
  creds = { 'username': username,
            'password': password,
            'auth_url': auth_url,
            'tenant_name': tenant_name }
  try:
    keystone = keystoneclient.Client(**creds)
    return keystone.authenticate()
  except Exception as e:
    print(e)
    return False

def main():
  password = keyring.get_password(auth_url, username)
  if not password:
    password = getpass.getpass()
    if validate_pw(password):
      keyring.set_password(auth_url, username, password)
    else:
      return 1

  ''' Config the environment '''
  os.environ['OS_PASSWORD']    = password
  os.environ['OS_AUTH_URL']    = auth_url
  os.environ['OS_TENANT_ID']   = tenant_name
  os.environ['OS_TENANT_NAME'] = tenant_name
  os.environ['OS_USERNAME']    = username
  os.environ['OS_REGION_NAME'] = "test"

if __name__ == '__main__':
  main()

