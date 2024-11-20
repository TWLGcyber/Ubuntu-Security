#!/bin/bash
Script() {
  PS3='Choose the vulnerability to fix: '
  vulnerabilities=("Set Permissions" "Find Open Ports" "Find Media Files" "Look In Important Files" "Password File Permissions" "Password Policies" "Secure File Permissions" "System Configuration" "Hidden Users" "Bad Programs" "Updates" "Firewall" "OpenSSH Config" "OpenSCAP Installation" "Quit")
  select fav in "${vulnerabilities[@]}"; do
      case $fav in
          "Set Permissions")
              sudo chmod 777 Perms.sh
	      sudo ./Perms.sh
	      echo "Done!"
	      clear
	      Script
	      ;;
	   "Find Open Ports")
	      sudo ./Open_Ports.sh
	      echo "Done!"
	      clear
	      Script
	      ;;
	   "Find Media Files")
              sudo ./Files/Find_Media_Files.sh
	      echo "Done!"
	      clear
	      Script
	      ;;
	   "Look In Important Files")
              sudo ./Files/Look_In_Files.sh
	      echo "Done!"
	      clear
	      Script
	      ;;
	   "Password File Permissions")
	      sudo ./Passwords_And_Policies/Change_Passwords.sh
	      echo "Done!"
	      clear
	      Script
	      ;;
	   "Password Policies")
	      sudo ./Passwords_And_Policies/Configure_Password_Policies.sh
	      echo "Done!"
	      clear
	      Script
	      ;;
	   "Secure File Permissions")
	      sudo ./System_Scripts/Configure_Services.sh
	      echo "Done!"
	      clear
	      Script
	      ;;
	   "System Configuration")
	      sudo ./System_Scripts/Configure_System_Vulnerabilities.sh
	      echo "Done!"
	      clear
	      Script
	      ;;
	   "Hidden Users")
	      sudo ./System_Scripts/Sudoers.sh
	      echo "Done!"
	      clear
	      Script
	      ;;
	   "Updates")
              sudo ./Programs_And_Updates/Run_Updates.sh
	      echo "Done!"
	      clear
	      Script
              ;;
          "Bad Programs")
              sudo ./Programs_And_Updates/Bad_Programs.sh
	      echo "Done!"
	      clear
	      Script
	      ;;
          "Firewall")
              sudo ./Firewall/Firewall_Config.sh
              sudo ./Firewall/Configure_Network.sh
              sudo ./Firewall/Block_And_Secure_Ports.sh
	      echo "Done!"
	      clear
	      Script
	      ;;
	  "OpenSSH Config")
	      sudo ./Programs_And_Updates/Open_SSH.sh
	      echo "Done!"
	      clear
	      Script
      	      break
              ;;
	  "OpenSCAP Installation")
	      sudo apt install ssg-base ssg-debderived ssg-debian ssg-nondebian ssg-applications libopenscap8 -y
	      clear
	      Script
	      ;;
	  "Quit")
	      echo "User requested exit"
	      exit
	      ;;
          *) echo "invalid option $REPLY";;
      esac
  done
}
#https://www.putorius.net/create-multiple-choice-menu-bash.html
Script
