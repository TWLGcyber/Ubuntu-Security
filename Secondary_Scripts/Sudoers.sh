#!/bin/bash


touch /tmp/listofusers

cut -d: -f1,3 /etc/passwd | egrep ':[0-9]{4}$' | cut -d: -f1 > /tmp/listofusers

echo root >> /tmp/listofusers

visudo #make sure sudoers file is correct. No "NOPASSWD" Also, comment out the lines: "Admins May Gain Root Privilages"

nano /tmp/listofusers #Chk for unauthorized users
