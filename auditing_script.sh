#! /bin/bash

# This script has been written to automate the auditing of the stand-alone Fedora machines that have been hardened with the
# 'hardening_script.sh' script.  It will generate an 'audit_results.txt' file which can be reviewed to confirm the hardening
# is still applied.

#########################################################################################################################################

# Confirming that the script has been run with sudo

if [[ $EUID -ne 0 ]]; then
	echo "You need to run this script as root (with sudo)"
	exit
fi

echo "[i] Beginning the auditing process"


#########################################################################################################################################

touch ./audit_results.txt
echo "[i] Getting the current system time and date: " | tee -a ./audit_results.txt
date | tee -a ./audit_results.txt
echo "This script has been run on the following machine: " | tee -a ./audit_results.txt
echo "$hostname" | tee -a ./audit_results.txt
echo "[i] Getting a list of all non-system users: " | tee -a ./audit_results.txt
eval getent passwd {$(awk '/^UID_MIN/ {print $2}' /etc/login.defs)..$(awk '/^UID_MAX/ {print $2}' /etc/login.defs)} | cut -d: -f1 | tee -a ./audit_results.txt

#########################################################################################################################################

# 1.1.1.1 	Ensure mounting of cramfs filesystems is disabled"

echo "############################################################################" >> ./audit_results.txt

echo "[i] Confirming that cramfs filesystems are disabled from mounting" | tee -a ./audit_results.txt
echo "[i] Output from the 'modprobe -n -v cramfs' command is: " | tee -a ./audit_results.txt

modprobe -n -v cramfs | tee -a ./audit_results.txt

echo "[!!!] The above result should read 'install /bin/true'.  If not, this control is not applied" | tee -a ./audit_results.txt

if modprobe -n -v cramfs | grep -q 'install /bin/true'; then
	echo "[YES] The control is applied correctly" | tee -a ./audit_results.txt
else
	echo "[NO] The control doesn't appear to be applied correctly" | tee -a ./audit_results.txt
fi
 
echo "[i] Confirming the cramfs module is not loaded in the kernel" | tee -a ./audit_results.txt
echo "[i] Output from the 'lsmod | grep cramfs' command is: " | tee -a ./audit_results.txt

lsmod | grep cramfs | tee -a ./audit_results.txt

echo "[!!!] The output above should be blank.  If not, the cramfs module is being loaded in the kernel and this control is not applied" | tee -a ./audit_results.txt

var=$(lsmod | grep cramfs)

if [ -z "$var" ]; then
	echo "[YES] Output is blank, therefore the control is applied" | tee -a ./audit_results.txt
else
	echo "[NO] Output is NOT blank, therefore the control is NOT applied" | tee -a ./audit_results.txt
fi

#---------------------------------------------------------------------------------------------------------------------------------------#

# 1.1.1.2 Ensure mounting of freevxfs filesystems is disabled"

echo "############################################################################" >> ./audit_results.txt

echo "[i] Confirming that freevxfs filesystems are disabled from mounting" | tee -a ./audit_results.txt
echo "[i] Output from the 'modprobe -n -v freevxfs' command is: " | tee -a ./audit_results.txt

modprobe -n -v freevxfs | tee -a ./audit_results.txt

echo "[!!!] The above result should read 'install /bin/true'.  If not, this control is not applied" | tee -a ./audit_results.txt

if modprobe -n -v freevxfs | grep -q 'install /bin/true'; then
	echo "[YES]" The control is applied correctly" | tee -a ./audit_results.txt
else
	echo "[NO]" The control doesn't appear to be applied correctly" | tee -a ./audit_results.txt
fi

echo "[i] Confirming the freevxfs module is not loaded in the kernel" | tee -a ./audit_results.txt
echo "[i] Output from the 'lsmod | grep freevxfs' command is: " | tee -a ./audit_results.txt

lsmod | grep freevxfs | tee -a ./audit_results.txt

echo "[!!!] The output above should be blank.  If not, the freevxfs module is being loaded in the kernel and this control is not applied" | tee -a ./audit_results.txt

var=$(lsmod | grep freevxfs)

if [ -z "$var" ]; then
	echo "[YES] Output is blank, therefore the control is applied" | tee -a ./audit_results.txt
else
	echo "[NO] Output is NOT blank, therefore the control is NOT applied" | tee -a ./audit_results.txt
fi

#---------------------------------------------------------------------------------------------------------------------------------------#

# 1.1.1.3 Ensure mounting of jffs2 filesystems is disabled

echo "############################################################################" >> ./audit_results.txt

echo "[i] Confirming that jffs2 filesystems are disabled from mounting" | tee -a ./audit_results.txt
echo "[i] Output from the 'modprobe -n -v jffs2' command is: " | tee -a ./audit_results.txt

modprobe -n -v jffs2 | tee -a ./audit_results.txt

echo "[!!!] The above result should read 'install /bin/true'.  If not, this control is not applied" | tee -a ./audit_results.txt

if modprobe -n -v jffs2 | grep -q 'install /bin/true'; then
	echo "[YES]" The control is applied correctly" | tee -a ./audit_results.txt
else
	echo "[NO]" The control doesn't appear to be applied correctly" | tee -a ./audit_results.txt
fi

echo "[i] Confirming the jffs2 module is not loaded in the kernel" | tee -a ./audit_results.txt
echo "[i] Output from the 'lsmod | grep jffs2' command is: " | tee -a ./audit_results.txt

lsmod | grep jffs2 | tee -a ./audit_results.txt

echo "[!!!] The output above should be blank.  If not, the jffs2 module is being loaded in the kernel and this control is not applied" | tee -a ./audit_results.txt

var=$(lsmod | grep jffs2)

if [ -z "$var" ]; then
	echo "[YES] Output is blank, therefore the control is applied" | tee -a ./audit_results.txt
else
	echo "[NO] Output is NOT blank, therefore the control is NOT applied" | tee -a ./audit_results.txt
fi

#---------------------------------------------------------------------------------------------------------------------------------------#

# 1.1.1.4 Ensure mounting of hfs filesystems is disabled

echo "############################################################################" >> ./audit_results.txt

echo "[i] Confirming that hfs filesystems are disabled from mounting" | tee -a ./audit_results.txt
echo "[i] Output from the 'modprobe -n -v hfs' command is: " | tee -a ./audit_results.txt

modprobe -n -v hfs | tee -a ./audit_results.txt

echo "[!!!] The above result should read 'install /bin/true'.  If not, this control is not applied" | tee -a ./audit_results.txt

if modprobe -n -v hfs | grep -q 'install /bin/true'; then
	echo "[YES]" The control is applied correctly" | tee -a ./audit_results.txt
else
	echo "[NO]" The control doesn't appear to be applied correctly" | tee -a ./audit_results.txt
fi

echo "[i] Confirming the hfs module is not loaded in the kernel" | tee -a ./audit_results.txt
echo "[i] Output from the 'lsmod | grep hfs' command is: " | tee -a ./audit_results.txt

lsmod | grep hfs | tee -a ./audit_results.txt

echo "[!!!] The output above should be blank.  If not, the hfs module is being loaded in the kernel and this control is not applied" | tee -a ./audit_results.txt

var=$(lsmod | grep hfs)

if [ -z "$var" ]; then
	echo "[YES] Output is blank, therefore the control is applied" | tee -a ./audit_results.txt
else
	echo "[NO] Output is NOT blank, therefore the control is NOT applied" | tee -a ./audit_results.txt
fi

#---------------------------------------------------------------------------------------------------------------------------------------#

# 1.1.1.5 Ensure mounting of hfsplus filesystems is disabled

echo "############################################################################" >> ./audit_results.txt

echo "[i] Confirming that hfsplus filesystems are disabled from mounting" | tee -a ./audit_results.txt
echo "[i] Output from the 'modprobe -n -v hfsplus' command is: " | tee -a ./audit_results.txt

modprobe -n -v hfsplus | tee -a ./audit_results.txt

echo "[!!!] The above result should read 'install /bin/true'.  If not, this control is not applied" | tee -a ./audit_results.txt

if modprobe -n -v hfsplus | grep -q 'install /bin/true'; then
	echo "[YES]" The control is applied correctly" | tee -a ./audit_results.txt
else
	echo "[NO]" The control doesn't appear to be applied correctly" | tee -a ./audit_results.txt
fi

echo "[i] Confirming the hfsplus module is not loaded in the kernel" | tee -a ./audit_results.txt
echo "[i] Output from the 'lsmod | grep hfsplus' command is: " | tee -a ./audit_results.txt

lsmod | grep hfsplus | tee -a ./audit_results.txt

echo "[!!!] The output above should be blank.  If not, the hfsplus module is being loaded in the kernel and this control is not applied" | tee -a ./audit_results.txt

var=$(lsmod | grep hfsplus)

if [ -z "$var" ]; then
	echo "[YES] Output is blank, therefore the control is applied" | tee -a ./audit_results.txt
else
	echo "[NO] Output is NOT blank, therefore the control is NOT applied" | tee -a ./audit_results.txt
fi

#---------------------------------------------------------------------------------------------------------------------------------------#

# 1.1.1.6 Ensure mounting of squashfs filesystems is disabled

echo "############################################################################" >> ./audit_results.txt

echo "[i] Confirming that squashfs filesystems are disabled from mounting" | tee -a ./audit_results.txt
echo "[i] Output from the 'modprobe -n -v squashfs' command is: " | tee -a ./audit_results.txt

modprobe -n -v squashfs | tee -a ./audit_results.txt

echo "[!!!] The above result should read 'install /bin/true'.  If not, this control is not applied" | tee -a ./audit_results.txt

if modprobe -n -v squashfs | grep -q 'install /bin/true'; then
	echo "[YES] The control is applied correctly" | tee -a ./audit_results.txt
else
	echo "[NO] The control doesn't appear to be applied correctly" | tee -a ./audit_results.txt
fi

echo "[i] Confirming the squashfs module is not loaded in the kernel" | tee -a ./audit_results.txt
echo "[i] Output from the 'lsmod | grep squashfs' command is: " | tee -a ./audit_results.txt

lsmod | grep squashfs | tee -a ./audit_results.txt

echo "[i] The output above should be blank.  If not, the squashfs module is being loaded in the kernel and this control is not applied" | tee -a ./audit_results.txt

var=$(lsmod | grep squashfs)

if [ -z "$var" ]; then
	echo "[YES] Output is blank, therefore the control is applied" | tee -a ./audit_results.txt
else
	echo "[NO] Output is NOT blank, therefore the control is NOT applied" | tee -a ./audit_results.txt
fi

#---------------------------------------------------------------------------------------------------------------------------------------#

# 1.1.1.7 Ensure mounting of udf filesystems is disabled

echo "############################################################################" >> ./audit_results.txt

echo "[i] Confirming that udf filesystems are disabled from mounting" | tee -a ./audit_results.txt
echo "[i] Output from the 'modprobe -n -v udf' command is: " | tee -a ./audit_results.txt

modprobe -n -v udf | tee -a ./audit_results.txt

echo "[i] The above result should read 'install /bin/true'.  If not, this control is not applied" | tee -a ./audit_results.txt

if modprobe -n -v udf | grep -q 'install /bin/true'; then
	echo "[YES]" The control is applied correctly" | tee -a ./audit_results.txt
else
	echo "[NO]" The control doesn't appear to be applied correctly" | tee -a ./audit_results.txt
fi

echo "[i] Confirming the udf module is not loaded in the kernel" | tee -a ./audit_results.txt
echo "[i] Output from the 'lsmod | grep udf' command is: " | tee -a ./audit_results.txt

lsmod | grep udf | tee -a ./audit_results.txt

echo "[i] The output above should be blank.  If not, the hfs module is being loaded in the kernel and this control is not applied" | tee -a ./audit_results.txt

var=$(lsmod | grep udf)

if [ -z "$var" ]; then
	echo "[YES] Output is blank, therefore the control is applied" | tee -a ./audit_results.txt
else
	echo "[NO] Output is NOT blank, therefore the control is NOT applied" | tee -a ./audit_results.txt
fi

#---------------------------------------------------------------------------------------------------------------------------------------#

echo "1.1.1.8 Ensure mounting of FAT filesystems is disabled"

# This control isn't being applied as part of the hardening so an audit isn't necessary.

#echo "[i] Confirming that vfat filesystems are disabled from mounting" | tee -a ./audit_results.txt
#echo "[i] Output from the 'modprobe -n -v vfat' command is: " | tee -a ./audit_results.txt

#modprobe -n -v vfat | tee -a ./audit_results.txt

#echo "[i] The above result should read 'install /bin/true'.  If not, this control is not applied" | tee -a ./audit_results.txt

#if modprobe -n -v vfat | grep -q 'install /bin/true'; then
#	echo "[YES]" The control is applied correctly" | tee -a ./audit_results.txt
#else
#	echo "[NO]" The control doesn't appear to be applied correctly" | tee -a ./audit_results.txt
#fi

#echo "[i] Confirming the vfat module is not loaded in the kernel" | tee -a ./audit_results.txt
#echo "[i] Output from the 'lsmod | grep vfat' command is: " | tee -a ./audit_results.txt

#lsmod | grep vfat | tee -a ./audit_results.txt

#echo "[i] The output above should be blank.  If not, the vfat module is being loaded in the kernel and this control is not applied" | tee -a ./audit_results.txt

#var=$(lsmod | grep vfat)

#if [ -z "$var" ]; then
#	echo "[YES] Output is blank, therefore the control is applied" | tee -a ./audit_results.txt
#else
#	echo "[NO] Output is NOT blank, therefore the control is NOT applied" | tee -a ./audit_results.txt
#fi

#########################################################################################################################################

# 1.1.3 Ensure nodev option set on /tmp partition
# 1.1.4 Ensure nosuid option set on /tmp partition
# 1.1.5 Ensure noexec option set on /tmp partition

# This control isn't being applied due to a bug in Red Hat.  However the script will still check the control is applied because I believe
# it is applied by default anyway

echo "############################################################################" >> ./audit_results.txt

echo "[i] Confirming that nodev, nosuid and noexec options are set on the /tmp partition" | tee -a ./audit_results.txt
echo "[i] Output of the 'mount | grep /tmp' command is: " | tee -a ./audit_results.txt

mount | grep /tmp | tee -a ./audit_results.txt

echo "[i] The output above should include 'nosuid, nodev, noexec'.  If not, the control isn't applied" | tee -a ./audit_results.txt

var=$(mount | grep /tmp)

if [[ $var == *"nosuid"* ]]; then
	echo "[YES] nosuid appears to be set" | tee -a ./audit_results.txt
else
	echo "[NO] nosuid doesn't appear to be set" | tee -a ./audit_results.txt
fi

if [[ $var == *"nodev"* ]]; then
	echo "[YES] nodev appears to be set" | tee -a ./audit_results.txt
else
	echo "[NO] nodev doesn't appear to be set" | tee -a ./audit_results.txt
fi

