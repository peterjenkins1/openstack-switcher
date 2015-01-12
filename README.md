openstack-switcher
==================

Switch between openstack environments without prompting for a password each time.

Example for your .bashrc:
     
      . path/to/osswitch.bash
     
     alias os_redprod="ose red prod https://red-prod:5001/v2.0 tenant user red-prod"
     alias os_reddevel="ose red devel https://red-devel:5001/v2.0 tenant user red-devel"
     alias os_blueprod="ose blue prod https://blue-prod:5001/v2.0 tenant user blue-prod"

Then:

     $ os_reddevel
     Please enter your OpenStack Password for red:
     $ echo "Do some stuff in devel"
     $ os_redprod
     $ echo "Do some stuff in prod"
