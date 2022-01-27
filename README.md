# JAMF-NoMADLogin-AD
 Scripts to help manage NoMADLogin-AD from Jamf.

- Author: Andrew W. Johnson
- Date: 2020.10.09
- Version: 1.00
- Organization: Stony Brook University/DoIT
---
### Description

- **DSE-EnableNoMADLogin-AD.zsh**: This script is run from Jamf Pro as a startup policy. It will check to see if NoMADLogin-AD is running and enable it if it is not. NoMADLogin-AD tends to get disabled when an OS Update/Upgrade takes place.

- **DSE-DisableNoMADLogin-AD.zsh**: This script is run from Jamf Pro as a startup policy. It will disable NoMADLogin-AD. This is for computers residing on Wi-Fi only and need to first time authenticate at the login window.
