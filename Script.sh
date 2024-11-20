#!/bin/bash

#Check sudo permission
if [ "$EUID" -ne 0 ]
  then echo "Please run as root; sudo ./Script.sh"
  exit
fi

echo
echo "This script was created for the Greenbrier Middle & High School CyberPatriot teams."
echo
echo "This script is designed to run on the Ubuntu 22.04 operating system."
echo "Please read over the script prior to using it on a different operating system."
echo
echo "It is recommended that you have a second terminal window open to remediate anything found during this script"
echo
echo "This Script will create a second terminal window with a helper script running alongside. This script will also open windows for you to review files."
echo

sudo chmod +x Support.sh
sudo gnome-terminal -- bash -c "./Support.sh; exec bash"

#Error Handling for Gnome-Terminal
echo
read -p "Did the above command fail to open a new terminal window?" -n 1 -r
echo    # (optional) move to a new line
if [[  $REPLY =~ ^[Yy]$ ]]
then
    sudo apt install dbus-x11 -y
    sudo gnome-terminal -- bash -c "./Support.sh; exec bash"
fi

#Forensics Questions
read -p "Have you solved the forensic questions?" -n 1 -r
echo    # (optional) move to a new line
if [[ ! $REPLY =~ ^[Yy]$ ]]
then
    echo "Please solve the forensic questions prior to running this script."
    exit
fi

#Users
read -p "Have you audited the users & changed insecure passwords?" -n 1 -r
echo    # (optional) move to a new line
if [[ ! $REPLY =~ ^[Yy]$ ]]
then
    echo "Please audit users prior to running this script."
    exit
fi

#Set Permissions
echo
echo "Setting the necessary permissions to run this script!"
echo
sudo chmod +x Secondary_Scripts/Sudoers.sh
sudo chmod +x Secondary_Scripts/Uninstall.sh

#Configure APT
sudo mv /etc/apt/sources.list /etc/apt/OLD-sources.list
sudo cp Secondary_Scripts/sources.list /etc/apt/sources.list
sudo apt install unattended-upgrades -y
sudo dpkg-reconfigure -plow unattended-upgrades
sudo apt update
sudo gpg /etc/apt/trusted.gpg | tee trusted.log
sudo nano trusted.log

#Install Packages
sudo apt install auditd audispd-plugins -y
sudo apt install plocate -y
sudo apt install --only-upgrade bash
sudo dpkg-query -l | tee installed_packages.log
sudo nano installed_packages.log

#Enable the firewall
sudo apt install ufw
sudo ufw enable
sudo ufw default deny incoming
sudo netstat -a | tee ports.log
sudo nano ports.log
sudo lsof -i -P -n | grep LISTEN | tee Open_Ports.txt
sudo nano Open_Ports.txt
sudo ufw logging on

#Check the cron
cat /etc/crontab | tee cron.log
sudo nano cron.log
echo
echo "If the next command prompts for an editor, select nano."
sudo crontab -e

#Files
sudo locate -i *.mp3 *.m4b *.mov *.jpg *.jpeg *.png *.gif *.pdf *.ogg *.txt *.avi *.mov *.mp4 *.csv | grep /home/ | tee media.log
sudo locate -i password | tee plaintext.log
sudo nano media.log
sudo nano plaintext.log
sudo visudo

#Configure System Services & Files
sudo chmod 644 /etc/passwd
sudo chmod 640 /etc/shadow
sudo service --status-all | tee services.log
sudo nano services.log
echo
echo "The script will now check for unauthorized users"
read -p "Continue?" -n 1 -r
echo    # (optional) move to a new line
if [[  $REPLY =~ ^[Yy]$ ]]
then
    sudo ./Secondary_Scripts/Sudoers.sh