if [[ $var == *"noexec"* ]]; then
	echo "[YES] noexec appears to be set" | tee -a ./audit_results.txt
else
	echo "[NO] noexec doesn't appear to be set" | tee -a ./audit_results.txt
fi

#---------------------------------------------------------------------------------------------------------------------------------------#

# 1.1.8 Ensure nodev option set on /var/tmp partition
# 1.1.9 Ensure nosuid option set on /var/tmp partition
# 1.1.10 Ensure noexec option set on /var/tmp partition

echo "############################################################################" >> ./audit_results.txt

echo "[i] Confirming that nodev, nosuid and noexec options are set on the /var/tmp partition" | tee -a ./audit_results.txt
echo "[i] Output of the 'mount | grep /tmp' command is: " | tee -a ./audit_results.txt

mount | grep /var/tmp | tee -a ./audit_results.txt

echo "[i] The output above should include 'nosuid, nodev, noexec'.  If not, the control isn't applied" | tee -a ./audit_results.txt

var=$(mount | grep /var/tmp)

if [[ $var == *"nosuid"* ]]; then
	echo "[YES] nosuid appears to be set" | tee -a ./audit_results.txt
else
	echo "[NO] nosuid doesn't appear to be set" | tee -a ./audit_results.txt
fi

if [[ $var == *"nodev"* ]]; then
	echo "[YES] nodev appears to be set" | tee -a ./audit_results.txt
else
	echo "[NO] nodev doesn't appear to be set" | tee -a ./audit_results.txt
fi

if [[ $var == *"noexec"* ]]; then
	echo "[YES] noexec appears to be set" | tee -a ./audit_results.txt
else
	echo "[NO] noexec doesn't appear to be set" | tee -a ./audit_results.txt
fi

#---------------------------------------------------------------------------------------------------------------------------------------#

# 1.1.14 Ensure nodev option set on /home partition

echo "############################################################################" >> ./audit_results.txt

echo "[i] Confirming that nodev is set on the /home partition" | tee -a ./audit_results.txt
echo "[i] Output of the 'mount | grep /home' command is: "

mount | grep /home | tee -a ./audit_results.txt

echo "[!!!] The output above should include 'nodev'.  If not, the control isn't applied" | tee -a ./audit_results.txt

var=$(mount | grep /home)

if [[ $var == *"nodev"* ]]; then
	echo "[YES] nodev appears to be set" | tee -a ./audit_results.txt
else
	echo "[NO] nodev doesn't appear to be set" | tee -a ./audit_results.txt
fi

#---------------------------------------------------------------------------------------------------------------------------------------#

# 1.1.15 Ensure nodev option set on /dev/shm partition
# 1.1.16 Ensure nosuid option set on /dev/shm partition
# 1.1.17 Ensure noexec option set on /dev/shm partition

echo "############################################################################" >> ./audit_results.txt

echo "[i] Confirming that nodev, nosuid and noexec options are set on the /dev/shm partition" | tee -a ./audit_results.txt
echo "[i] Output of the 'mount | grep /dev/shm' command is: " | tee -a ./audit_results.txt

mount | grep /dev/shm | tee -a ./audit_results.txt

echo "[!!!] The output above should include 'nosuid, nodev, noexec'.  If not, the control isn't applied" | tee -a ./audit_results.txt

var=$(mount | grep /dev/shm)

if [[ $var == *"nosuid"* ]]; then
	echo "[YES] nosuid appears to be set" | tee -a ./audit_results.txt
else
	echo "[NO] nosuid doesn't appear to be set" | tee -a ./audit_results.txt
fi

if [[ $var == *"nodev"* ]]; then
	echo "[YES] nodev appears to be set" | tee -a ./audit_results.txt
else
	echo "[NO] nodev doesn't appear to be set" | tee -a ./audit_results.txt
fi

if [[ $var == *"noexec"* ]]; then
	echo "[YES] noexec appears to be set" | tee -a ./audit_results.txt
else
	echo "[NO] noexec doesn't appear to be set" | tee -a ./audit_results.txt
fi

#---------------------------------------------------------------------------------------------------------------------------------------#

# 1.1.21 Ensure sticky bit is set on all world-writable directories

echo "############################################################################" >> ./audit_results.txt

echo "[i] Confirming that sticky bit is set on all world-writable directories" | tee -a ./audit_results.txt
echo "[i] Output of the audit command is: " | tee -a ./audit_results.txt

df --local -P | awk {'if (NR!=1) print $6'} | xargs -I '{}' find '{}' -xdev -type d \( -perm -0002 -a ! -perm -1000 \) 2>/dev/null | tee -a ./audit_results.txt

echo "[i] The output of the above command should be blank if the sticky bit is set correctly" | tee -a ./audit_results.txt

var=$(df --local -P | awk {'if (NR!=1) print $6'} | xargs -I '{}' find '{}' -xdev -type d \( -perm -0002 -a ! -perm -1000 \) 2>/dev/null)

if [ -z "$var" ]; then
	echo "[YES] Output is blank, therefore the control is applied" | tee -a ./audit_results.txt
else
	echo "[NO] Output is NOT blank, therefore the control is NOT applied" | tee -a ./audit_results.txt
fi

#########################################################################################################################################

# 1.2.2 Ensure gpgcheck is globally activated

echo "############################################################################" >> ./audit_results.txt

echo "[i] Confirming that sticky bit is set on all world-writable directories" | tee -a ./audit_results.txt
echo "[i] Output of the gpgcheck command is: " | tee -a ./audit_results.txt

grep ^gpgcheck /etc/yum.conf | tee -a ./audit_results.txt

echo "[i] The above output must have 'gpgcheck=1' if the control is implemented correctly" | tee -a ./audit_results.txt

var=$(grep ^gpgcheck /etc/yum.conf)

if [[ "$var" == "gpgcheck=1" ]]; then
	echo "[YES] Control is set correctly" | tee -a ./audit_results.txt
else
	echo "[NO] The control doesn't appear to be set correctly" | tee -a ./audit_results.txt
fi

#########################################################################################################################################

# 1.3.1 Ensure AIDE is installed

echo "############################################################################" >> ./audit_results.txt

echo "[i] Confirming AIDE is installed" | tee -a ./audit_results.txt
echo "[i] Output of the 'rpm -q aide' command is: " | tee -a ./audit_results.txt

rpm -q aide | tee -a ./audit_results.txt

echo "[i] Output from the above command must be 'aide-<version>' to confirm that AIDE is installed" | tee -a ./audit_results.txt

var=$(rpm -q aide)

if [[ $var == *"aide-"* ]]; then
	echo "[YES] AIDE appears to be installed" | tee -a ./audit_results.txt
else
	echo "[NO] AIDE doesn't appear to be installed" | tee -a ./audit_results.txt
fi

#---------------------------------------------------------------------------------------------------------------------------------------#

# 1.3.2 Ensure filesystem integrity is regularly checked

echo "############################################################################" >> ./audit_results.txt

echo "[i] Confirming AIDE is regularly checked" | tee -a ./audit_results.txt
echo "[i] Output of the 'crontab -u' command is: " | tee -a ./audit_results.txt

crontab - u root -l | grep aide | tee -a ./audit_results.txt

echo "[i] NEED TO KNOW WHAT THE OUTPUT FROM THIS IS AND THEN ADD AN IF STATEMENT TO CHECK IF ITS CORRECT"

grep -r aide /etc/cron.* /etc/crontab | tee -a ./audit_results.txt

echo "[i] NEED TO KNOW WHAT THE OUTPUT FROM THIS IS AND THEN ADD AN IF STATEMENT TO CHECK IF ITS CORRECT"

# NEEDS COMPLETING

#########################################################################################################################################

# 1.4.1 Ensure permissions on bootloader config are configured

echo "############################################################################" >> ./audit_results.txt

echo "[i] Confirming permissions are set correctly on the bootloader config" | tee -a ./audit_results.txt
echo "[i] Output of the 'stat' command is: " | tee -a ./audit_results.txt

stat /boot/efi/EFI/fedora/grub.cfg | tee -a ./audit_results.txt

echo "[i] In the above output, the Uid and Gid must both be '0' and 'root' and 'access' does not grant permissions to 'group' or 'other'" | tee -a ./audit_results.txt

var=$(stat /boot/efi/EFI/fedora/grub.cfg)

if [[ "$var" == "Access: (0600/-rw-------) Uid: ( 0/ root) Gid: ( 0/ root)" ]]; then
	echo "[YES] Bootloader permissions appear to be set correctly" | tee -a ./audit_results.txt
else
	echo "[NO] Bootloader permissions do NOT appear to be set correctly" | tee -a ./audit_results.txt
fi

#---------------------------------------------------------------------------------------------------------------------------------------#

# 1.4.2 Ensure bootloader password is set

echo "############################################################################" >> ./audit_results.txt

echo "[i] Confirming the bootloader password is set: " | tee -a ./audit-results.txt
echo "[i] Output of the grep command against the 'grub.cfg' file is: " | tee -a ./audit-results.txt

grep "^GRUB2_PASSWORD" /boot/efi/EFI/fedora/grub.cfg | tee -a ./audit-results.txt

echo "[i] The above output should be 'GRUB2_PASSWORD=<encrypted-password>" | tee -a ./audit_results.txt

var=$(grep "^GRUB2_PASSWORD" /boot/efi/EFI/fedora/grub.cfg)

if [[ $var == *"GRUB2_PASSWORD="* ]]; then
	echo "[YES] Bootloader password appears to be set" | tee -a ./audit_results.txt
else
	echo "[NO] Bootloader password doesn't appear to be set" | tee -a ./audit_results.txt
fi

#---------------------------------------------------------------------------------------------------------------------------------------#

# 1.4.3 Ensure authentication required for single user mode

echo "############################################################################" >> ./audit_results.txt

echo "[i] Confirming that 'single user mode' requires authentication" | tee -a ./audit_results.txt
echo "[i] Checking that '/sbin/sulogin' is set within 'rescue.service': " | tee -a ./audit_results.txt

grep /sbin/sulogin /usr/lib/systemd/system/rescue.service | tee -a ./audit_results.txt

echo "[i] the above output must include /sbin/sulogin otherwise the control isn't set" | tee -a ./audit_results.txt

var=$(grep /sbin/sulogin /usr/lib/systemd/system/rescue.service)

