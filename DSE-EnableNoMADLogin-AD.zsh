#!/bin/zsh

# Author: Andrew W. Johnson
# Date: 2020.10.09
# Version: 1.00
# Organization: Stony Brook University/DoIT
#
# This script is run from Jamf Pro as a startup policy. It will check to see if 
# NoMADLogin-AD is running and enable it if it is not. NoMADLogin-AD tends to get disabled 
# when an OS Update/Upgrade takes place.


	# If the app authchanger exists then we can go on.
if [[ -e "/usr/local/bin/authchanger" ]]; then
		# Check on the status and see if NoMADLogin-AD is set.
	myNoMAD=$(/usr/local/bin/authchanger -Print | /usr/bin/egrep -ic NoMADLoginAD)
	if [[ ${myNoMAD} -ge 1 ]]; then
		/bin/echo "NoMADLogin-AD is functioning."
	else
		/bin/echo "NoMADLogin-AD is not working."
			# Enable NoMADLogin-AD.
		/usr/local/bin/authchanger -reset -AD
#		/bin/launchctl kickstart -k system/com.apple.loginwindow
		/sbin/reboot
	fi
else
	/bin/echo "/usr/local/bin/authchanger does not seem to be installed."
fi
exit 0