fi
sudo sed -i '$a kernel.randomize_va_space = 2' /etc/sysctl.conf
sudo sed -i '$a kernel.exec-shield = 1' /etc/sysctl.conf
sudo sed -i '$a net.ipv6.conf.all.disable_ipv6 = 1' /etc/sysctl.conf
sudo sed -i '$a net.ipv6.conf.default.disable_ipv6 = 1' /etc/sysctl.conf
sudo sed -i '$a net.ipv6.conf.lo.disable_ipv6 = 1' /etc/sysctl.conf
sudo sed -i '$a net.ipv4.conf.all.rp_filter = 1' /etc/sysctl.conf
sudo sed -i '$a net.ipv4.conf.all.accept_source_route = 0' /etc/sysctl.conf
sudo sed -i '$a net.ipv4.tcp_max_syn_backlog = 2048' /etc/sysctl.conf
sudo sed -i '$a net.ipv4.tcp_synack_retries = 2' /etc/sysctl.conf
sudo sed -i '$a net.ipv4.tcp_syn_retries = 5' /etc/sysctl.conf
sudo sed -i '$a net.ipv4.tcp_syncookies = 1' /etc/sysctl.conf
sudo sed -i '$a net.ipv4.ip_foward = 0' /etc/sysctl.conf
sudo sed -i '$a net.ipv4.conf.all.send_redirects = 0' /etc/sysctl.conf
sudo sed -i '$a net.ipv4.conf.default.send_redirects = 0' /etc/sysctl.conf
sudo sed -i '$a net.ipv4.icmp_echo_ignore_broadcasts = 1' /etc/sysctl.conf
sudo sed -i '$a net.ipv4.icmp_ignore_bogus_error_messages = 1' /etc/sysctl.conf
sudo sed -i '$a net.ipv4.conf.all.log_martians = 1' /etc/sysctl.conf

#OpenSSH
echo
read -p "Are you configuring OpenSSH?" -n 1 -r
echo    # (optional) move to a new line
if [[  $REPLY =~ ^[Yy]$ ]]
then
    sudo apt install openssh-server -y
    sudo ufw allow ssh
    echo
    echo "Please follow along with the helper script."
    echo
    sleep 10
    sudo nano /etc/ssh/sshd_config
else
    sudo apt purge openssh-server
fi

#Set the Password Policies
sudo sed -i '/^PASS_MAX_DAYS/ c\PASS_MAX_DAYS   30' /etc/login.defs
sudo sed -i '/^PASS_MIN_DAYS/ c\PASS_MIN_DAYS   10'  /etc/login.defs
sudo sed -i '/^PASS_WARN_AGE/ c\PASS_WARN_AGE   7' /etc/login.defs
sudo sed -i '/^FAILLOG_ENAB/ c\FAILLOG_ENAB yes' /etc/login.defs
sudo sed -i '/^LOG_OK_LOGINS/ c\LOG_OK_LOGINS yes' /etc/login.defs
sudo sed -i '/^LOG_UNKFAIL_ENAB/ c\LOG_UNKFAIL_ENAB yes' /etc/login.defs
sudo sed -i '/^SYSLOG_SU_ENAB/ c\SYSLOG_SU_ENAB yes' /etc/login.defs
sudo sed -i '/^SYSLOG_SG_ENAB/ c\SYSLOG_SG_ENAB yes' /etc/login.defs
sudo sed -i '/^ENCRYPT_METHOD/ c\ENCRYPT_METHOD SHA512' /etc/login.defs
echo
echo "Setting the account lockout policy. If no points are awarded, please change the value to 1800. If points are still not awarded, set the value back to 0"
sleep 20
sudo sed -i '$a auth required pam_tally2.so deny=5 onerr=fail unlock_time=1800' /etc/pam.d/common-auth
echo
read -p "Would you like to configure password complexity?" -n 1 -r
echo    # (optional) move to a new line
if [[  $REPLY =~ ^[Yy]$ ]]
then
    sudo nano /etc/pam.d/common-password
    sudo nano /etc/security/pwquality.conf
    sudo passwd -l root
fi

#LightDM
echo
read -p "Is LightDM the current display manager?" -n 1 -r
echo    # (optional) move to a new line
if [[  $REPLY =~ ^[Yy]$ ]]
then
    sudo sed -i '$a allow-guest=false' /etc/lightdm/lightdm.conf
    sudo sed -i '$a greeter-hide-users=true' /etc/lightdm/lightdm.conf
fi

#Uninstall Packages
echo
read -p "Would you like to uninstall malicious packages? Note that some packages may be required, so pay attention." -n 1 -r
echo    # (optional) move to a new line
if [[  $REPLY =~ ^[Yy]$ ]]
then
    sudo ./Secondary_Scripts/Uninstall.sh programs.txt
fi