if [[ "$var" == "ExecStart=-/bin/sh -c \"/sbin/sulogin; /usr/bin/systemctl --fail --no-block default"; then
	echo "[YES] /sbin/sulogin appears to be set within 'rescue.service'" | tee -a ./audit_results.txt
else
	echo "[NO] /sbin/sulogin appears NOT to be set within 'rescue.service'" | tee -a ./audit_results.txt
fi

echo "[i] STILL confirming that 'single user mode' requires authentication" | tee -a ./audit_results.txt
echo "[i] Checking that '/sbin/sulogin' is set within 'emergency.service': " | tee -a ./audit_results.txt

grep /sbin/sulogin /usr/lib/systemd/system/emergency.service | tee -a ./audit_results.txt

echo "[i] the above output must include /sbin/sulogin otherwise the control isn't set" | tee -a ./audit_results.txt

var=$(grep /sbin/sulogin /usr/lib/systemd/system/emergency.service)

if [[ "$var" == "ExecStart=-/bin/sh -c \"/sbin/sulogin; /usr/bin/systemctl --fail --no-block default"; then
	echo "[YES] /sbin/sulogin appears to be set within 'emergency.service'" | tee -a ./audit_results.txt
else
	echo "[NO] /sbin/sulogin appears NOT to be set within 'emergency.service'" | tee -a ./audit_results.txt
fi

#########################################################################################################################################

# 1.5.1 Ensure core dumps are restricted

echo "############################################################################" >> ./audit_results.txt

echo "[i] Confirming that core dumps are restricted" | tee -a ./audit_results.txt
echo "[i] Running grep command to get info from /etc/security/limits.conf: " | tee -a ./audit_results.txt

grep "hard core" /etc/security/limits.conf | tee -a ./audit_results.txt

echo "Output from above command should be '* hard core 0' if the control is applied correctly" | tee -a ./audit_results.txt

var=$(grep "hard core" /etc/security/limits.conf)

if [[ "$var" == "* hard core 0" ]]; then
	echo "[YES] The control appears to be set correctly" | tee -a ./audit_results.txt
else
	echo "[NO] The control doesn't appear to be set correctly" | tee -a ./audit_results.txt
fi

echo "[i] Running sysctl command to get info from fs.suid_dumpable: " | tee -a ./audit_results.txt

sysctl fs.suid_dumpable | tee -a ./audit_results.txt

echo "[i] Output from the above command should be 'fs.suid_dumpable = 0' if the control is set correctly" | tee -a ./audit_results.txt

var=$(sysctl fs.suid_dumpable)

if [[ "$var" == "fs.suid_dumpable = 0" ]]; then
	echo "[YES] The control appears to be set correctly" | tee -a ./audit_results.txt
else
	echo "[NO] The control doesn't appear to be set correctly" | tee -a ./audit_results.txt
fi

echo "[i] Running grep command to get info from /etc/sysctl.conf: " | tee -a ./audit_results.txt

grep "fs\.suid_dumpable" /etc/sysctl.conf | tee -a ./audit_results.txt

echo "Output from above command should be 'fs.suid_dumpable = 0' if the control is applied correctly" | tee -a ./audit_results.txt

var=$(grep "hard core" /etc/security/limits.conf)

if [[ "$var" == "fs.suid_dumpable = 0" ]]; then
	echo "[YES] The control appears to be set correctly" | tee -a ./audit_results.txt
else
	echo "[NO] The control doesn't appear to be set correctly" | tee -a ./audit_results.txt
fi

#---------------------------------------------------------------------------------------------------------------------------------------#

# 1.5.3 Ensure address space layout randomization (ASLR) is enabled

echo "############################################################################" >> ./audit_results.txt

echo "[i] Confirming that address space layout randomisation (ASLR) is enabled" | tee -a ./audit_results.txt
echo "[i] Running sysctl command to get info from kernel.randomize_va_space: " | tee -a ./audit_results.txt

sysctl kernel.randomize_va_space | tee -a ./audit_results.txt

echo "Output from above command should be 'kernel.randomize_va_space = 2' if the control is applied correctly" | tee -a ./audit_results.txt

var=$(sysctl kernel.randomize_va_space)

if [[ "$var" == "kernel.randomize_va_space = 2" ]]; then
	echo "[YES] The control appears to be set correctly" | tee -a ./audit_results.txt
else
	echo "[NO] The control doesn't appear to be set correctly" | tee -a ./audit_results.txt
fi

echo "[i] Running grep command to get info from /etc/sysctl.conf: " | tee -a ./audit_results.txt

grep "kernel\.randomize_va_space" /etc/sysctl.conf | tee -a ./audit_results.txt

echo "[i] Output from the above command should be 'kernel.randomize_va_space = 2' if the control is set correctly" | tee -a ./audit_results.txt

var=$(grep "kernel\.randomize_va_space" /etc/sysctl.conf)

if [[ "$var" == "kernel.randomize_va_space = 2" ]]; then
	echo "[YES] The control appears to be set correctly" | tee -a ./audit_results.txt
else
	echo "[NO] The control doesn't appear to be set correctly" | tee -a ./audit_results.txt
fi

#---------------------------------------------------------------------------------------------------------------------------------------#

# 1.5.4 Ensure prelink is disabled

echo "############################################################################" >> ./audit_results.txt

echo "[i] Confirming that prelink isn't installed" | tee -a ./audit_results.txt
echo "[i] Running rpm to get prelink package info: " | tee -a ./audit_results.txt

rpm -q prelink | tee -a ./audit_results.txt

echo "Output from above command should be 'package prelink is not installed'" | tee -a ./audit_results.txt

var=$(rpm -q prelink)

if [[ "$var" == "package prelink is not installed" ]]; then
	echo "[YES] prelink is not installed" | tee -a ./audit_results.txt
else
	echo "[NO] prelink IS installed" | tee -a ./audit_results.txt
fi

#########################################################################################################################################

# 1.7.1.1 Ensure message of the day is configured properly
# 1.7.1.2 Ensure local login warning banner is configured properly
# 1.7.1.3 Ensure remote login warning banner is configured properly

echo "############################################################################" >> ./audit_results.txt

echo "[i] Confirming that message of the day, local login warning banner & the remote login warning banner are set" | tee -a ./audit_results.txt
echo "[i] Getting the message of the day: " | tee -a ./audit_results.txt

cat /etc/motd | tee -a ./audit_results.txt

echo "[i] Manually confirm the above output matches required policy" | tee -a ./audit_results.txt

echo "[i] Getting the local login warning banner: " | tee -a ./audit_results.txt

cat /etc/issue | tee -a ./audit_results.txt

echo "[i] Manually confirm the above output and ensure it matches required policy" | tee -a ./audit_results.txt

echo "[i] Getting the remote login warning banner: " | tee -a ./audit_results.txt

cat /etc/issue.net | tee -a ./audit_results.txt

echo "[i] Manually confirm the above output and ensure it matches required policy" | tee -a ./audit_results.txt

#---------------------------------------------------------------------------------------------------------------------------------------#

# 1.7.1.4 Ensure permissions on /etc/motd are configured
# 1.7.1.5 Ensure permissions on /etc/issue are configured

echo "############################################################################" >> ./audit_results.txt

echo "[i] Confirming permissions are set correctly on /etc/motd" | tee -a ./audit_results.txt
echo "[i] Output of the 'stat' command is: " | tee -a ./audit_results.txt

stat /etc/motd | tee -a ./audit_results.txt

echo "[i] In the above output, the Uid and Gid must both be '0' and 'root' and 'access' should be permissioned as 644'" | tee -a ./audit_results.txt

var=$(stat /etc/motd)

if [[ "$var" == "Access: (0644/-rw-r--r--) Uid: ( 0/ root) Gid: ( 0/ root)" ]]; then
	echo "[YES] /etc/motd permissions appear to be set correctly" | tee -a ./audit_results.txt
else
	echo "[NO] /etc/motd permissions do NOT appear to be set correctly" | tee -a ./audit_results.txt
fi

echo "[i] Confirming permissions are set correctly on /etc/issue" | tee -a ./audit_results.txt
echo "[i] Output of the 'stat' command is: " | tee -a ./audit_results.txt

stat /etc/issue | tee -a ./audit_results.txt 

echo "[i] In the above output, the Uid and Gid must both be '0' and 'root' and 'access' should be permissioned as 644'" | tee -a ./audit_results.txt

var=$(stat /etc/motd)

if [[ "$var" == "Access: (0644/-rw-r--r--) Uid: ( 0/ root) Gid: ( 0/ root)" ]]; then
	echo "[YES] /etc/motd permissions appear to be set correctly" | tee -a ./audit_results.txt
else
	echo "[NO] /etc/motd permissions do NOT appear to be set correctly" | tee -a ./audit_results.txt
fi

#---------------------------------------------------------------------------------------------------------------------------------------#

# 1.7.2 Ensure GDM login banner is configured

echo "############################################################################" >> ./audit_results.txt

echo "[i] Confirming GDM login banner is configured" | tee -a ./audit_results.txt
echo "[i] Reviewing the /etc/dconf/profile/gdm file: " | tee -a ./audit_results.txt

cat /etc/dconf/profile/gdm | tee -a ./audit_results.txt

echo "[i] The above output must include 'user-db:user', 'system-db:gdm' & 'file-db:/usr/share/ddm/greeter-dconf-defaults'" | tee -a ./audit_results.txt

if cat /etc/dconf/profile/gdm | grep -q 'user-db:user'; then
	echo "[YES] 'user-db:user' appears to be set correctly" | tee -a ./audit_results.txt
else
	echo "[NO] 'user-db:user' doesn't appear to be set" | tee -a ./audit_results.txt
fi

if cat /etc/dconf/profile/gdm | grep -q 'system-db:gdm'; then
	echo "[YES] 'system-db:gdm' appears to be set correctly" | tee -a ./audit_results.txt
else
	echo "[NO] 'system-db:gdm' doesn't appear to be set" | tee -a ./audit_results.txt
fi

if cat /etc/dconf/profile/gdm | grep -q 'file-db:/usr/share/gdm/greeter-dconf-defaults'; then
	echo "[YES] 'file-db:/usr/share/gdm/greeter-dconf-defaults' appears to be set correctly" | tee -a ./audit_results.txt
else
	echo "[NO] 'file-db:/usr/share/gdm/greeter-dconf-defaults' doesn't appear to be set" | tee -a ./audit_results.txt
fi

echo "[i] Reviewing the /etc/dconf/db/gdm.d/01-banner-message file: " | tee -a ./audit_results.txt

cat /etc/dconf/db/gdm.d/01-banner-message | tee -a ./audit_results.txt

echo "[i] The above output must include '[org/gnome/login-screen', 'banner-message-enable=true' & 'banner-message-text=[policy compliant text]'" | tee -a ./audit_results.txt
echo "[i] Manually review the 'banner-message-text=' and confirm it meets required policy" | tee -a ./audit_results.txt

if cat /etc/dconf/db/gdm.d/01-banner-message | grep -q '[org/gnome/login-screen]'; then
	echo "[YES] '[org/gnome/login-screen]' appears to be set correctly" | tee -a ./audit_results.txt
else
	echo "[NO] '[org/gnome/login-screen]' doesn't appear to be set" | tee -a ./audit_results.txt
fi

if cat /etc/dconf/db/gdm.d/01-banner-message | grep -q 'banner-message-enable=true'; then
	echo "[YES] 'banner-message-enable=true' appears to be set correctly" | tee -a ./audit_results.txt
else
	echo "[NO] 'banner-message-enable=true' doesn't appear to be set" | tee -a ./audit_results.txt
fi

#########################################################################################################################################

# 1.8.1 Ensure updates, patches, and additional security software are installed

echo "############################################################################" >> ./audit_results.txt

echo "[i] Confirming all security updates are installed" | tee -a ./audit_results.txt
echo "[i] Running 'check-update' command: " | tee -a ./audit_results.txt

yum check-update --security | tee -a ./audit_results.txt

# NEED TO KNOW WHAT THE EXPECTED OUTPUT HERE IS.  I IMAGINE ITS PRETTY VERBOSE SO MIGHT BE DIFFICULT TO RIGHT AN IF STATEMENT UNLESS
# IT SAYS SOMETHING LIKE 'SYSTEM IS FULLY UP TO DATE'

#########################################################################################################################################

# 2.1.1 Ensure chargen services are not enabled
# 2.1.2 Ensure daytime services are not enabled
# 2.1.3 Ensure discard services are not enabled
# 2.1.4 Ensure echo services are not enabled
# 2.1.5 Ensure time services are not enabled
# 2.1.6 Ensure tftp server is not enabled

echo "############################################################################" >> ./audit_results.txt

echo "[i] Confirming all necessary inetd services are disabled" | tee -a ./audit_results.txt
echo "[i] Running 'chkconfig' command: " | tee -a ./audit_results.txt

chkconfig --list | tee -a ./audit_results.txt

echo "[i] The above output should show that chargen, daytime, discard, echo, time and tftp services are 'off'" | tee -a ./audit_results.txt

if chkconfig --list | grep -q 'chargen-dgram: off'; then
	echo "[YES] chargen datagrams are off" | tee -a ./audit_results.txt
else
	echo "[NO] chargen datagrams are on" | tee -a ./audit_results.txt
fi

if chkconfig --list | grep -q 'chargen-stream: off'; then
	echo "[YES] chargen streams are off" | tee -a ./audit_results.txt
else
	echo "[NO] chargen streams are on" | tee -a ./audit_results.txt
fi

if chkconfig --list | grep -q 'daytime-dgram: off'; then
	echo "[YES] daytime datagrams are off" | tee -a ./audit_results.txt
else
	echo "[NO] daytime datagrams are on" | tee -a ./audit_results.txt
fi

if chkconfig --list | grep -q 'daytime-stream: off'; then
	echo "[YES] daytime streams are off" | tee -a ./audit_results.txt
else
	echo "[NO] daytime streams are on" | tee -a ./audit_results.txt
fi

if chkconfig --list | grep -q 'discard-dgram: off'; then
	echo "[YES] discard datagrams are off" | tee -a ./audit_results.txt
else
	echo "[NO] discard datagrams are on" | tee -a ./audit_results.txt
fi

if chkconfig --list | grep -q 'discard-stream: off'; then
	echo "[YES] discard streams are off" | tee -a ./audit_results.txt
else
	echo "[NO] discard streams are on" | tee -a ./audit_results.txt
fi

if chkconfig --list | grep -q 'echo-dgram: off'; then
	echo "[YES] echo datagrams are off" | tee -a ./audit_results.txt
else
	echo "[NO] echo datagrams are on" | tee -a ./audit_results.txt
fi

if chkconfig --list | grep -q 'echo-stream: off'; then
	echo "[YES] echo streams are off" | tee -a ./audit_results.txt
else
	echo "[NO] echo streams are on" | tee -a ./audit_results.txt
fi

if chkconfig --list | grep -q 'time-dgram: off'; then
	echo "[YES] time datagrams are off" | tee -a ./audit_results.txt
else
	echo "[NO] time datagrams are on" | tee -a ./audit_results.txt
fi

if chkconfig --list | grep -q 'time-stream: off'; then
	echo "[YES] time streams are off" | tee -a ./audit_results.txt
else
	echo "[NO] time streams are on" | tee -a ./audit_results.txt
fi

if chkconfig --list | grep -q 'tftp: off'; then
	echo "[YES] tftp is off" | tee -a ./audit_results.txt
else
	echo "[NO] tftp is on" | tee -a ./audit_results.txt
fi

#---------------------------------------------------------------------------------------------------------------------------------------#

# 2.1.7 Ensure xinetd is not enabled

echo "############################################################################" >> ./audit_results.txt

echo "[i] Confirming inetd is disabled" | tee -a ./audit_results.txt
echo "[i] Running 'systemctl is enabled xinetd' command: " | tee -a ./audit_results.txt

systemctl is-enabled xinetd | tee -a ./audit_results.txt

echo "[i] Output from the above command should state that it is disabled" | tee -a ./audit_results.txt

var=$(systemctl is-enabled xinetd)

if [[ "$var" == "disabled" ]]; then
	echo "[YES] xinetd is disabled"
else
	echo "[NO] xinetd is NOT disabled"
fi

#########################################################################################################################################

# 2.2.1.2 Ensure ntp is configured

echo "############################################################################" >> ./audit_results.txt

echo "[i] Confirming ntp is configured correctly" | tee -a ./audit_results.txt
echo "[i] Auditing the ntp.conf file: " | tee -a ./audit_results.txt

grep "^restrict" /etc/ntp.conf | tee -a ./audit_results.txt

echo "[i] Output from the above command should read: " | tee -a ./audit_results.txt
echo "		restrict -4 default kod nomidify notrap nopeer noquery" | tee -a ./audit_results.txt
echo "		restrict -6 default kod nomodify notrap nopeer noquery" | tee -a ./audit_results.txt

if grep "^restrict" /etc/ntp.conf | grep -q 'restrict -4 default kod nomodify notrap nopeer noquery'; then
	echo "[YES] IPv4 restrictions are set correctly" | tee -a ./audit_results.txt
else
	echo "[NO] IPv4 restrictions are NOT set correctly" | tee -a ./audit_results.txt
fi

if grep "^restrict" /etc/ntp.conf | grep -q 'restrict -6 default kod nomodify notrap nopeer noquery'; then
	echo "[YES] IPv6 restrictions are set correctly" | tee -a ./audit_results.txt
else
	echo "[NO] IPv6 restrictions are NOT set correctly" | tee -a ./audit_results.txt
fi

echo "[i] The following ntp servers are set: " | tee -a ./audit_results.txt

grep "^server" /etc/ntp.conf | tee -a ./audit_results.txt

echo "[i] You should manually confirm that these are the correct approved ntp servers to use" | tee -a ./audit_results.txt

echo "[i] Confirming that the correct options are set in /etc/sysconfig/ntpd" | tee -a ./audit_results.txt

grep "^OPTIONS" /etc/sysconfig/ntpd | tee -a ./audit_results.txt

echo "[i] The above output should have '-u ntp:ntp' set within the options" | tee -a ./audit_results.txt

if grep "^OPTIONS" /etc/ntp.conf | grep -q 'OPTIONS=\"-u ntp:ntp\"'; then
	echo "[YES] OPTIONS appear to be set correctly" | tee -a ./audit_results.txt
else
	echo "[NO] The OPTIONS do NOT appear to be set correctly" | tee -a ./audit_results.txt
fi

#---------------------------------------------------------------------------------------------------------------------------------------#

# 2.2.1.3 Ensure chrony is configured 

echo "############################################################################" >> ./audit_results.txt

echo "[i] Confirming chrony is configured correctly" | tee -a ./audit_results.txt
echo "[i] The following remote servers are set: " | tee -a ./audit_results.txt

grep "^server" /etc/chrony.conf | tee -a ./audit_results.txt

echo "[i] You should manually confirm that these are the correct approved remote servers to use" | tee -a ./audit_results.txt

echo "[i] Confirming that the correct options are set in /etc/sysconfig/chronyd" | tee -a ./audit_results.txt

grep "^OPTIONS" /etc/sysconfig/chronyd | tee -a ./audit_results.txt

echo "[i] The above output should have '-u chrony' set within the options" | tee -a ./audit_results.txt

if grep "^OPTIONS" /etc/ntp.conf | grep -q 'OPTIONS=\"-u chrony\"'; then
	echo "[YES] OPTIONS appear to be set correctly" | tee -a ./audit_results.txt
else
	echo "[NO] The OPTIONS do NOT appear to be set correctly" | tee -a ./audit_results.txt
fi

#########################################################################################################################################

# 2.2.3 Ensure Avahi Server is not enabled

echo "############################################################################" >> ./audit_results.txt

echo "[i] Confirming Avahi Server is disabled" | tee -a ./audit_results.txt
echo "[i] Running 'systemctl is enabled avahi-daemon' command: " | tee -a ./audit_results.txt

systemctl is-enabled avahi-daemon | tee -a ./audit_results.txt

echo "[i] Output from the above command should state that it is disabled" | tee -a ./audit_results.txt

var=$(systemctl is-enabled avahi-daemon)

if [[ "$var" == "disabled" ]]; then
	echo "[YES] Avahi Server is disabled" | tee -a ./audit_results.txt
else
	echo "[NO] Avahi Server is NOT disabled" | tee -a ./audit_results.txt
fi

#---------------------------------------------------------------------------------------------------------------------------------------#

# 2.2.5 Ensure DHCP Server is not enabled

echo "############################################################################" >> ./audit_results.txt

echo "[i] Confirming DHCP Server is disabled" | tee -a ./audit_results.txt
echo "[i] Running 'systemctl is enabled dhcp' command: " | tee -a ./audit_results.txt

systemctl is-enabled dhcp | tee -a ./audit_results.txt

echo "[i] Output from the above command should state that it is disabled" | tee -a ./audit_results.txt

var=$(systemctl is-enabled dhcp)

if [[ "$var" == "disabled" ]]; then
	echo "[YES] DHCP Server is disabled" | tee -a ./audit_results.txt
else
	echo "[NO] DHCP Server is NOT disabled" | tee -a ./audit_results.txt
fi

#---------------------------------------------------------------------------------------------------------------------------------------#

# 2.2.6 Ensure LDAP service is not enabled

echo "############################################################################" >> ./audit_results.txt

echo "[i] Confirming LDAP Server is disabled" | tee -a ./audit_results.txt
echo "[i] Running 'systemctl is enabled slapd' command: " | tee -a ./audit_results.txt

systemctl is-enabled slapd | tee -a ./audit_results.txt

echo "[i] Output from the above command should state that it is disabled" | tee -a ./audit_results.txt

var=$(systemctl is-enabled slapd)

if [[ "$var" == "disabled" ]]; then
	echo "[YES] LDAP Server is disabled" | tee -a ./audit_results.txt
else
	echo "[NO] LDAP Server is NOT disabled" | tee -a ./audit_results.txt
fi

#---------------------------------------------------------------------------------------------------------------------------------------#

# 2.2.7 Ensure NFS and RPC are not enabled 

echo "############################################################################" >> ./audit_results.txt

echo "[i] Confirming NFS and RPC are disabled" | tee -a ./audit_results.txt
echo "[i] Running 'systemctl is enabled nfs' command: " | tee -a ./audit_results.txt

systemctl is-enabled nfs | tee -a ./audit_results.txt

echo "[i] Output from the above command should state that it is disabled" | tee -a ./audit_results.txt

var=$(systemctl is-enabled nfs)

if [[ "$var" == "disabled" ]]; then
	echo "[YES] nfs is disabled" | tee -a ./audit_results.txt
else
	echo "[NO] nfs is NOT disabled" | tee -a ./audit_results.txt
fi

echo "[i] Running 'systemctl is enabled nfs-server' command: " | tee -a ./audit_results.txt

systemctl is-enabled nfs-server | tee -a ./audit_results.txt

echo "[i] Output from the above command should state that it is disabled" | tee -a ./audit_results.txt

var=$(systemctl is-enabled nfs-server)

if [[ "$var" == "disabled" ]]; then
	echo "[YES] nfs-server is disabled" | tee -a ./audit_results.txt
else
	echo "[NO] nfs-server is NOT disabled" | tee -a ./audit_results.txt
fi

echo "[i] Running 'systemctl is enabled rpcbind' command: " | tee -a ./audit_results.txt

systemctl is-enabled rpcbind | tee -a ./audit_results.txt

echo "[i] Output from the above command should state that it is disabled" | tee -a ./audit_results.txt

var=$(systemctl is-enabled rpcbind)

if [[ "$var" == "disabled" ]]; then
	echo "[YES] RPC is disabled" | tee -a ./audit_results.txt
else
	echo "[NO] RPC is NOT disabled" | tee -a ./audit_results.txt
fi

#---------------------------------------------------------------------------------------------------------------------------------------#

# 2.2.8 Ensure DNS Server is not enabled 

echo "############################################################################" >> ./audit_results.txt

echo "[i] Confirming DNS Server is disabled" | tee -a ./audit_results.txt
echo "[i] Running 'systemctl is-enabled named' command: " | tee -a ./audit_results.txt

systemctl is-enabled named | tee -a ./audit_results.txt

echo "[i] Output from the above command should state that it is disabled" | tee -a ./audit_results.txt

var=$(systemctl is-enabled named)

if [[ "$var" == "disabled" ]]; then
	echo "[YES] DNS Server is disabled" | tee -a ./audit_results.txt
else
	echo "[NO] DNS Server is NOT disabled" | tee -a ./audit_results.txt
fi

#---------------------------------------------------------------------------------------------------------------------------------------#

# 2.2.9 Ensure FTP Server is not enabled

echo "############################################################################" >> ./audit_results.txt

echo "[i] Confirming FTP Server is disabled" | tee -a ./audit_results.txt
echo "[i] Running 'systemctl is-enabled vsftpd' command: " | tee -a ./audit_results.txt

systemctl is-enabled vsftpd | tee -a ./audit_results.txt

echo "[i] Output from the above command should state that it is disabled" | tee -a ./audit_results.txt

var=$(systemctl is-enabled vsftpd)

if [[ "$var" == "disabled" ]]; then
	echo "[YES] FTP Server is disabled" | tee -a ./audit_results.txt
else
	echo "[NO] FTP Server is NOT disabled" | tee -a ./audit_results.txt
fi

#---------------------------------------------------------------------------------------------------------------------------------------#

# 2.2.10 Ensure HTTP Server is not enabled

echo "############################################################################" >> ./audit_results.txt

echo "[i] Confirming HTTP Server is disabled" | tee -a ./audit_results.txt
echo "[i] Running 'systemctl is-enabled httpd' command: " | tee -a ./audit_results.txt

systemctl is-enabled httpd | tee -a ./audit_results.txt

echo "[i] Output from the above command should state that it is disabled" | tee -a ./audit_results.txt

var=$(systemctl is-enabled httpd)

if [[ "$var" == "disabled" ]]; then
	echo "[YES] HTTP Server is disabled" | tee -a ./audit_results.txt
else
	echo "[NO] HTTP Server is NOT disabled" | tee -a ./audit_results.txt
fi

#---------------------------------------------------------------------------------------------------------------------------------------#

# 2.2.11 Ensure IMAP and POP3 server is not enabled

echo "############################################################################" >> ./audit_results.txt

echo "[i] Confirming IMAP and POP3 Server is disabled" | tee -a ./audit_results.txt
echo "[i] Running 'systemctl is-enabled dovecot' command: " | tee -a ./audit_results.txt

systemctl is-enabled dovecot | tee -a ./audit_results.txt

echo "[i] Output from the above command should state that it is disabled" | tee -a ./audit_results.txt

var=$(systemctl is-enabled dovecot)

if [[ "$var" == "disabled" ]]; then
	echo "[YES] IMAP and POP3 Server is disabled" | tee -a ./audit_results.txt
else
	echo "[NO] IMAP and POP3 Server is NOT disabled" | tee -a ./audit_results.txt
fi

#---------------------------------------------------------------------------------------------------------------------------------------#

# 2.2.12 Ensure Samba is not enabled

echo "############################################################################" >> ./audit_results.txt

echo "[i] Confirming Samba is disabled" | tee -a ./audit_results.txt
echo "[i] Running 'systemctl is-enabled smb' command: " | tee -a ./audit_results.txt

systemctl is-enabled smb | tee -a ./audit_results.txt

echo "[i] Output from the above command should state that it is disabled" | tee -a ./audit_results.txt

var=$(systemctl is-enabled smb)

if [[ "$var" == "disabled" ]]; then
	echo "[YES] Samba is disabled" | tee -a ./audit_results.txt
else
	echo "[NO] Samba is NOT disabled" | tee -a ./audit_results.txt
fi

#---------------------------------------------------------------------------------------------------------------------------------------#

# 2.2.13 Ensure HTTP Proxy Server is not enabled

echo "############################################################################" >> ./audit_results.txt

echo "[i] Confirming HTTP Proxy Server is disabled" | tee -a ./audit_results.txt
echo "[i] Running 'systemctl is-enabled squid' command: " | tee -a ./audit_results.txt

systemctl is-enabled squid | tee -a ./audit_results.txt

echo "[i] Output from the above command should state that it is disabled" | tee -a ./audit_results.txt

var=$(systemctl is-enabled squid)

if [[ "$var" == "disabled" ]]; then
	echo "[YES] HTTP Proxy Server is disabled" | tee -a ./audit_results.txt
else
	echo "[NO] HTTP Proxy Server is NOT disabled" | tee -a ./audit_results.txt
fi

#---------------------------------------------------------------------------------------------------------------------------------------#

# 2.2.14 Ensure SNMP Server is not enabled

echo "############################################################################" >> ./audit_results.txt

echo "[i] Confirming SNMP Server is disabled" | tee -a ./audit_results.txt
echo "[i] Running 'systemctl is-enabled snmpd' command: " | tee -a ./audit_results.txt

systemctl is-enabled snmpd | tee -a ./audit_results.txt

echo "[i] Output from the above command should state that it is disabled" | tee -a ./audit_results.txt

var=$(systemctl is-enabled snmpd)

if [[ "$var" == "disabled" ]]; then
	echo "[YES] SNMP Server is disabled" | tee -a ./audit_results.txt
else
	echo "[NO] SNMP Server is NOT disabled" | tee -a ./audit_results.txt
fi

#---------------------------------------------------------------------------------------------------------------------------------------#

# 2.2.15 Ensure mail transfer agent is configured for local-only mode

echo "############################################################################" >> ./audit_results.txt

echo "[i] Confirming mail transfer agent is configured for local-only mode" | tee -a ./audit_results.txt
echo "[i] Running 'netstat' command: " | tee -a ./audit_results.txt

netstat -an | grep LIST | grep ":25[[:space:]]" | tee -a ./audit_results.txt

echo "[i] Output from the above command should read 'tcp 0 0 127.0.0.1:25 0.0.0.0:* LISTEN'" | tee -a ./audit_results.txt

var=$(netstat -an | grep LIST | grep ":25[[:space:]]")

if [[ "$var" == "tcp 0 0 127.0.0.1:25 0.0.0.0:* LISTEN" ]]; then
	echo "[YES] Mail transfer agent appears to be set in local-only mode" | tee -a ./audit_results.txt
else
	echo "[NO] Mail transfer agent appears NOT to be set in local-only mode" | tee -a ./audit_results.txt
fi

#---------------------------------------------------------------------------------------------------------------------------------------#

# 2.2.16 Ensure rsync service is not enabled

echo "############################################################################" >> ./audit_results.txt

echo "[i] Confirming rsync service is disabled" | tee -a ./audit_results.txt
echo "[i] Running 'systemctl is-enabled ypserv' command: " | tee -a ./audit_results.txt

systemctl is-enabled ypserv | tee -a ./audit_results.txt

echo "[i] Output from the above command should state that it is disabled" | tee -a ./audit_results.txt

var=$(systemctl is-enabled ypserv)

if [[ "$var" == "disabled" ]]; then
	echo "[YES] rsync service is disabled" | tee -a ./audit_results.txt
else
	echo "[NO] rsync service is NOT disabled" | tee -a ./audit_results.txt
fi

#---------------------------------------------------------------------------------------------------------------------------------------#

# 2.2.17 Ensure NIS Server is not enabled

echo "############################################################################" >> ./audit_results.txt

echo "[i] Confirming rsh Server is disabled" | tee -a ./audit_results.txt
echo "[i] Running 'systemctl is-enabled rsh.socket' command: " | tee -a ./audit_results.txt

systemctl is-enabled rsh.socket | tee -a ./audit_results.txt

echo "[i] Output from the above command should state that it is disabled" | tee -a ./audit_results.txt

var=$(systemctl is-enabled rsh.socket)

if [[ "$var" == "disabled" ]]; then
	echo "[YES] rsh.socket is disabled" | tee -a ./audit_results.txt
else
	echo "[NO] rsh.socket is NOT disabled" | tee -a ./audit_results.txt
fi

echo "[i] Running 'systemctl is-enabled rlogin.socket' command: " | tee -a ./audit_results.txt

systemctl is-enabled rlogin.socket | tee -a ./audit_results.txt

echo "[i] Output from the above command should state that it is disabled" | tee -a ./audit_results.txt

var=$(systemctl is-enabled rlogin.socket)

if [[ "$var" == "disabled" ]]; then
	echo "[YES] rlogin.socket is disabled" | tee -a ./audit_results.txt
else
	echo "[NO] rlogin.socket is NOT disabled" | tee -a ./audit_results.txt
fi

echo "[i] Running 'systemctl is-enabled rexec.socket' command: " | tee -a ./audit_results.txt

systemctl is-enabled rexec.socket | tee -a ./audit_results.txt

echo "[i] Output from the above command should state that it is disabled" | tee -a ./audit_results.txt

var=$(systemctl is-enabled rexec.socket)

if [[ "$var" == "disabled" ]]; then
	echo "[YES] rexec.socket is disabled" | tee -a ./audit_results.txt
else
	echo "[NO] rexec.socket is NOT disabled" | tee -a ./audit_results.txt
fi

#---------------------------------------------------------------------------------------------------------------------------------------#

# 2.2.18 Ensure talk server is not enabled 

echo "############################################################################" >> ./audit_results.txt

echo "[i] Confirming talk Server is disabled" | tee -a ./audit_results.txt
echo "[i] Running 'systemctl is-enabled ntalk' command: " | tee -a ./audit_results.txt

systemctl is-enabled ntalk | tee -a ./audit_results.txt

echo "[i] Output from the above command should state that it is disabled" | tee -a ./audit_results.txt

var=$(systemctl is-enabled ntalk)

if [[ "$var" == "disabled" ]]; then
	echo "[YES] talk server is disabled" | tee -a ./audit_results.txt
else
	echo "[NO] talk server is NOT disabled" | tee -a ./audit_results.txt
fi

#---------------------------------------------------------------------------------------------------------------------------------------#

# 2.2.19 Ensure telnet server is not enabled 

echo "############################################################################" >> ./audit_results.txt

echo "[i] Confirming telnet Server is disabled" | tee -a ./audit_results.txt
echo "[i] Running 'systemctl is-enabled telnet.socket' command: " | tee -a ./audit_results.txt

systemctl is-enabled telnet.socket | tee -a ./audit_results.txt

echo "[i] Output from the above command should state that it is disabled" | tee -a ./audit_results.txt

var=$(systemctl is-enabled telnet.socket)

if [[ "$var" == "disabled" ]]; then
	echo "[YES] telnet server is disabled" | tee -a ./audit_results.txt
else
	echo "[NO] telnet server is NOT disabled" | tee -a ./audit_results.txt
fi

#---------------------------------------------------------------------------------------------------------------------------------------#

# 2.2.20 Ensure tftp server is not enabled 

echo "############################################################################" >> ./audit_results.txt

echo "[i] Confirming tftp Server is disabled" | tee -a ./audit_results.txt
echo "[i] Running 'systemctl is-enabled tftp.socket' command: " | tee -a ./audit_results.txt

systemctl is-enabled tftp.socket | tee -a ./audit_results.txt

echo "[i] Output from the above command should state that it is disabled" | tee -a ./audit_results.txt

var=$(systemctl is-enabled tftp.socket)

if [[ "$var" == "disabled" ]]; then
	echo "[YES] tftp server is disabled" | tee -a ./audit_results.txt
else
	echo "[NO] tftp server is NOT disabled" | tee -a ./audit_results.txt
fi

#---------------------------------------------------------------------------------------------------------------------------------------#

# 2.2.21 Ensure rsync service is not enabled 

echo "############################################################################" >> ./audit_results.txt

echo "[i] Confirming rsync service is disabled" | tee -a ./audit_results.txt
echo "[i] Running 'systemctl is-enabled rsyncd' command: " | tee -a ./audit_results.txt

systemctl is-enabled rsyncd | tee -a ./audit_results.txt

echo "[i] Output from the above command should state that it is disabled" | tee -a ./audit_results.txt

var=$(systemctl is-enabled rsyncd)

if [[ "$var" == "disabled" ]]; then
	echo "[YES] rsync service is disabled" | tee -a ./audit_results.txt
else
	echo "[NO] rsync service is NOT disabled" | tee -a ./audit_results.txt
fi

#########################################################################################################################################

# 2.3.1 Ensure NIS Client is not installed

echo "############################################################################" >> ./audit_results.txt

echo "[i] Confirming that NIS Client isn't installed" | tee -a ./audit_results.txt
echo "[i] Running rpm to get ypbind package info: " | tee -a ./audit_results.txt

rpm -q ypbind | tee -a ./audit_results.txt

echo "Output from above command should be 'package ypbind is not installed'" | tee -a ./audit_results.txt

var=$(rpm -q ypbind)

if [[ "$var" == "package ypbind is not installed" ]]; then
	echo "[YES] NIS Client is not installed" | tee -a ./audit_results.txt
else
	echo "[NO] NIS Client IS installed" | tee -a ./audit_results.txt
fi

#---------------------------------------------------------------------------------------------------------------------------------------#

# 2.3.2 Ensure rsh client is not installed

echo "############################################################################" >> ./audit_results.txt

echo "[i] Confirming that rsh Client isn't installed" | tee -a ./audit_results.txt
echo "[i] Running rpm to get rsh package info: " | tee -a ./audit_results.txt

rpm -q rsh | tee -a ./audit_results.txt

echo "Output from above command should be 'package rsh is not installed'" | tee -a ./audit_results.txt

var=$(rpm -q rsh)

if [[ "$var" == "package rsh is not installed" ]]; then
	echo "[YES] rsh Client is not installed" | tee -a ./audit_results.txt
else
	echo "[NO] rsh Client IS installed" | tee -a ./audit_results.txt
fi

#---------------------------------------------------------------------------------------------------------------------------------------#

# 2.3.3 Ensure talk client is not installed

echo "############################################################################" >> ./audit_results.txt

echo "[i] Confirming that talk Client isn't installed" | tee -a ./audit_results.txt
echo "[i] Running rpm to get talk package info: " | tee -a ./audit_results.txt

rpm -q talk | tee -a ./audit_results.txt

echo "Output from above command should be 'package talk is not installed'" | tee -a ./audit_results.txt

var=$(rpm -q talk)

if [[ "$var" == "package talk is not installed" ]]; then
	echo "[YES] talk Client is not installed" | tee -a ./audit_results.txt
else
	echo "[NO] talk Client IS installed" | tee -a ./audit_results.txt
fi

#---------------------------------------------------------------------------------------------------------------------------------------#

# 2.3.4 Ensure telnet client is not installed 

echo "############################################################################" >> ./audit_results.txt

echo "[i] Confirming that telnet Client isn't installed" | tee -a ./audit_results.txt
echo "[i] Running rpm to get telnet package info: " | tee -a ./audit_results.txt

rpm -q telnet | tee -a ./audit_results.txt

echo "Output from above command should be 'package telnet is not installed'" | tee -a ./audit_results.txt

var=$(rpm -q telnet)

if [[ "$var" == "package telnet is not installed" ]]; then
	echo "[YES] telnet Client is not installed" | tee -a ./audit_results.txt
else
	echo "[NO] telnet Client IS installed" | tee -a ./audit_results.txt
fi

#---------------------------------------------------------------------------------------------------------------------------------------#

# 2.3.5 Ensure LDAP client is not installed 

echo "############################################################################" >> ./audit_results.txt

echo "[i] Confirming that LDAP Client isn't installed" | tee -a ./audit_results.txt
echo "[i] Running rpm to get openldap-clients package info: " | tee -a ./audit_results.txt

rpm -q openldap-clients | tee -a ./audit_results.txt

echo "Output from above command should be 'package openldap-clients is not installed'" | tee -a ./audit_results.txt

var=$(rpm -q openldap-clients)

if [[ "$var" == "package openldap-clients is not installed" ]]; then
	echo "[YES] NIS Client is not installed" | tee -a ./audit_results.txt
else
	echo "[NO] NIS Client IS installed" | tee -a ./audit_results.txt
fi

#########################################################################################################################################

# 3.2.1 Ensure source routed packets are not accepted

echo "############################################################################" >> ./audit_results.txt

echo "[i] Confirming that source routed packets are not accepted" | tee -a ./audit_results.txt
echo "[i] Running sysctl command to get relevant information: " | tee -a ./audit_results.txt

sysctl net.ipv4.conf.all.accept_source_route | tee -a ./audit_results.txt

echo "Output from above command should be 'net.ipv4.conf.all.accept_source_route = 0'" | tee -a ./audit_results.txt

var=$(sysctl net.ipv4.conf.all.accept_source_route)

if [[ "$var" == "net.ipv4.conf.all.accept_source_route = 0" ]]; then
	echo "[YES] The accept source control is set correctly" | tee -a ./audit_results.txt
else
	echo "[NO] The accept source control is not set correctly" | tee -a ./audit_results.txt
fi

sysctl net.ipv4.conf.default.accept_source_route | tee -a ./audit_results.txt

echo "Output from above command should be 'net.ipv4.conf.default.accept_source_route = 0'" | tee -a ./audit_results.txt

var=$(sysctl net.ipv4.conf.default.accept_source_route)

if [[ "$var" == "net.ipv4.conf.default.accept_source_route = 0" ]]; then
	echo "[YES] The default source control is set correctly" | tee -a ./audit_results.txt
else
	echo "[NO] The default source control is not set correctly" | tee -a ./audit_results.txt
fi

grep "net\.ipv4\.conf\.all\.accept_source_route" /etc/sysctl.conf | tee -a ./audit_results.txt

echo "Output from above command should be 'net.ipv4.conf.all.accept_source_route= 0'" | tee -a ./audit_results.txt

var=$(grep "net\.ipv4\.conf\.all\.accept_source_route" /etc/sysctl.conf)

if [[ "$var" == "net.ipv4.conf.all.accept_source_route= 0" ]]; then
	echo "[YES] The accept source control is set correctly in the configuration file" | tee -a ./audit_results.txt
else
	echo "[NO] The accept source control is not set correctly in the configuration file" | tee -a ./audit_results.txt
fi

grep "net\.ipv4\.conf\.default\.accept_source_route" /etc/sysctl.conf | tee -a ./audit_results.txt

echo "Output from above command should be 'net.ipv4.conf.default.accept_source_route= 0'" | tee -a ./audit_results.txt

var=$(grep "net\.ipv4\.conf\.default\.accept_source_route" /etc/sysctl.conf)

if [[ "$var" == "net.ipv4.conf.default.accept_source_route= 0" ]]; then
	echo "[YES] The default source control is set correctly in the configuration file" | tee -a ./audit_results.txt
else
	echo "[NO] The default source control is not set correctly in the configuration file" | tee -a ./audit_results.txt
fi

#---------------------------------------------------------------------------------------------------------------------------------------#

# 3.2.2 Ensure ICMP redirects are not accepted

echo "############################################################################" >> ./audit_results.txt

echo "[i] Confirming that ICMP redirects are not accepted" | tee -a ./audit_results.txt
echo "[i] Running sysctl command to get relevant information: " | tee -a ./audit_results.txt

sysctl net.ipv4.conf.all.accept_redirects | tee -a ./audit_results.txt

echo "Output from above command should be 'net.ipv4.conf.all.accept_redirects = 0'" | tee -a ./audit_results.txt

var=$(sysctl net.ipv4.conf.all.accept_redirects)

if [[ "$var" == "net.ipv4.conf.all.accept_redirects = 0" ]]; then
	echo "[YES] The accept redirects control is set correctly" | tee -a ./audit_results.txt
else
	echo "[NO] The accept redirects control is not set correctly" | tee -a ./audit_results.txt
fi

sysctl sysctl net.ipv4.conf.default.accept_redirects | tee -a ./audit_results.txt

echo "Output from above command should be 'net.ipv4.conf.default.accept_redirects = 0'" | tee -a ./audit_results.txt

var=$(sysctl net.ipv4.conf.default.accept_redirects)

if [[ "$var" == "net.ipv4.conf.default.accept_redirects = 0" ]]; then
	echo "[YES] The default redirect control is set correctly" | tee -a ./audit_results.txt
else
	echo "[NO] The default redirect control is not set correctly" | tee -a ./audit_results.txt
fi

grep "net\.ipv4\.conf\.all\.accept_redirects" /etc/sysctl.conf | tee -a ./audit_results.txt

echo "Output from above command should be 'net.ipv4.conf.all.accept_redirects= 0'" | tee -a ./audit_results.txt

var=$(grep "net\.ipv4\.conf\.all\.accept_redirects" /etc/sysctl.conf)

if [[ "$var" == "net.ipv4.conf.all.accept_redirects= 0" ]]; then
	echo "[YES] The accept redirect control is set correctly in the configuration file" | tee -a ./audit_results.txt
else
	echo "[NO] The accept redirect control is not set correctly in the configuration file" | tee -a ./audit_results.txt
fi

grep "net\.ipv4\.conf\.default\.accept_redirects" /etc/sysctl.conf | tee -a ./audit_results.txt

echo "Output from above command should be 'net.ipv4.conf.default.accept_redirects= 0'" | tee -a ./audit_results.txt

var=$(grep "net\.ipv4\.conf\.default\.accept_redirects" /etc/sysctl.conf)

if [[ "$var" == "net.ipv4.conf.default.accept_redirects= 0" ]]; then
	echo "[YES] The default redirect control is set correctly in the configuration file" | tee -a ./audit_results.txt
else
	echo "[NO] The default redirect control is not set correctly in the configuration file" | tee -a ./audit_results.txt
fi

#---------------------------------------------------------------------------------------------------------------------------------------#

# 3.2.3 Ensure secure ICMP redirects are not accepted

echo "############################################################################" >> ./audit_results.txt

echo "[i] Confirming that secure ICMP redirects are not accepted" | tee -a ./audit_results.txt
echo "[i] Running sysctl command to get relevant information: " | tee -a ./audit_results.txt

sysctl net.ipv4.conf.all.secure_redirects | tee -a ./audit_results.txt

echo "Output from above command should be 'net.ipv4.conf.all.secure_redirects = 0'" | tee -a ./audit_results.txt

var=$(sysctl net.ipv4.conf.all.secure_redirects)

if [[ "$var" == "net.ipv4.conf.all.secure_redirects = 0" ]]; then
	echo "[YES] The secure accept redirects control is set correctly" | tee -a ./audit_results.txt
else
	echo "[NO] The secure accept redirects control is not set correctly" | tee -a ./audit_results.txt
fi

sysctl net.ipv4.conf.default.secure_redirects | tee -a ./audit_results.txt

echo "Output from above command should be 'net.ipv4.conf.default.secure_redirects = 0'" | tee -a ./audit_results.txt

var=$(sysctl net.ipv4.conf.default.secure_redirects)

if [[ "$var" == "net.ipv4.conf.default.secure_redirects = 0" ]]; then
	echo "[YES] The secure default redirect control is set correctly" | tee -a ./audit_results.txt
else
	echo "[NO] The secure default redirect control is not set correctly" | tee -a ./audit_results.txt
fi

grep "net\.ipv4\.conf\.all\.secure_redirects" /etc/sysctl.conf | tee -a ./audit_results.txt

echo "Output from above command should be 'net.ipv4.conf.all.secure_redirects= 0'" | tee -a ./audit_results.txt

var=$(grep "net\.ipv4\.conf\.all\.secure_redirects" /etc/sysctl.conf)

if [[ "$var" == "net.ipv4.conf.all.secure_redirects= 0" ]]; then
	echo "[YES] The secure accept redirect control is set correctly in the configuration file" | tee -a ./audit_results.txt
else
	echo "[NO] The secure accept redirect control is not set correctly in the configuration file" | tee -a ./audit_results.txt
fi

grep "net\.ipv4\.conf\.default\.secure_redirects" /etc/sysctl.conf | tee -a ./audit_results.txt

echo "Output from above command should be 'net.ipv4.conf.default.secure_redirects= 0'" | tee -a ./audit_results.txt

var=$(grep "net\.ipv4\.conf\.default\.secure_redirects" /etc/sysctl.conf)

if [[ "$var" == "net.ipv4.conf.default.secure_redirects= 0" ]]; then
	echo "[YES] The secure default redirect control is set correctly in the configuration file" | tee -a ./audit_results.txt
else
	echo "[NO] The secure default redirect control is not set correctly in the configuration file" | tee -a ./audit_results.txt
fi

#---------------------------------------------------------------------------------------------------------------------------------------#

# 3.2.4 Ensure suspicious packets are logged 

echo "############################################################################" >> ./audit_results.txt

echo "[i] Confirming that suspicious packets are logged" | tee -a ./audit_results.txt
echo "[i] Running sysctl command to get relevant information: " | tee -a ./audit_results.txt

sysctl net.ipv4.conf.all.log_martians | tee -a ./audit_results.txt

echo "Output from above command should be 'net.ipv4.conf.all.log_martians = 1'" | tee -a ./audit_results.txt

var=$(sysctl net.ipv4.conf.all.log_martians)

if [[ "$var" == "net.ipv4.conf.all.log_martians = 1" ]]; then
	echo "[YES] The 'all' control is set correctly" | tee -a ./audit_results.txt
else
	echo "[NO] The 'all' control is not set correctly" | tee -a ./audit_results.txt
fi

sysctl net.ipv4.conf.default.log_martians | tee -a ./audit_results.txt

echo "Output from above command should be 'net.ipv4.conf.default.log_martians = 1'" | tee -a ./audit_results.txt

var=$(sysctl net.ipv4.conf.default.log_martians)

if [[ "$var" == "net.ipv4.conf.default.log_martians = 1" ]]; then
	echo "[YES] The 'default' control is set correctly" | tee -a ./audit_results.txt
else
	echo "[NO] The 'default' control is not set correctly" | tee -a ./audit_results.txt
fi

grep "net\.ipv4\.conf\.all\.log_martians" /etc/sysctl.conf | tee -a ./audit_results.txt

echo "Output from above command should be 'net.ipv4.conf.all.log_martians = 1'" | tee -a ./audit_results.txt

var=$(grep "net\.ipv4\.conf\.all\.log_martians" /etc/sysctl.conf)

if [[ "$var" == "net.ipv4.conf.all.log_martians = 1" ]]; then
	echo "[YES] The 'all' control is set correctly in the configuration file" | tee -a ./audit_results.txt
else
	echo "[NO] The 'all' control is not set correctly in the configuration file" | tee -a ./audit_results.txt
fi

grep "net\.ipv4\.conf\.default\.log_martians" /etc/sysctl.conf | tee -a ./audit_results.txt

echo "Output from above command should be 'net.ipv4.conf.default.log_martians = 1'" | tee -a ./audit_results.txt

var=$(grep "net\.ipv4\.conf\.default\.log_martians" /etc/sysctl.conf)

if [[ "$var" == "net.ipv4.conf.default.log_martians = 1" ]]; then
	echo "[YES] The 'default' control is set correctly in the configuration file" | tee -a ./audit_results.txt
else
	echo "[NO] The 'default' control is not set correctly in the configuration file" | tee -a ./audit_results.txt
fi

#---------------------------------------------------------------------------------------------------------------------------------------#

# 3.2.5 Ensure broadcast ICMP requests are ignored

echo "############################################################################" >> ./audit_results.txt

echo "[i] Confirming broadcast ICMP requests are ignored" | tee -a ./audit_results.txt
echo "[i] Running sysctl command to get relevant information: " | tee -a ./audit_results.txt

sysctl net.ipv4.icmp_echo_ignore_broadcasts | tee -a ./audit_results.txt

echo "Output from above command should be 'net.ipv4.icmp_echo_ignore_broadcasts = 1'" | tee -a ./audit_results.txt

var=$(sysctl net.ipv4.icmp_echo_ignore_broadcasts)

if [[ "$var" == "net.ipv4.icmp_echo_ignore_broadcasts = 1" ]]; then
	echo "[YES] ICMP broadcasts are ignored" | tee -a ./audit_results.txt
else
	echo "[NO] ICMP broadcasts are not ignored" | tee -a ./audit_results.txt
fi

grep "net\.ipv4\.icmp_echo_ignore_broadcasts" /etc/sysctl.conf | tee -a ./audit_results.txt

echo "Output from above command should be 'net.ipv4.icmp_echo_ignore_broadcasts = 1'" | tee -a ./audit_results.txt

var=$(grep "net\.ipv4\.icmp_echo_ignore_broadcasts" /etc/sysctl.conf)

if [[ "$var" == "net.ipv4.icmp_echo_ignore_broadcasts = 1" ]]; then
	echo "[YES] The configuration file is configured correctly to ignore ICMP broadcasts" | tee -a ./audit_results.txt
else
	echo "[NO] The configuration file is NOT configured correctly to ignore ICMP broadcasts" | tee -a ./audit_results.txt
fi

#---------------------------------------------------------------------------------------------------------------------------------------#

# 3.2.6 Ensure bogus ICMP responses are ignored

echo "############################################################################" >> ./audit_results.txt

echo "[i] Confirming bogus ICMP responses are ignored" | tee -a ./audit_results.txt
echo "[i] Running sysctl command to get relevant information: " | tee -a ./audit_results.txt

sysctl net.ipv4.icmp_ignore_bogus_error_responses | tee -a ./audit_results.txt

echo "Output from above command should be 'net.ipv4.icmp_ignore_bogus_error_responses = 1'" | tee -a ./audit_results.txt

var=$(sysctl net.ipv4.icmp_ignore_bogus_error_responses)

if [[ "$var" == "net.ipv4.icmp_ignore_bogus_error_responses = 1" ]]; then
	echo "[YES] Bogus ICMP responses are ignored" | tee -a ./audit_results.txt
else
	echo "[NO] Bogus ICMP broadcasts are not ignored" | tee -a ./audit_results.txt
fi

grep "net\.ipv4\.icmp_ignore_bogus_error_responses" /etc/sysctl.conf | tee -a ./audit_results.txt

echo "Output from above command should be 'net.ipv4.icmp_ignore_bogus_error_responses = 1'" | tee -a ./audit_results.txt

var=$(grep "net\.ipv4\.icmp_ignore_bogus_error_responses" /etc/sysctl.conf)

if [[ "$var" == "net.ipv4.icmp_ignore_bogus_error_responses = 1" ]]; then
	echo "[YES] The configuration file is configured correctly to ignore bogus ICMP responses" | tee -a ./audit_results.txt
else
	echo "[NO] The configuration file is NOT configured correctly to ignore bogus ICMP responses" | tee -a ./audit_results.txt
fi

#---------------------------------------------------------------------------------------------------------------------------------------#

# 3.2.7 Ensure Reverse Path Filtering is enabled

echo "############################################################################" >> ./audit_results.txt

echo "[i] Confirming Reverse Path Filtering is enabled" | tee -a ./audit_results.txt
echo "[i] Running sysctl command to get relevant information: " | tee -a ./audit_results.txt

sysctl net.ipv4.conf.all.rp_filter | tee -a ./audit_results.txt

echo "Output from above command should be 'net.ipv4.conf.all.rp_filter = 1'" | tee -a ./audit_results.txt

var=$(sysctl net.ipv4.conf.all.rp_filter)

if [[ "$var" == "net.ipv4.conf.all.rp_filter = 1" ]]; then
	echo "[YES] The 'all' control is set correctly" | tee -a ./audit_results.txt
else
	echo "[NO] The 'all' control is not set correctly" | tee -a ./audit_results.txt
fi

sysctl net.ipv4.conf.default.rp_filter | tee -a ./audit_results.txt

echo "Output from above command should be 'net.ipv4.conf.default.rp_filter = 1'" | tee -a ./audit_results.txt

var=$(sysctl net.ipv4.conf.default.rp_filter)

if [[ "$var" == "net.ipv4.conf.default.rp_filter = 1" ]]; then
	echo "[YES] The 'default' control is set correctly" | tee -a ./audit_results.txt
else
	echo "[NO] The 'default' control is not set correctly" | tee -a ./audit_results.txt
fi

grep "net\.ipv4\.conf\.all\.rp_filter" /etc/sysctl.conf | tee -a ./audit_results.txt

echo "Output from above command should be 'net.ipv4.conf.all.rp_filter = 1'" | tee -a ./audit_results.txt

var=$(grep "net\.ipv4\.conf\.all\.rp_filter" /etc/sysctl.conf)

if [[ "$var" == "net.ipv4.conf.all.rp_filter = 1" ]]; then
	echo "[YES] The 'all' control is set correctly in the configuration file" | tee -a ./audit_results.txt
else
	echo "[NO] The 'all' control is not set correctly in the configuration file" | tee -a ./audit_results.txt
fi

grep "net\.ipv4\.conf\.default\.rp_filter" /etc/sysctl.conf | tee -a ./audit_results.txt

echo "Output from above command should be 'net.ipv4.conf.default.rp_filter = 1'" | tee -a ./audit_results.txt

var=$(grep "net\.ipv4\.conf\.default\.rp_filter" /etc/sysctl.conf)

if [[ "$var" == "net.ipv4.conf.default.rp_filter = 1" ]]; then
	echo "[YES] The 'default' control is set correctly in the configuration file" | tee -a ./audit_results.txt
else
	echo "[NO] The 'default' control is not set correctly in the configuration file" | tee -a ./audit_results.txt
fi

#---------------------------------------------------------------------------------------------------------------------------------------#

# 3.2.8 Ensure TCP SYN Cookies is enabled

echo "############################################################################" >> ./audit_results.txt

echo "[i] Confirming TCP SYN Cookies is enabled" | tee -a ./audit_results.txt
echo "[i] Running sysctl command to get relevant information: " | tee -a ./audit_results.txt

sysctl net.ipv4.tcp_syncookies | tee -a ./audit_results.txt

echo "Output from above command should be 'net.ipv4.tcp_syncookies = 1'" | tee -a ./audit_results.txt

var=$(sysctl net.ipv4.tcp_syncookies)

if [[ "$var" == "net.ipv4.tcp_syncookies = 1" ]]; then
	echo "[YES] TCP SYN Cookies is enabled" | tee -a ./audit_results.txt
else
	echo "[NO] TCP SYN Cookies is NOT enabled" | tee -a ./audit_results.txt
fi

grep "net\.ipv4\.tcp_syncookies" /etc/sysctl.conf | tee -a ./audit_results.txt

echo "Output from above command should be 'net.ipv4.tcp_syncookies = 1'" | tee -a ./audit_results.txt

var=$(grep "net\.ipv4\.tcp_syncookies" /etc/sysctl.conf)

if [[ "$var" == "net.ipv4.tcp_syncookies = 1" ]]; then
	echo "[YES] The configuration file is configured correctly" | tee -a ./audit_results.txt
else
	echo "[NO] The configuration file is NOT configured correctly" | tee -a ./audit_results.txt
fi

#########################################################################################################################################

# 3.4.1 Ensure TCP Wrappers is installed 

echo "############################################################################" >> ./audit_results.txt

echo "[i] Confirming TCP Wrappers is installed" | tee -a ./audit_results.txt
echo "[i] Running rpm command to confirm package status: " | tee -a ./audit_results.txt

rpm -q tcp_wrappers | tee -a ./audit_results.txt

echo "[i] The above output should provide confirmation of the tcp_wrappers version which is currently installed" | tee -a ./audit_results.txt

var=$(rpm -q tcp_wrappers)

if [[ $var == *"tcp_wrappers-"* ]]; then
	echo "[YES] TCP Wrappers is installed" | tee -a ./audit_results.txt
else
	echo "[NO] TCP Wrappers is NOT installed" | tee -a ./audit_results.txt
fi

echo "[i] Confirming TCP Wrappers libraries are installed" | tee -a ./audit_results.txt
echo "[i] Running rpm command to confirm package status: " | tee -a ./audit_results.txt

rpm -q tcp_wrappers-libs | tee -a ./audit_results.txt

echo "[i] The above output should provide confirmation of the tcp_wrappers-libs version which is currently installed" | tee -a ./audit_results.txt

var=$(rpm -q tcp_wrappers-libs)

if [[ $var == *"tcp_wrappers-libs-"* ]]; then
	echo "[YES] TCP Wrappers libraries are installed" | tee -a ./audit_results.txt
else
	echo "[NO] TCP Wrappers libraries are NOT installed" | tee -a ./audit_results.txt
fi

#---------------------------------------------------------------------------------------------------------------------------------------#

# 3.4.2 Ensure /etc/hosts.allow is configured 

echo "############################################################################" >> ./audit_results.txt

echo "[i] Extracting contents of the /etc/hosts.allow file: " | tee -a ./audit_results.txt

cat /etc/hosts.allow | tee -a ./audit_results.txt

echo "[i] The above output must be manually audited to ensure only valid hosts are contained in the /etc/hosts.allow file" | tee -a ./audit_results.txt

#---------------------------------------------------------------------------------------------------------------------------------------#

# 3.4.3 Ensure /etc/hosts.deny is configured 

echo "############################################################################" >> ./audit_results.txt

echo "[i] Confirming that a default deny all is set within the /etc/hosts.deny file" | tee -a ./audit_results.txt
echo "[i] Extracting contents of the /etc/hosts.deny file: " | tee -a ./audit_results.txt

cat /etc/hosts.deny | tee -a ./audit_results.txt

echo "[i] The above output should contain 'ALL: ALL'" | tee -a ./audit_results.txt

var=$(cat /etc/hosts.deny)

if [[ "$var" == "ALL: ALL" ]]; then
	echo "[YES] The hosts.deny is set correctly" | tee -a ./audit_results.txt
else
	echo "[NO] The hosts.deny doesn't have the default deny rule" | tee -a ./audit_results.txt
fi

#---------------------------------------------------------------------------------------------------------------------------------------#

# 3.4.4 Ensure permissions on /etc/hosts.allow are configured

echo "############################################################################" >> ./audit_results.txt

echo "[i] Confirming permissions are set correctly on /etc/hosts.allow" | tee -a ./audit_results.txt
echo "[i] Output of the 'stat' command is: " | tee -a ./audit_results.txt

stat /etc/hosts.allow | tee -a ./audit_results.txt

echo "[i] In the above output, the Uid and Gid must both be '0' and 'root' and 'access' permissions should be 644'" | tee -a ./audit_results.txt

var=$(stat /etc/hosts.allow)

if [[ "$var" == "Access: (0644/-rw-r--r--) Uid: ( 0/ root) Gid: ( 0/ root)" ]]; then
	echo "[YES] hosts.allow permissions appear to be set correctly" | tee -a ./audit_results.txt
else
	echo "[NO] hosts.allow permissions do NOT appear to be set correctly" | tee -a ./audit_results.txt
fi

#---------------------------------------------------------------------------------------------------------------------------------------#

# 3.4.5 Ensure permissions on /etc/hosts.deny are configured

echo "############################################################################" >> ./audit_results.txt

echo "[i] Confirming permissions are set correctly on /etc/hosts.deny" | tee -a ./audit_results.txt
echo "[i] Output of the 'stat' command is: " | tee -a ./audit_results.txt

stat /etc/hosts.deny | tee -a ./audit_results.txt

echo "[i] In the above output, the Uid and Gid must both be '0' and 'root' and 'access' permissions should be 644'" | tee -a ./audit_results.txt

var=$(stat /etc/hosts.deny)

if [[ "$var" == "Access: (0644/-rw-r--r--) Uid: ( 0/ root) Gid: ( 0/ root)" ]]; then
	echo "[YES] hosts.deny permissions appear to be set correctly" | tee -a ./audit_results.txt
else
	echo "[NO] hosts.deny permissions do NOT appear to be set correctly" | tee -a ./audit_results.txt
fi

#---------------------------------------------------------------------------------------------------------------------------------------#

# 3.6.1 Ensure iptables is installed
# 3.6.2 Ensure default deny firewall policy 
# 3.6.3 Ensure loopback traffic is configured 
# 3.6.5 Ensure firewall rules exist for all open ports 

echo "############################################################################" >> ./audit_results.txt

echo "[i] Confirming iptables is installed" | tee -a ./audit_results.txt
echo "[i] Running rpm command to confirm package status: " | tee -a ./audit_results.txt

rpm -q iptables | tee -a ./audit_results.txt

echo "[i] The above output should provide confirmation of the iptables version which is currently installed" | tee -a ./audit_results.txt

var=$(rpm -q iptables)

if [[ $var == *"iptables-"* ]]; then
	echo "[YES] iptables is installed" | tee -a ./audit_results.txt
else
	echo "[NO] iptables is NOT installed" | tee -a ./audit_results.txt
fi

echo "[i] Confirming default deny firewall policy is configured" | tee -a ./audit_results.txt

iptables -L | tee -a ./audit_results.txt

echo "[i] The above output should have a policy of DROP for the INPUT, FORWARD & OUTPUT chains" | tee -a ./audit_results.txt

if iptables -L | grep -q 'Chain INPUT (policy DROP)'; then
	echo "[YES] The INPUT chain policy is correctly set to DROP" | tee -a ./audit_results.txt
else
	echo "[NO] The INPUT chain policy doesn't appear to be set to DROP" | tee -a ./audit_results.txt
fi

if iptables -L | grep -q 'Chain FORWARD (policy DROP)'; then
	echo "[YES] The FORWARD chain policy is correctly set to DROP" | tee -a ./audit_results.txt
else
	echo "[NO] The FORWARD chain policy doesn't appear to be set to DROP" | tee -a ./audit_results.txt
fi

if iptables -L | grep -q 'Chain OUTPUT (policy DROP)'; then
	echo "[YES] The OUTPUT chain policy is correctly set to DROP" | tee -a ./audit_results.txt
else
	echo "[NO] The OUTPUT chain policy doesn't appear to be set to DROP" | tee -a ./audit_results.txt
fi

echo "[i] Confirming loopback traffic is configured" | tee -a ./audit_results.txt
echo "[i] Checking INPUT rules: "

iptables -L INPUT -v -n | tee -a ./audit_results.txt

echo "[i] The output must include the following lines (in order): " | tee -a ./audit_results.txt
echo "		0 0 ACCEPT all -- lo * 	0.0.0.0/0 	0.0.0.0/0" | tee -a ./audit_results.txt
echo "		0 0 DROP all -- * * 127.0.0.0/8 	0.0.0.0/0" | tee -a ./audit_results.txt

if iptables -L INPUT -v -n | grep -q '0 0 ACCEPT all -- lo * 0.0.0.0/0 0.0.0.0/0'; then
	echo "[YES] The ACCEPT rule is included in the INPUT ruleset" | tee -a ./audit_results.txt
else
	echo "[NO] The ACCEPT rule isn't present in the INPUT ruleset" | tee -a ./audit_results.txt
fi

if iptables -L INPUT -v -n | grep -q '0 0 DROP all -- * * 127.0.0.0/8 0.0.0.0/0'; then
	echo "[YES] The DENY rule is included in the INPUT ruleset" | tee -a ./audit_results.txt
else
	echo "[NO] The DENY rule isn't present in the INPUT ruleset" | tee -a ./audit_results.txt
fi

echo "[i] Checking OUTPUT rules: " | tee -a ./audit_results.txt

iptables -L OUTPUT -v -n | tee -a ./audit_results.txt

echo "[i] The output above must include the following line: " | tee -a ./audit_results.txt
echo "		0 0 ACCEPT all -- * lo 0.0.0.0/0 0.0.0.0/0" | tee -a ./audit_results.txt

if iptables -L OUTPUT -v -n | grep -q '0 0 ACCEPT all -- * lo 0.0.0.0/0 0.0.0.0/0'; then
	echo "[YES] The ACCEPT rule is included in the OUTPUT ruleset" | tee -a ./audit_results.txt
else
	echo "[NO] The ACCEPT rule isn't present in the OUTPUT ruleset" | tee -a ./audit_results.txt
fi

echo "[i] Confirming firewall rules exist for all open ports" | tee -a ./audit_results.txt
echo "[i] The following ports are open: " | tee -a ./audit_results.txt

netstat -ln | tee -a ./audit_results.txt

echo "[i] The following firewall rules exist: " | tee -a ./audit_results.txt

iptables -L INPUT -v -n | tee -a ./audit_results.txt

echo "[i] You will need to manually check the open ports (for all ports listening on non-localhost addresses) and confirm there is a firewall rule in place"  | tee -a ./audit_results.txt


#########################################################################################################################################

# 4.2.1.1 Ensure rsyslog Service is enabled 

echo "############################################################################" >> ./audit_results.txt

echo "[i] Confirming rsyslog service is enabled" | tee -a ./audit_results.txt
echo "[i] Running 'systemctl is-enabled rsyslog' command: " | tee -a ./audit_results.txt

systemctl is-enabled rsyslog | tee -a ./audit_results.txt

echo "[i] Output from the above command should state that it is enabled" | tee -a ./audit_results.txt

var=$(systemctl is-enabled rsyslog)

if [[ "$var" == "enabled" ]]; then
	echo "[YES] rsyslog service is enabled" | tee -a ./audit_results.txt
else
	echo "[NO] rsyslog service is NOT enabled" | tee -a ./audit_results.txt
fi

#---------------------------------------------------------------------------------------------------------------------------------------#

# 4.2.1.3 Ensure rsyslog default file permissions configured 

echo "############################################################################" >> ./audit_results.txt

echo "[i] Confirming rsyslog default file permission are configured" | tee -a ./audit_results.txt
echo "[i] Getting information from /etc/rsyslog.conf: " | tee -a ./audit_results.txt

grep ^\$FileCreateMode /etc/rsyslog.conf | tee -a ./audit_results.txt

echo "[i] The output above should have $FileCreateMode set at 0640" | tee -a ./audit_results.txt

if grep ^\$FileCreateMode /etc/rsyslog.conf | grep -q '$FileCreateMode 0640'; then
	echo "[YES] File permissions are set correctly" | tee -a ./audit_results.txt
else
	echo "[NO] File permissions don't appear to be set correctly" | tee -a ./audit_results.txt
fi

#---------------------------------------------------------------------------------------------------------------------------------------#

# 4.2.1.4 Ensure rsyslog is configured to send logs to a remote log host server 
# Not including in the original hardening

#---------------------------------------------------------------------------------------------------------------------------------------#

# 4.2.2.1 Ensure syslog-ng service is enabled

echo "############################################################################" >> ./audit_results.txt

echo "[i] Confirming syslog-ng service is enabled" | tee -a ./audit_results.txt
echo "[i] Running 'systemctl is-enabled syslog-ng' command: " | tee -a ./audit_results.txt

systemctl is-enabled syslog-ng | tee -a ./audit_results.txt

echo "[i] Output from the above command should state that it is enabled" | tee -a ./audit_results.txt

var=$(systemctl is-enabled syslog-ng)

if [[ "$var" == "enabled" ]]; then
	echo "[YES] syslog-ng service is enabled" | tee -a ./audit_results.txt
else
	echo "[NO] syslog-ng service is NOT enabled" | tee -a ./audit_results.txt
fi

#---------------------------------------------------------------------------------------------------------------------------------------#

# 4.2.2.3 Ensure syslog-ng default file permissions configured

echo "############################################################################" >> ./audit_results.txt

echo "[i] Confirming syslog-ng default file permission are configured" | tee -a ./audit_results.txt
echo "[i] Getting information from /etc/syslog-ng/syslog-ng.conf: " | tee -a ./audit_results.txt

grep ^options /etc/syslog-ng/syslog-ng.conf | tee -a ./audit_results.txt

echo "[i] The output above should have the perm option set at 0640" | tee -a ./audit_results.txt

if grep ^options /etc/syslog-ng/syslog-ng.conf | grep -q 'options { chain_hostnames(off); flush_lines(0); perm(0640); stats_freq(3600); threaded(yes); };'; then
	echo "[YES] File permissions are set correctly" | tee -a ./audit_results.txt
else
	echo "[NO] File permissions don't appear to be set correctly" | tee -a ./audit_results.txt
fi

#---------------------------------------------------------------------------------------------------------------------------------------#

# 4.2.3 Ensure rsyslog or syslog-ng is installed

echo "############################################################################" >> ./audit_results.txt

echo "[i] Confirming rsyslog is installed" | tee -a ./audit_results.txt
echo "[i] Running rpm command to confirm package status: " | tee -a ./audit_results.txt

rpm -q rsyslog | tee -a ./audit_results.txt

echo "[i] The above output should provide confirmation of the rsyslog version which is currently installed" | tee -a ./audit_results.txt

var=$(rpm -q rsyslog)

if [[ $var == *"rsyslog-"* ]]; then
	echo "[YES] rsyslog is installed" | tee -a ./audit_results.txt
else
	echo "[NO] rsyslog is NOT installed" | tee -a ./audit_results.txt
fi

echo "[i] Confirming syslog-ng is installed" | tee -a ./audit_results.txt
echo "[i] Running rpm command to confirm package status: " | tee -a ./audit_results.txt

rpm -q syslog-ng | tee -a ./audit_results.txt

echo "[i] The above output should provide confirmation of the syslog-ng version which is currently installed" | tee -a ./audit_results.txt

var=$(rpm -q syslog-ng)

if [[ $var == *"syslog-ng-"* ]]; then
	echo "[YES] syslog-ng is installed" | tee -a ./audit_results.txt
else
	echo "[NO] syslog-ng is NOT installed" | tee -a ./audit_results.txt
fi

#---------------------------------------------------------------------------------------------------------------------------------------#

# 4.2.4 Ensure permissions on all logfiles are configured 









































echo "[i] Setting correct permissions on all log files"

find /var/log -type f -exec chmod g-wx,o-rwx {} +

#########################################################################################################################################

# 5.1.1 Ensure cron daemon is enabled
















echo "[i] Enabling the cron daemon"
systemctl enable cron

#---------------------------------------------------------------------------------------------------------------------------------------#
# 5.1.2 Ensure permissions on /etc/crontab are configured













echo "[i] Setting the correct permissions on /etc/crontab"

chown root:root /etc/crontab
chmod og-rwx /etc/crontab

#---------------------------------------------------------------------------------------------------------------------------------------#
# 5.1.3 Ensure permissions on /etc/cron.hourly are configured

echo "[i] Setting the correct permissions on /etc/cron.hourly"

chown root:root /etc/cron.hourly
chmod og-rwx /etc/cron.hourly

#---------------------------------------------------------------------------------------------------------------------------------------#

# 5.1.4 Ensure permissions on /etc/cron.daily are configured 
echo "[i] Setting the correct permissions on /etc/cron.daily"
chown root:root /etc/cron.daily
chmod og-rwx /etc/cron.daily

#---------------------------------------------------------------------------------------------------------------------------------------#

# 5.1.5 Ensure permissions on /etc/cron.weekly are configured

echo "[i] Setting the correct permissions on /etc/cron.weekly"

chown root:root /etc/cron.weekly
chmod og-rwx /etc/cron.weekly

#---------------------------------------------------------------------------------------------------------------------------------------#

# 5.1.6 Ensure permissions on /etc/cron.monthly are configured

echo "[i] Setting the correct permissions on /etc/cron.monthly"

chown root:root /etc/cron.monthly
chmod og-rwx /etc/cron.monthly

#---------------------------------------------------------------------------------------------------------------------------------------#

# 5.1.7 Ensure permissions on /etc/cron.d are configured

echo "[i] Setting the correct permissions on /etc/cron.d"

chown root:root /etc/cron.d
chmod og-rwx /etc/cron.d

#---------------------------------------------------------------------------------------------------------------------------------------#

# 5.1.8 Ensure at/cron is restricted to authorized users

echo "[i] Restricting at/cron to authorised users"

rm /etc/cron.deny
rm /etc/at.deny
touch /etc/cron.allow
touch /etc/at.allow
chmod og-rwx /etc/cron.allow
chmod og-rwx /etc/at.allow
chown root:root /etc/cron.allow
chown root:root /etc/at.allow

#########################################################################################################################################

# 5.2.1 Ensure permissions on /etc/ssh/sshd_config are configured correctly

echo "[i] Setting correct permission on /etc/ssh/sshd_config"

chown root:root /etc/ssh/sshd_config
chmod og-rwx /etc/ssh/sshd_config

#---------------------------------------------------------------------------------------------------------------------------------------#

# 5.2.2 Ensure SSH Protocol is set to 2

echo "[i] Ensuring SSH Protocol is set to 2"

if grep -q "^Protocol" /etc/ssh/sshd_config; then 
	sed -i 's/^Protocol.*/Protocol 2/' /etc/ssh/sshd_config
else
    echo "Protocol 2" >> /etc/ssh/sshd_config
fi

#---------------------------------------------------------------------------------------------------------------------------------------#

# 5.2.3 Ensure SSH LogLevel is set to INFO

echo "[i] Ensuring SSH LogLevel is set to INFO"

if grep -q "^LogLevel" /etc/ssh/sshd_config; then 
	sed -i 's/^LogLevel.*/LogLevel INFO/' /etc/ssh/sshd_config
else
    echo "LogLevel INFO" >> /etc/ssh/sshd_config
fi

#---------------------------------------------------------------------------------------------------------------------------------------#

# 5.2.4 Ensure SSH X11 forwarding is disabled

echo "[i] Disabling SSH X11 forwarding"

if grep -q "^X11Forwarding" /etc/ssh/sshd_config; then 
	sed -i 's/^X11Forwarding.*/X11Forwarding no/' /etc/ssh/sshd_config
else
    echo "X11Forwarding No" >> /etc/ssh/sshd_config
fi

#---------------------------------------------------------------------------------------------------------------------------------------#

# 5.2.5 Ensure SSH MaxAuthTries is set to 4 or less

echo "[i] Setting SSH MaxAuthTries to 4"
if grep -q "^MaxAuthTries" /etc/ssh/sshd_config; then 
	sed -i 's/^MaxAuthTries.*/MaxAuthTries 4/' /etc/ssh/sshd_config
else
    echo "MaxAuthTries 4" >> /etc/ssh/sshd_config
fi

#---------------------------------------------------------------------------------------------------------------------------------------#

# 5.2.6 Ensure SSH IgnoreRhosts is enabled

echo "[i] Enabling SSH IgnoreRhosts"
if grep -q "^IgnoreRhosts" /etc/ssh/sshd_config; then 
	sed -i 's/^IgnoreRhosts.*/IgnoreRhosts yes/' /etc/ssh/sshd_config
else
    echo "IgnoreRhosts yes" >> /etc/ssh/sshd_config
fi

#---------------------------------------------------------------------------------------------------------------------------------------#

# 5.2.7 Ensure SSH HostbasedAuthentication is disabled

echo "[i] Disabling SSH HostbasedAuthentication"
if grep -q "^HostbasedAuthentication" /etc/ssh/sshd_config; then 
	sed -i 's/^HostbasedAuthentication.*/HostbasedAuthentication no/' /etc/ssh/sshd_config
else
    echo "HostbasedAuthentication no" >> /etc/ssh/sshd_config
fi

#---------------------------------------------------------------------------------------------------------------------------------------#

# 5.2.8 Ensure SSH root login is disabled

echo "[i] Disabling SSH root login"
if grep -q "^PermitRootLogin" /etc/ssh/sshd_config; then 
	sed -i 's/^PermitRootLogin.*/PermitRootLogin no/' /etc/ssh/sshd_config
else
    echo "PermitRootLogin no" >> /etc/ssh/sshd_config
fi

#---------------------------------------------------------------------------------------------------------------------------------------#

# Ensure SSH PermitEmptyPasswords is disabled

echo "[i] Disabling SSH PermitEmptyPasswords"

if grep -q "^PermitEmptyPasswords" /etc/ssh/sshd_config; then 
	sed -i 's/^PermitEmptyPasswords.*/PermitEmptyPasswords no/' /etc/ssh/sshd_config
else
    echo "PermitEmptyPasswords no" >> /etc/ssh/sshd_config
fi

#---------------------------------------------------------------------------------------------------------------------------------------#

# 5.2.10 Ensure SSH PermitUserEnvironment is disabled

echo "[i] Disabling SSH PermitUserEnvironment"
if grep -q "^PermitUserEnvironment" /etc/ssh/sshd_config; then 
	sed -i 's/^PermitUserEnvironment.*/PermitUserEnvironment no/' /etc/ssh/sshd_config
else
    echo "PermitUserEnvironment no" >> /etc/ssh/sshd_config
fi

#---------------------------------------------------------------------------------------------------------------------------------------#

# 5.2.11 Ensure only approved MAC algorithms are used
echo "[i] Ensuring only approved MAC algorithms are used"

if grep -q "^MACs" /etc/ssh/sshd_config; then 
	sed -i 's/^MACs.*/MACs hmac-sha2-512-etm@openssh.com,hmac-sha2-256-etm@openssh.com,umac-128-etm@openssh.com,hmac-sha2-512,hmac-sha2-256,umac-128@openssh.com/' /etc/ssh/sshd_config
else
    echo "MACs hmac-sha2-512-etm@openssh.com,hmac-sha2-256-etm@openssh.com,umac-128-etm@openssh.com,hmac-sha2-512,hmac-sha2-256,umac-128@openssh.com" >> /etc/ssh/sshd_config
fi

#---------------------------------------------------------------------------------------------------------------------------------------#

# 5.2.12 Ensure SSH Idle Timeout Interval is configured

echo "[i] Configuring the SSH Idle Timeout Interval"

if grep -q "^ClientAliveInterval" /etc/ssh/sshd_config; then 
	sed -i 's/^ClientAliveInterval.*/ClientAliveInterval 300/' /etc/ssh/sshd_config
else
    echo "ClientAliveInterval 300" >> /etc/ssh/sshd_config
fi


if grep -q "^ClientAliveCountMax" /etc/ssh/sshd_config; then 
	sed -i 's/^ClientAliveCountMax.*/ClientAliveCountMax 0/' /etc/ssh/sshd_config
else
    echo "ClientAliveCountMax 0" >> /etc/ssh/sshd_config
fi

#---------------------------------------------------------------------------------------------------------------------------------------#

# 5.2.13 Ensure SSH LoginGraceTime is set to one minute or less

echo "[i] Setting SSH LoginGraceTime to 1 minute"

if grep -q "^LoginGraceTime" /etc/ssh/sshd_config; then 
	sed -i 's/^LoginGraceTime.*/LoginGraceTime 60/' /etc/ssh/sshd_config
else
    echo "LoginGraceTime 60" >> /etc/ssh/sshd_config
fi

#---------------------------------------------------------------------------------------------------------------------------------------#

# 5.2.14 Ensure SSH access is limited
# This will need to be manually set by the system administrator as it will be unique per organisation/system

#---------------------------------------------------------------------------------------------------------------------------------------#

# 5.2.15 Ensure SSH warning banner is configured

echo "[i] Setting SSH warning banner"

if grep -q "^Banner" /etc/ssh/sshd_config; then 
	sed -i 's/^Banner.*/Banner /etc/issue.net/' /etc/ssh/sshd_config
else
    echo "Banner /etc/issue.net" >> /etc/ssh/sshd_config
fi

#########################################################################################################################################

# 5.3.1 Ensure password creation requirements are configured 

echo "[i] Installing the Privileged Access Management Password Quality module"

yum install -y libpam-pwquality

echo "[i] Setting password policies to align with CIS guidance"
echo "[i] If you have different password policy requirements, you will need to set these yourself"

if grep -q "pam_pwquality.so" /etc/pam.d/common-password; then 
	sed -i 's/.*pam_pwquality.so.*/password requisite pam_pwquality.so retry=3/' /etc/pam.d/common-password
else
    echo "password requisite pam_pwquality.so retry=3" >> /etc/pam.d/common-password
fi

# Set minimum password length to 10 to align with the orgs requirements

if grep -q "^minlen" /etc/security/pwquality.conf; then 
	sed -i 's/^minlen.*/minlen = 10/' /etc/security/pwquality.conf
else
    echo "minlen = 10" >> /etc/security/pwquality.conf
fi

if grep -q "^dcredit" /etc/security/pwquality.conf; then 
	sed -i 's/^dcredit.*/dcredit = -1/' /etc/security/pwquality.conf
else
    echo "dcredit = -1" >> /etc/security/pwquality.conf
fi


if grep -q "^ucredit" /etc/security/pwquality.conf; then 
	sed -i 's/^ucredit.*/ucredit = -1/' /etc/security/pwquality.conf
else
    echo "ucredit = -1" >> /etc/security/pwquality.conf
fi


if grep -q "^ocredit" /etc/security/pwquality.conf; then 
	sed -i 's/^ocredit.*/ocredit = -1/' /etc/security/pwquality.conf
else
    echo "ocredit = -1" >> /etc/security/pwquality.conf
fi


if grep -q "^lcredit" /etc/security/pwquality.conf; then 
	sed -i 's/^lcredit.*/lcredit = -1/' /etc/security/pwquality.conf
else
    echo "lcredit = -1" >> /etc/security/pwquality.conf
fi


#---------------------------------------------------------------------------------------------------------------------------------------#

# 5.3.2 Ensure lockout for failed password attempts is configured 

echo "[i] Configuring lockout for failed password attempts to 5"

if grep -q "pam_tally2.so" /etc/pam.d/common-auth; then 
	sed -i 's/.*pam_tally2.so.*/auth required pam_tally2.so onerr=fail audit silent deny=5 unlock_time=900/' /etc/pam.d/common-auth
else
    echo "auth required pam_tally2.so onerr=fail audit silent deny=5 unlock_time=900" >> /etc/pam.d/common-auth
fi

#---------------------------------------------------------------------------------------------------------------------------------------#

# 5.3.3 Ensure password reuse is limited

echo "[i] Limiting password reuse to the last 5 passwords"

if grep -q "pam_pwhistory.so" /etc/pam.d/common-password; then 
	sed -i 's/.*pam_pwhistory.so.*/password required pam_pwhistory.so remember=5/' /etc/pam.d/common-password
else
    echo "password required pam_pwhistory.so remember=5" >> /etc/pam.d/common-password
fi

#---------------------------------------------------------------------------------------------------------------------------------------#

# 5.3.4 Ensure password hashing algorithm is SHA-512

echo "[i] Setting the password hashing algorithm to SHA-512"

if grep -q "pam_unix.so" /etc/pam.d/common-password; then 
	sed -i 's/.*pam_unix.so.*/password [success=1 default=ignore] pam_unix.so sha512/' /etc/pam.d/common-password
else
    echo "password [success=1 default=ignore] pam_unix.so sha512" >> /etc/pam.d/common-password
fi

#---------------------------------------------------------------------------------------------------------------------------------------#

# 5.4.1.1 Ensure password expiration is 365 days or less

# Not setting password expiration as it goes against all the best security guidance

# echo "[i] Setting password expiry at 365 days"
# if grep -q "PASS_MAX_DAYS" /etc/login.defs; then
# 	sed -i 's/^PASS_MAX_DAYS.*/PASS_MAX_DAYS 365/' /etc/login.defs
# else
# 	echo "PASS_MAX_DAYS 90" >> /etc/login.defs
# fi

#---------------------------------------------------------------------------------------------------------------------------------------#

# 5.4.1.2 Ensure minimum days between password changes is 7 or more

echo "[i] Setting the minimum days between password changes to 7"

if grep -q "PASS_MIN_DAYS" /etc/login.defs; then
	sed -i 's/^PASS_MIN_DAYS.*/PASS_MIN_DAYS 7/' /etc/login.defs
else
	echo "PASS_MIN_DAYS 7" >> /etc/login.defs
fi

#---------------------------------------------------------------------------------------------------------------------------------------#

# 5.4.1.3 Ensure password expiration warning days is 7 or more

# Not needed as I haven't set passwords to expire arbitrarily 

# echo "[i] Setting password expiration warning to 7 days"
# if grep -q "PASS_WARN_AGE" /etc/login.defs; then
# 	sed -i 's/^PASS_WARN_AGE.*/PASS_WARN_AGE 7/' /etc/login.defs
# else
# 	echo "PASS_WARN_AGE 7" >> /etc/login.defs
# fi

#---------------------------------------------------------------------------------------------------------------------------------------#

# 5.4.1.4 Ensure inactive password lock is 30 days or less

echo "[i] Locking passwords after 30 days of inactivity"

useradd -D -f 30

#---------------------------------------------------------------------------------------------------------------------------------------#

# 5.4.1.5 Ensure all users last password change date is in the past

# Not needed as I aren't expiring passwords

# This is a manual task.  Run the following commands and confirm for each user:
# cat/etc/shadow | cut -d: -f1
# <list of users>
# chage --list <user>
# Last Change			: <date>

#########################################################################################################################################

# 5.4.2 Ensure system accounts are non-login

# Not needed as there are no non-default service accounts with these machines

# This is a manual task.
# Run the following audit task to identify users which have interactive login privs which shouldn't:

# egrep -v "^\+" /etc/passwd | awk -F: '($1!="root" && $1!="sync" && $1!="shutdown" && $1!="halt" && $3<1000 && $7!="/usr/sbin/nologin" && $7!="/bin/false") {print}'

# for user in `awk -F: '($1!="root" && $3 < 1000) {print $1 }' /etc/passwd`; do passwd -S $user | awk -F ' ' '($2!="L") {print $1}'; done

# To remediate, set the shell for all necessary accounts identified by the audit script to /usr/sbin/nologin by running the following command:

# usermod -s /usr/sbin/nologin <user>
# passwd -l <user>

#########################################################################################################################################

# 5.4.3 Ensure default group for the root account is GID 0

echo "[i] Setting the default group for root to GID 0"
usermod -g 0 root

#########################################################################################################################################

# 5.4.4 Ensure default user umask is 027 or more restrictive

echo "[i] Setting default user umask to 027"

umask 027

#########################################################################################################################################

# 5.6 Ensure access to the su command is restricted

echo "[i] Restricting access to the su command"

if grep -q "pam_wheel.so" /etc/pam.d/su; then
	sed -i 's/.*pam_wheel.so.*/auth required pam_wheel.so/' /etc/pam.d/su
else
	echo "auth required pam_wheel.so" >> /etc/pam.d/su
fi

# An administrator will need to create a comma separated list of users in the sudo statement in the /etc/group file:
# sudo:x:10:root,<user list>

#########################################################################################################################################

# 6.1.2 Ensure permissions on /etc/passwd are configured

echo "[i] Setting correct permissions on /etc/passwd"

chown root:root /etc/passwd
chmod 644 /etc/passwd

#---------------------------------------------------------------------------------------------------------------------------------------#

# 6.1.3 Ensure permissions on /etc/shadow are configured 

echo "[i] Setting correct permissions on /etc/shadow"



#---------------------------------------------------------------------------------------------------------------------------------------#

# 6.1.4 Ensure permissions on /etc/group are configured

echo "[i] Setting correct permissions on /etc/group"

chown root:root /etc/group
chmod 644 /etc/group

#---------------------------------------------------------------------------------------------------------------------------------------#

# 6.1.5 Ensure permissions on /etc/gshadow are configured 

echo "[i] Setting correct permissions on /etc/gshadow"

chown root:root /etc/gshadow
chmod 000 /etc/gshadow

#---------------------------------------------------------------------------------------------------------------------------------------#

# 6.1.6 Ensure permission on /etc/passwd- are configured 

echo "[i] Setting correct permissions on /etc/passwd-"

chown root:root /etc/passwd-
chmod u-x,go-wx /etc/passwd-

#---------------------------------------------------------------------------------------------------------------------------------------#

# 6.1.7 Ensure permissions on /etc/shadow- are configured 

echo "[i] Setting correct permissions on /etc/shadow-"

chown root:root /etc/shadow-
chmod 000 /etc/shadow-

#---------------------------------------------------------------------------------------------------------------------------------------#

# 6.1.8 Ensure permissions on /etc/group- are configured

echo "[i] Setting correct permissions on /etc/group-"

chown root:root /etc/group-
chmod u-x,go-wx /etc/group-

#---------------------------------------------------------------------------------------------------------------------------------------#

# 6.1.9 Ensure permissions on /etc/gshadow- are configured

echo "[i] Setting correct permissions on /etc/gshadow-"

chown root:root /etc/gshadow-
chmod 000 /etc/gshadow-

#########################################################################################################################################

# 6.1.10 Ensure no world writable files 
# 6.1.11 Ensure no unowned files or directories exist
# 6.1.12 Ensure no ungrouped files or directories exist 
# 6.2.1 Ensure password fields are not empty
# 6.2.2 Ensure no legacy "+" entries exist in /etc/passwd
# 6.2.3 Ensure no legacy "+" entries exist in /etc/shadow
# 6.2.4 Ensure no legacy "+" entries exist in /etc/group
# 6.2.5 Ensure root is the only UID 0 account
# 6.2.6 Ensure root PATH integrity
# 6.2.7 Ensure all users' home directories exist
# 6.2.8 Ensure all users' home directories permissions are 750 or more restrictive
# 6.2.9 Ensure users own their home directories
# 6.2.10 Ensure users' dot files are not group or world writable
# 6.2.11 Ensure no users have .forward files
# 6.2.12 Ensure no users have .netrc files
# 6.2.13 Ensure users' .netrc Files are not group or world accessible
# 6.2.14 Ensure no users have .rhosts files
# 6.2.15 Ensure all groups in /etc/passwd exist in /etc/group
# 6.2.16 Ensure no duplicate UIDs exist
# 6.2.17 Ensure no duplicate GIDs exist
# 6.2.18 Ensure no duplicate user names exist
# 6.2.19 Ensure no duplicate group names exist
