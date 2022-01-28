#!/bin/zsh

# Author: Andrew W. Johnson
# Date: 2020.10.09
# Version: 1.00
# Organization: Stony Brook University/DoIT

# This script is run from Jamf Pro as a startup policy. It will disable NoMADLogin-AD.
# This is for computers residing on Wi-Fi only and need to first time authenticate at the login window.

	# If the app authchanger exists then we can go on.
if [[ -e "/usr/local/bin/authchanger" ]]; then
		# Check on the status and see if NoMADLogin-AD is set.
	myNoMAD=$(/usr/local/bin/authchanger -Print | /usr/bin/egrep -ic NoMADLoginAD)
	if [[ ${myNoMAD} -ge 1 ]]; then
		/bin/echo "NoMADLogin-AD is enabled. Disabling NoMADLogin-AD"
		/bin/echo "$( /bin/date | /usr/bin/awk '{print $1, $2, $3, $4}' ) $( /usr/sbin/scutil --get LocalHostName ) $( /usr/bin/basename ${0} )[$$]: NoMADLogin-AD is enabled. Disabling NoMADLogin-AD" >> /var/log/jamf.log
			# Disable NoMADLogin-AD.
        /usr/local/bin/authchanger -reset
#		/bin/launchctl kickstart -k system/com.apple.loginwindow
		/sbin/reboot
	else
		/bin/echo "NoMADLogin-AD is not enabled."
		/bin/echo "$( /bin/date | /usr/bin/awk '{print $1, $2, $3, $4}' ) $( /usr/sbin/scutil --get LocalHostName ) $( /usr/bin/basename ${0} )[$$]: NoMADLogin-AD is not enabled." >> /var/log/jamf.log
	fi
else
	/bin/echo "/usr/local/bin/authchanger does not seem to be installed."
	/bin/echo "$( /bin/date | /usr/bin/awk '{print $1, $2, $3, $4}' ) $( /usr/sbin/scutil --get LocalHostName ) $( /usr/bin/basename ${0} )[$$]: /usr/local/bin/authchanger does not seem to be installed." >> /var/log/jamf.log
fi

exit 0
