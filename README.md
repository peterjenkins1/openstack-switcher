openstack-switcher
==================

Switch between openstack environments without prompting for a password each time.

Example for your .bashrc:
     
      . path/to/osswitch.bash
     
     alias os_redprod="ose red https://red-prod:5001/v2.0 tenant tenant user red-prod"
     alias os_reddevel="ose red https://red-devel:5001/v2.0 tenant tenant user red-devel"
     alias os_blueprod="ose blue https://blue-prod:5001/v2.0 tenant tenant user blue-prod"

Then:

     $ os_reddevel
     Please enter your OpenStack Password for red:
     $ nova show ...
