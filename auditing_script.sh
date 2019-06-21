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
echo ""
echo "[i]This script has been run on the following machine: " | tee -a ./audit_results.txt
hostname | tee -a ./audit_results.txt
echo ""
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

echo "[i] Confirming the bootloader password is set: " | tee -a ./audit_results.txt
echo "[i] Output of the grep command against the 'grub.cfg' file is: " | tee -a ./audit_results.txt

grep "^GRUB2_PASSWORD" /boot/efi/EFI/fedora/grub.cfg | tee -a ./audit_results.txt

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

echo "############################################################################" >> ./audit_results.txt

echo "[i] Confirming permissions are set correctly on all log files" | tee -a ./audit_results.txt
echo "[i] Getting file permsissions: " | tee -a ./audit_results.txt

find /var/log -type f -ls | tee -a ./audit_results.txt

echo "[i] Manually check the above output and ensure that 'other' has no permissions on any files and 'group' does not have write or execute permissions on any files" | tee -a ./audit_results.txt

#########################################################################################################################################

# 5.1.1 Ensure cron daemon is enabled

echo "############################################################################" >> ./audit_results.txt

echo "[i] Confirming cron daemon service is enabled" | tee -a ./audit_results.txt
echo "[i] Running 'systemctl is-enabled crond' command: " | tee -a ./audit_results.txt

systemctl is-enabled crond | tee -a ./audit_results.txt

echo "[i] Output from the above command should state that it is enabled" | tee -a ./audit_results.txt

var=$(systemctl is-enabled crond)

if [[ "$var" == "enabled" ]]; then
	echo "[YES] crond service is enabled" | tee -a ./audit_results.txt
else
	echo "[NO] crond service is NOT enabled" | tee -a ./audit_results.txt
fi

#---------------------------------------------------------------------------------------------------------------------------------------#

# 5.1.2 Ensure permissions on /etc/crontab are configured

echo "############################################################################" >> ./audit_results.txt

echo "[i] Confirming permissions on /etc/crontab are configured correctly" | tee -a ./audit_results.txt
echo "[i] Getting information from /etc/crontab: " | tee -a ./audit_results.txt

stat /etc/crontab | tee -a ./audit_results.txt

echo "[i] The output above should have Uid and Gid set as 0 and 'group' and 'other' should have no permissions set" | tee -a ./audit_results.txt

if stat /etc/crontab | grep -q 'Access: (0600/-rw-------) Uid: ( 0/ root) Gid: ( 0/ root)'; then
	echo "[YES] File permissions are set correctly" | tee -a ./audit_results.txt
else
	echo "[NO] File permissions don't appear to be set correctly" | tee -a ./audit_results.txt
fi

#---------------------------------------------------------------------------------------------------------------------------------------#

# 5.1.3 Ensure permissions on /etc/cron.hourly are configured

echo "############################################################################" >> ./audit_results.txt

echo "[i] Confirming permissions on /etc/cron.hourly are configured correctly" | tee -a ./audit_results.txt
echo "[i] Getting information from /etc/cron.hourly: " | tee -a ./audit_results.txt

stat /etc/cron.hourly | tee -a ./audit_results.txt

echo "[i] The output above should have Uid and Gid set as 0 and 'group' and 'other' should have no permissions set" | tee -a ./audit_results.txt

if stat /etc/cron.hourly | grep -q 'Access: (0700/-rw-------) Uid: ( 0/ root) Gid: ( 0/ root)'; then
	echo "[YES] File permissions are set correctly" | tee -a ./audit_results.txt
else
	echo "[NO] File permissions don't appear to be set correctly" | tee -a ./audit_results.txt
fi

#---------------------------------------------------------------------------------------------------------------------------------------#

# 5.1.4 Ensure permissions on /etc/cron.daily are configured 

echo "############################################################################" >> ./audit_results.txt

echo "[i] Confirming permissions on /etc/cron.daily are configured correctly" | tee -a ./audit_results.txt
echo "[i] Getting information from /etc/cron.daily: " | tee -a ./audit_results.txt

stat /etc/cron.daily | tee -a ./audit_results.txt

echo "[i] The output above should have Uid and Gid set as 0 and 'group' and 'other' should have no permissions set" | tee -a ./audit_results.txt

if stat /etc/cron.hourly | grep -q 'Access: (0700/-rw-------) Uid: ( 0/ root) Gid: ( 0/ root)'; then
	echo "[YES] File permissions are set correctly" | tee -a ./audit_results.txt
else
	echo "[NO] File permissions don't appear to be set correctly" | tee -a ./audit_results.txt
fi

#---------------------------------------------------------------------------------------------------------------------------------------#

# 5.1.5 Ensure permissions on /etc/cron.weekly are configured

echo "############################################################################" >> ./audit_results.txt

echo "[i] Confirming permissions on /etc/cron.weekly are configured correctly" | tee -a ./audit_results.txt
echo "[i] Getting information from /etc/cron.weekly: " | tee -a ./audit_results.txt

stat /etc/cron.weekly | tee -a ./audit_results.txt

echo "[i] The output above should have Uid and Gid set as 0 and 'group' and 'other' should have no permissions set" | tee -a ./audit_results.txt

if stat /etc/cron.weekly | grep -q 'Access: (0700/-rw-------) Uid: ( 0/ root) Gid: ( 0/ root)'; then
	echo "[YES] File permissions are set correctly" | tee -a ./audit_results.txt
else
	echo "[NO] File permissions don't appear to be set correctly" | tee -a ./audit_results.txt
fi

#---------------------------------------------------------------------------------------------------------------------------------------#

# 5.1.6 Ensure permissions on /etc/cron.monthly are configured

echo "############################################################################" >> ./audit_results.txt

echo "[i] Confirming permissions on /etc/cron.monthly are configured correctly" | tee -a ./audit_results.txt
echo "[i] Getting information from /etc/cron.monthly: " | tee -a ./audit_results.txt

stat /etc/cron.monthly | tee -a ./audit_results.txt

echo "[i] The output above should have Uid and Gid set as 0 and 'group' and 'other' should have no permissions set" | tee -a ./audit_results.txt

if stat /etc/cron.monthly | grep -q 'Access: (0700/-rw-------) Uid: ( 0/ root) Gid: ( 0/ root)'; then
	echo "[YES] File permissions are set correctly" | tee -a ./audit_results.txt
else
	echo "[NO] File permissions don't appear to be set correctly" | tee -a ./audit_results.txt
fi

#---------------------------------------------------------------------------------------------------------------------------------------#

# 5.1.7 Ensure permissions on /etc/cron.d are configured

echo "############################################################################" >> ./audit_results.txt

echo "[i] Confirming permissions on /etc/cron.d are configured correctly" | tee -a ./audit_results.txt
echo "[i] Getting information from /etc/cron.d: " | tee -a ./audit_results.txt

stat /etc/cron.d | tee -a ./audit_results.txt

echo "[i] The output above should have Uid and Gid set as 0 and 'group' and 'other' should have no permissions set" | tee -a ./audit_results.txt

if stat /etc/cron.d | grep -q 'Access: (0700/-rw-------) Uid: ( 0/ root) Gid: ( 0/ root)'; then
	echo "[YES] File permissions are set correctly" | tee -a ./audit_results.txt
else
	echo "[NO] File permissions don't appear to be set correctly" | tee -a ./audit_results.txt
fi

#---------------------------------------------------------------------------------------------------------------------------------------#

# 5.1.8 Ensure at/cron is restricted to authorized users

echo "############################################################################" >> ./audit_results.txt

echo "[i] Confirming cron.deny is restricted to authorised users" | tee -a ./audit_results.txt
echo "[i] Getting information from /etc/cron.deny: " | tee -a ./audit_results.txt

stat /etc/cron.deny | tee -a ./audit_results.txt

echo "[i] The output above should indicate that 'No such file or directory' exists" | tee -a ./audit_results.txt

if stat /etc/cron.deny | grep -q 'stat: cannot stat \`/etc/cron.deny\': No such file or directory'; then
	echo "[YES] cron.deny is restricted" | tee -a ./audit_results.txt
else
	echo "[NO] cron.deny is NOT restricted" | tee -a ./audit_results.txt
fi

echo "[i] Confirming at.deny is restricted to authorised users" | tee -a ./audit_results.txt
echo "[i] Getting information from /etc/at.deny: " | tee -a ./audit_results.txt

stat /etc/at.deny | tee -a ./audit_results.txt

echo "[i] The output above should indicate that 'No such file or directory' exists" | tee -a ./audit_results.txt

if stat /etc/at.deny | grep -q 'stat: cannot stat \`/etc/at.deny\': No such file or directory'; then
	echo "[YES] at.deny is restricted" | tee -a ./audit_results.txt
else
	echo "[NO] at.deny is NOT restricted" | tee -a ./audit_results.txt
fi

echo "[i] Confirming permissions on /etc/cron.allow are configured correctly" | tee -a ./audit_results.txt
echo "[i] Getting information from /etc/cron.allow: " | tee -a ./audit_results.txt

stat /etc/cron.allow | tee -a ./audit_results.txt

echo "[i] The output above should have Uid and Gid set as 0 and 'group' and 'other' should have no permissions set" | tee -a ./audit_results.txt

if stat /etc/cron.allow | grep -q 'Access: (0600/-rw-------) Uid: ( 0/ root) Gid: ( 0/ root)'; then
	echo "[YES] File permissions are set correctly" | tee -a ./audit_results.txt
else
	echo "[NO] File permissions don't appear to be set correctly" | tee -a ./audit_results.txt
fi

echo "[i] Confirming permissions on /etc/at.allow are configured correctly" | tee -a ./audit_results.txt
echo "[i] Getting information from /etc/at.allow: " | tee -a ./audit_results.txt

stat /etc/at.allow | tee -a ./audit_results.txt

echo "[i] The output above should have Uid and Gid set as 0 and 'group' and 'other' should have no permissions set" | tee -a ./audit_results.txt

if stat /etc/cron.allow | grep -q 'Access: (0600/-rw-------) Uid: ( 0/ root) Gid: ( 0/ root)'; then
	echo "[YES] File permissions are set correctly" | tee -a ./audit_results.txt
else
	echo "[NO] File permissions don't appear to be set correctly" | tee -a ./audit_results.txt
fi

#########################################################################################################################################

# 5.2.1 Ensure permissions on /etc/ssh/sshd_config are configured correctly

echo "############################################################################" >> ./audit_results.txt

echo "[i] Confirming permissions on /etc/ssh/sshd_config are configured correctly" | tee -a ./audit_results.txt
echo "[i] Getting information from /etc/ssh/sshd_config: " | tee -a ./audit_results.txt

stat /etc/ssh/sshd_config | tee -a ./audit_results.txt

echo "[i] The output above should have Uid and Gid set as 0 and 'group' and 'other' should have no permissions set" | tee -a ./audit_results.txt

if stat /etc/ssh/sshd_config | grep -q 'Access: (0600/-rw-------) Uid: ( 0/ root) Gid: ( 0/ root)'; then
	echo "[YES] File permissions are set correctly" | tee -a ./audit_results.txt
else
	echo "[NO] File permissions don't appear to be set correctly" | tee -a ./audit_results.txt
fi

#---------------------------------------------------------------------------------------------------------------------------------------#

# 5.2.2 Ensure SSH Protocol is set to 2

echo "############################################################################" >> ./audit_results.txt

echo "[i] Confirming SSH Protocol 2 is set" | tee -a ./audit_results.txt
echo "[i] Getting information from /etc/ssh/sshd_config: " | tee -a ./audit_results.txt

grep "^Protocol" /etc/ssh/sshd_config | tee -a ./audit_results.txt

echo "[i] The output above should read 'Protocol 2" | tee -a ./audit_results.txt

var=$(grep "^Protocol" /etc/ssh/sshd_config)

if [[ "$var" == "Protocol 2" ]]; then
	echo "[YES] Protocol 2 is set" | tee -a ./audit_results.txt
else
	echo "[NO] Protocol 2 is NOT set" | tee -a ./audit_results.txt
fi

#---------------------------------------------------------------------------------------------------------------------------------------#

# 5.2.3 Ensure SSH LogLevel is set to INFO

echo "############################################################################" >> ./audit_results.txt

echo "[i] Confirming SSH LogLevel is set to INFO" | tee -a ./audit_results.txt
echo "[i] Getting information from /etc/ssh/sshd_config: " | tee -a ./audit_results.txt

grep "^LogLevel" /etc/ssh/sshd_config | tee -a ./audit_results.txt

echo "[i] The output above should read 'LogLevel INFO'" | tee -a ./audit_results.txt

var=$(grep "^LogLevel" /etc/ssh/sshd_config)

if [[ "$var" == "LogLevel INFO" ]]; then
	echo "[YES] LogLevel is set to INFO" | tee -a ./audit_results.txt
else
	echo "[NO] LogLevel is NOT set to INFO" | tee -a ./audit_results.txt
fi

#---------------------------------------------------------------------------------------------------------------------------------------#

# 5.2.4 Ensure SSH X11 forwarding is disabled

echo "############################################################################" >> ./audit_results.txt

echo "[i] Confirming SSH X11 is disabled" | tee -a ./audit_results.txt
echo "[i] Getting information from /etc/ssh/sshd_config: " | tee -a ./audit_results.txt

grep "^X11Forwarding" /etc/ssh/sshd_config | tee -a ./audit_results.txt

echo "[i] The output above should read 'X11 Forwarding no'" | tee -a ./audit_results.txt

var=$(grep "^X11Forwarding" /etc/ssh/sshd_config)

if [[ "$var" == "X11Forwarding no" ]]; then
	echo "[YES] X11 forwarding is disabled" | tee -a ./audit_results.txt
else
	echo "[NO] X11 forwarding is NOT disabled" | tee -a ./audit_results.txt
fi

#---------------------------------------------------------------------------------------------------------------------------------------#

# 5.2.5 Ensure SSH MaxAuthTries is set to 4 or less

echo "############################################################################" >> ./audit_results.txt

echo "[i] Confirming SSH MaxAuthTries is set to 4" | tee -a ./audit_results.txt
echo "[i] Getting information from /etc/ssh/sshd_config: " | tee -a ./audit_results.txt

grep "^MaxAuthTries" /etc/ssh/sshd_config | tee -a ./audit_results.txt

echo "[i] The output above should read 'MaxAuthTries 4'" | tee -a ./audit_results.txt

var=$(grep "^MaxAuthTries" /etc/ssh/sshd_config)

if [[ "$var" == "MaxAuthTries 4" ]]; then
	echo "[YES] MaxAuthTries is set to 4" | tee -a ./audit_results.txt
else
	echo "[NO] MaxAuthTries is NOT set to 4" | tee -a ./audit_results.txt
fi

#---------------------------------------------------------------------------------------------------------------------------------------#

# 5.2.6 Ensure SSH IgnoreRhosts is enabled

echo "############################################################################" >> ./audit_results.txt

echo "[i] Confirming SSH IgnoreRhosts is enabled" | tee -a ./audit_results.txt
echo "[i] Getting information from /etc/ssh/sshd_config: " | tee -a ./audit_results.txt

grep "^IgnoreRhosts" /etc/ssh/sshd_config | tee -a ./audit_results.txt

echo "[i] The output above should read 'IgnoreRhosts yes'" | tee -a ./audit_results.txt

var=$(grep "^IgnoreRhosts" /etc/ssh/sshd_config)

if [[ "$var" == "IgnoreRhosts yes" ]]; then
	echo "[YES] IgnoreRhosts is set" | tee -a ./audit_results.txt
else
	echo "[NO] IgnoreRhosts is NOT set" | tee -a ./audit_results.txt
fi

#---------------------------------------------------------------------------------------------------------------------------------------#

# 5.2.7 Ensure SSH HostbasedAuthentication is disabled

echo "############################################################################" >> ./audit_results.txt

echo "[i] Confirming SSH HostbasedAuthentication is disabled" | tee -a ./audit_results.txt
echo "[i] Getting information from /etc/ssh/sshd_config: " | tee -a ./audit_results.txt

grep "^HostbasedAuthentication" /etc/ssh/sshd_config | tee -a ./audit_results.txt

echo "[i] The output above should read 'HostbasedAuthentication no'" | tee -a ./audit_results.txt

var=$(grep "^HostbasedAuthentication" /etc/ssh/sshd_config)

if [[ "$var" == "HostbasedAuthentication no" ]]; then
	echo "[YES] HostbasedAuthentication is disabled" | tee -a ./audit_results.txt
else
	echo "[NO] HostbasedAuthentication is NOT disabled" | tee -a ./audit_results.txt
fi

#---------------------------------------------------------------------------------------------------------------------------------------#

# 5.2.8 Ensure SSH root login is disabled

echo "############################################################################" >> ./audit_results.txt

echo "[i] Confirming SSH root login is disabled" | tee -a ./audit_results.txt
echo "[i] Getting information from /etc/ssh/sshd_config: " | tee -a ./audit_results.txt

grep "^PermitRootLogin" /etc/ssh/sshd_config | tee -a ./audit_results.txt

echo "[i] The output above should read 'PermitRootLogin no'" | tee -a ./audit_results.txt

var=$(grep "^PermitRootLogin" /etc/ssh/sshd_config)

if [[ "$var" == "PermitRootLogin no" ]]; then
	echo "[YES] PermitRootLogin is disabled" | tee -a ./audit_results.txt
else
	echo "[NO] PermitRootLogin is NOT disabled" | tee -a ./audit_results.txt
fi

#---------------------------------------------------------------------------------------------------------------------------------------#

# 5.2.9 Ensure SSH PermitEmptyPasswords is disabled

echo "############################################################################" >> ./audit_results.txt

echo "[i] Confirming SSH PermitEmptyPasswords is disabled" | tee -a ./audit_results.txt
echo "[i] Getting information from /etc/ssh/sshd_config: " | tee -a ./audit_results.txt

grep "^PermitEmptyPasswords" /etc/ssh/sshd_config | tee -a ./audit_results.txt

echo "[i] The output above should read 'PermitEmptyPasswords no'" | tee -a ./audit_results.txt

var=$(grep "^PermitEmptyPasswords" /etc/ssh/sshd_config)

if [[ "$var" == "PermitEmptyPasswords no" ]]; then
	echo "[YES] PermitEmptyPasswords is disabled" | tee -a ./audit_results.txt
else
	echo "[NO] PermitEmptyPasswords is NOT disabled" | tee -a ./audit_results.txt
fi

#---------------------------------------------------------------------------------------------------------------------------------------#

# 5.2.10 Ensure SSH PermitUserEnvironment is disabled

echo "############################################################################" >> ./audit_results.txt

echo "[i] Confirming SSH PermitUserEnvironment is disabled" | tee -a ./audit_results.txt
echo "[i] Getting information from /etc/ssh/sshd_config: " | tee -a ./audit_results.txt

grep "^PermitUserEnvironment" /etc/ssh/sshd_config | tee -a ./audit_results.txt

echo "[i] The output above should read 'PermitUserEnvironment no'" | tee -a ./audit_results.txt

var=$(grep "^PermitUserEnvironment" /etc/ssh/sshd_config)

if [[ "$var" == "PermitUserEnvironment no" ]]; then
	echo "[YES] PermitUserEnvironment is disabled" | tee -a ./audit_results.txt
else
	echo "[NO] PermitUserEnvironment is NOT disabled" | tee -a ./audit_results.txt
fi

#---------------------------------------------------------------------------------------------------------------------------------------#

# 5.2.11 Ensure only approved MAC algorithms are used

echo "############################################################################" >> ./audit_results.txt

echo "[i] Confirming only approved MAC algorithms are used" | tee -a ./audit_results.txt
echo "[i] Getting the list of MAC algorithms: " | tee -a ./audit_results.txt

grep "MACs" /etc/ssh/sshd_config | tee -a ./audit_results.txt

echo "[i] You will need to manual check the above output and ensure there are no MACs that are NOT also in the following list" | tee -a ./audit_results.txt
echo "		hmac-sha2-512-etm@openssh.com" | tee -a ./audit_results.txt
echo "		hmac-sha2-256-etm@openssh.com" | tee -a ./audit_results.txt
echo "		umac-128-etm@openssh.com" | tee -a ./audit_results.txt
echo "		hmac-sha2-512" | tee -a ./audit_results.txt
echo "		hmac-sha2-256" | tee -a ./audit_results.txt
echo "		umac-128@openssh.com" | tee -a ./audit_results.txt

var=$(grep "MACs" /etc/ssh/sshd_config)

if [[ "$var" == "MACs hmac-sha2-512-etm@openssh.com,hmac-sha2-256-etm@openssh.com,umac-128-etm@openssh.com,hmac-sha2-512,hmac-sha2-256,umac-128@openssh.com"; then
	echo "[YES] The MAC list only includes the approved algorithms" | tee -a ./audit_results.txt
else
	echo "[???] The MACs list doesn't match the expected values and needs to be checked manually" | tee -a ./audit_results.txt
fi

#---------------------------------------------------------------------------------------------------------------------------------------#

# 5.2.12 Ensure SSH Idle Timeout Interval is configured

echo "############################################################################" >> ./audit_results.txt

echo "[i] Confirming ClientAliveInterval is set at 300" | tee -a ./audit_results.txt
echo "[i] Getting information from /etc/ssh/sshd_config: " | tee -a ./audit_results.txt

grep "^ClientAliveInterval" /etc/ssh/sshd_config | tee -a ./audit_results.txt

echo "[i] The output above should read 'ClientAliveInterval 300'" | tee -a ./audit_results.txt

var=$(grep "^ClientAliveInterval" /etc/ssh/sshd_config)

if [[ "$var" == "ClientAliveInterval 300" ]]; then
	echo "[YES] The ClientAliveInterval is set at 300" | tee -a ./audit_results.txt
else
	echo "[NO] The ClientAliveInterval is not set at 300 and should be manually checked" | tee -a ./audit_results.txt
fi

echo "[i] Confirming ClientAliveCountMax is set at 0" | tee -a ./audit_results.txt
echo "[i] Getting information from /etc/ssh/sshd_config: " | tee -a ./audit_results.txt

grep "^ClientAliveCountMax" /etc/ssh/sshd_config | tee -a ./audit_results.txt

echo "[i] The output above should read 'ClientAliveCountMax 0'" | tee -a ./audit_results.txt

var=$(grep "^ClientAliveCountMax" /etc/ssh/sshd_config)

if [[ "$var" == "ClientAliveCountMax 0" ]]; then
	echo "[YES] The ClientAliveCountMax is set at 0" | tee -a ./audit_results.txt
else
	echo "[NO] The ClientAliveCountMax is not set at 0" | tee -a ./audit_results.txt
fi

#---------------------------------------------------------------------------------------------------------------------------------------#

# 5.2.13 Ensure SSH LoginGraceTime is set to one minute or less

echo "############################################################################" >> ./audit_results.txt

echo "[i] Confirming LoginGraceTime is set at 60 seconds" | tee -a ./audit_results.txt
echo "[i] Getting information from /etc/ssh/sshd_config: " | tee -a ./audit_results.txt

grep "^LoginGraceTime" /etc/ssh/sshd_config | tee -a ./audit_results.txt

echo "[i] The output above should read 'LoginGraceTime 60'" | tee -a ./audit_results.txt

var=$(grep "^LoginGraceTime" /etc/ssh/sshd_config)

if [[ "$var" == "LoginGraceTime 60" ]]; then
	echo "[YES] The LoginGraceTime is set at 60 seconds" | tee -a ./audit_results.txt
else
	echo "[NO] The LoginGraceTime is not set at 60 seconds and should be manually checked" | tee -a ./audit_results.txt
fi

#---------------------------------------------------------------------------------------------------------------------------------------#

# 5.2.14 Ensure SSH access is limited

echo "############################################################################" >> ./audit_results.txt

echo "[i] Confirming that SSH access has been limited" | tee -a ./audit_results.txt
echo "[i] Getting information from /etc/ssh/sshd_config: " | tee -a ./audit_results.txt

grep "^AllowUsers" /etc/ssh/sshd_config | tee -a ./audit_results.txt
grep "^AllowGroups" /etc/ssh/sshd_config | tee -a ./audit_results.txt
grep "^DenyUsers" /etc/ssh/sshd_config | tee -a ./audit_results.txt
grep "^DenyGroups" /etc/ssh/sshd_config | tee -a ./audit_results.txt

echo "[i] You will need to manually check the above output and ensure that some restrictions have been applied and that they are suitably restrictive to limit SSH access" | tee -a ./audit_results.txt

#---------------------------------------------------------------------------------------------------------------------------------------#

# 5.2.15 Ensure SSH warning banner is configured

echo "############################################################################" >> ./audit_results.txt

echo "[i] Confirming SSH warning banner is configured" | tee -a ./audit_results.txt
echo "[i] Getting information from /etc/ssh/sshd_config: " | tee -a ./audit_results.txt

grep "^Banner" /etc/ssh/sshd_config | tee -a ./audit_results.txt

echo "[i] The output above should read 'Banner /etc/issue.net'" | tee -a ./audit_results.txt

var=$(grep "^Banner" /etc/ssh/sshd_config)

if [[ "$var" == "Banner /etc/issue.net" ]]; then
	echo "[YES] The SSH warning banner has been set" | tee -a ./audit_results.txt
else
	echo "[NO] The SSH warning banner has NOT been set" | tee -a ./audit_results.txt
fi

#########################################################################################################################################

# 5.3.1 Ensure password creation requirements are configured 

echo "############################################################################" >> ./audit_results.txt

echo "[i] Confirming all the password creation requirements are set in line with the original hardening requirements" | tee -a ./audit_results.txt
echo "[i] Getting information about the password creation requirements: " | tee -a ./audit_results.txt

grep pam_pwquality.so /etc/pam.d/password-auth | tee -a ./audit_results.txt
grep pam_pwquality.so /etc/pam.d/system-auth | tee -a ./audit_results.txt
grep ^minlen /etc/security/pwquality.conf | tee -a ./audit_results.txt
grep ^dcredit /etc/security/pwquality.conf | tee -a ./audit_results.txt
grep ^lcredit /etc/security/pwquality.conf | tee -a ./audit_results.txt
grep ^ocredit /etc/security/pwquality.conf | tee -a ./audit_results.txt
grep ^ucredit /etc/security/pwquality.conf | tee -a ./audit_results.txt

var=$(grep pam_pwquality.so /etc/pam.d/password-auth | tee -a ./audit_results.txt)

if [[ "$var" == "password requisite pam_pwquality.so try_first_pass retry=3" ]]; then
	echo "[YES] Passowrd retries are set at 3 for users" | tee -a ./audit_results.txt
else
	echo "[NO] Passowrd retries are NOT set at 3 for users " | tee -a ./audit_results.txt
fi

var=$(grep pam_pwquality.so /etc/pam.d/system-auth | tee -a ./audit_results.txt)

if [[ "$var" == "password requisite pam_pwquality.so try_first_pass retry=3" ]]; then
	echo "[YES] Passowrd retries are set at 3 for SYSTEM" | tee -a ./audit_results.txt
else
	echo "[NO] Passowrd retries are set at 3 for SYSTEM" | tee -a ./audit_results.txt
fi

var=$(grep ^minlen /etc/security/pwquality.conf | tee -a ./audit_results.txt)

if [[ "$var" == "minlen = 10" ]]; then
	echo "[YES] Minimum password length is set at 10 characters" | tee -a ./audit_results.txt
else
	echo "[NO] Minimum password length is NOT set at 10 characters" | tee -a ./audit_results.txt
fi

var=$(grep ^dcredit /etc/security/pwquality.conf | tee -a ./audit_results.txt)

if [[ "$var" == "dcredit = -1" ]]; then
	echo "[YES] At least one numeric character is required" | tee -a ./audit_results.txt
else
	echo "[NO] At least one numeric character is NOT required" | tee -a ./audit_results.txt
fi

var=$(grep ^lcredit /etc/security/pwquality.conf | tee -a ./audit_results.txt)

if [[ "$var" == "lcredit = -1" ]]; then
	echo "[YES] At least 1 lower case character is needed" | tee -a ./audit_results.txt
else
	echo "[NO] At least 1 lower case character is NOT needed" | tee -a ./audit_results.txt
fi

var=$(grep ^ocredit /etc/security/pwquality.conf | tee -a ./audit_results.txt)

if [[ "$var" == "ocredit = -1" ]]; then
	echo "[YES] At least 1 special character is needed" | tee -a ./audit_results.txt
else
	echo "[NO] At least 1 special character is NOT needed" | tee -a ./audit_results.txt
fi

var=$(grep ^ucredit /etc/security/pwquality.conf | tee -a ./audit_results.txt)

if [[ "$var" == "ucredit = -1" ]]; then
	echo "[YES] At least 1 upper case character is needed" | tee -a ./audit_results.txt
else
	echo "[NO] At least 1 upper case character is NOT needed" | tee -a ./audit_results.txt
fi

#---------------------------------------------------------------------------------------------------------------------------------------#

# 5.3.2 Ensure lockout for failed password attempts is configured 

echo "############################################################################" >> ./audit_results.txt

echo "[i] Confirming a lockout for failed password attempts is configured" | tee -a ./audit_results.txt
echo "[i] Getting information about the password lockout configuration: " | tee -a ./audit_results.txt

grep -q "pam_tally2.so" /etc/pam.d/common-auth | tee -a ./audit_results.txt

echo "[i] The output above should indicate show 'deny=5' and 'unlock_time=900' are set" | tee -a ./audit_results.txt

if grep -q "pam_tally2.so" /etc/pam.d/common-auth | grep -q 'auth required pam_tally2.so onerr=fail audit silent deny=5 unlock_time=900'; then 
	echo "[YES] The lockout is set at 900 seconds after 5 failed attempts, as per the hardening requirements" | tee -a ./audit_results.txt
else
    echo "[NO] The lockout is NOT set at 900 seconds after 5 failed attempts, as per the hardening requirements" | tee -a ./audit_results.txt
fi

#---------------------------------------------------------------------------------------------------------------------------------------#

# 5.3.3 Ensure password reuse is limited

echo "############################################################################" >> ./audit_results.txt

echo "[i] Confirming password reuse is limited to last 5 passwords" | tee -a ./audit_results.txt
echo "[i] Getting information about the password reuse configuration: " | tee -a ./audit_results.txt

egrep '^password\s+sufficient\s+pam_unix.so' /etc/pam.d/password-auth | tee -a ./audit_results.txt
egrep '^password\s+sufficient\s+pam_unix.so' /etc/pam.d/system-auth | tee -a ./audit_results.txt

echo "[i] The two outputs above should read: " | tee -a ./audit_results.txt
	echo "		password sufficient pam_unix.so remember=5" | tee -a ./audit_results.txt

var=$(egrep '^password\s+sufficient\s+pam_unix.so' /etc/pam.d/password-auth)

if [[ "$var" == "password sufficient pam_unix.so remember=5"; then 
	echo "[YES] The user password reuse is limited to 5" | tee -a ./audit_results.txt
else
    echo "[NO] The user password reuse is NOT limited to 5" | tee -a ./audit_results.txt
fi

var=$(egrep '^password\s+sufficient\s+pam_unix.so' /etc/pam.d/system-auth)

if [[ "$var" == "password sufficient pam_unix.so remember=5"; then 
	echo "[YES] The system password reuse is limited to 5" | tee -a ./audit_results.txt
else
    echo "[NO] The system password reuse is NOT limited to 5" | tee -a ./audit_results.txt
fi

#---------------------------------------------------------------------------------------------------------------------------------------#

# 5.3.4 Ensure password hashing algorithm is SHA-512

echo "############################################################################" >> ./audit_results.txt

echo "[i] Confirming password hashing algorithm is SHA-512" | tee -a ./audit_results.txt
echo "[i] Getting information about the password hashing algorithm: " | tee -a ./audit_results.txt

egrep '^password\s+sufficient\s+pam_unix.so' /etc/pam.d/password-auth | tee -a ./audit_results.txt
egrep '^password\s+sufficient\s+pam_unix.so' /etc/pam.d/system-auth | tee -a ./audit_results.txt

echo "[i] The two outputs above should read: " | tee -a ./audit_results.txt
	echo "		password sufficient pam_unix.so sha512" | tee -a ./audit_results.txt

var=$(egrep '^password\s+sufficient\s+pam_unix.so' /etc/pam.d/password-auth)

if [[ "$var" == "password sufficient pam_unix.so sha512"; then 
	echo "[YES] The user password hash is SHA-512" | tee -a ./audit_results.txt
else
    echo "[NO] The user password hash is NOT SHA-512" | tee -a ./audit_results.txt
fi

var=$(egrep '^password\s+sufficient\s+pam_unix.so' /etc/pam.d/system-auth)

if [[ "$var" == "password sufficient pam_unix.so sha512"; then 
	echo "[YES] The system password hash is SHA-512" | tee -a ./audit_results.txt
else
    echo "[NO] The system password hash is NOT SHA-512" | tee -a ./audit_results.txt
fi

#---------------------------------------------------------------------------------------------------------------------------------------#

# 5.4.1.1 Ensure password expiration is 365 days or less

# Didn't set password expiration as it goes against all the best security guidance.  However, i'll still audit this to see if it has been enabled!

echo "############################################################################" >> ./audit_results.txt

echo "[i] Because mandatory, arbitrary password changes are a security anti-pattern, the hardening script hasn't employed this control" | tee -a ./audit_results.txt
echo "[i] However, auditing will still be done against the control to identify if enforced password changes have been applied so that advice can be given about the dangers of doing this" | tee -a ./audit_results.txt

echo "[i] Confirming status of arbitrary password changes: " | tee -a ./audit_results.txt

grep PASS_MAX_DAYS /etc/login.defs | tee -a ./audit_results.txt

echo "[i] The above output should read 'PASS_MAX_DAYS 0'" | tee -a ./audit_results.txt

var=$(grep PASS_MAX_DAYS /etc/login)

if [[ "$var" == "PASS_MAX_DAYS 0" ]]; then
	echo "[YES] Arbitrary password changes are not being enforced" | tee -a ./audit_results.txt
else
	echo "[NO] Arbitrary password changes ARE being employed.  Further guidance should be sought" | tee -a ./audit_results.txt
fi

#---------------------------------------------------------------------------------------------------------------------------------------#

# 5.4.1.2 Ensure minimum days between password changes is 7 or more

echo "############################################################################" >> ./audit_results.txt

echo "[i] Confirming minimum days between password changes is 7" | tee -a ./audit_results.txt
echo "[i] Getting information about the minimum password change period: " | tee -a ./audit_results.txt

grep PASS_MIN_DAYS /etc/login.defs | tee -a ./audit_results.txt

echo "[i] The outputs above should read 'PASS_MIN_DAYS 7'" | tee -a ./audit_results.txt
	
var=$(grep PASS_MIN_DAYS /etc/login.defs)

if [[ "$var" == "PASS_MIN_DAYS 7"; then 
	echo "[YES] The minimum change period is 7 days" | tee -a ./audit_results.txt
else
    echo "[NO] The minimum change period is not 7 days" | tee -a ./audit_results.txt
fi

#---------------------------------------------------------------------------------------------------------------------------------------#

# 5.4.1.3 Ensure password expiration warning days is 7 or more

# Arbitrary password changes have not been applied so this doesn't require any auditing

#---------------------------------------------------------------------------------------------------------------------------------------#

# 5.4.1.4 Ensure inactive password lock is 30 days or less

echo "############################################################################" >> ./audit_results.txt

echo "[i] Confirming inactive password lock is 30 days" | tee -a ./audit_results.txt
echo "[i] Getting information about the password lock period: " | tee -a ./audit_results.txt

useradd -D | grep INACTIVE | tee -a ./audit_results.txt

echo "[i] The outputs above should read 'INACTIVE=30'" | tee -a ./audit_results.txt
	
var=$(useradd -D | grep INACTIVE)

if [[ "$var" == "INACTIVE=30"; then 
	echo "[YES] The inactive password lock period is set at 30 days" | tee -a ./audit_results.txt
else
    echo "[NO] The inactive password lock period is NOT set at 30 days" | tee -a ./audit_results.txt
fi

#---------------------------------------------------------------------------------------------------------------------------------------#

# 5.4.1.5 Ensure all users last password change date is in the past

# Auditing is not required as arbitrary password changes are not being applied

#########################################################################################################################################

# 5.4.2 Ensure system accounts are non-login

echo "############################################################################" >> ./audit_results.txt

echo "[i] Confirming system accounts are non-login" | tee -a ./audit_results.txt
echo "[i] Getting account information: " | tee -a ./audit_results.txt

egrep -v "^\+" /etc/passwd | awk -F: '($1!="root" && $1!="sync" && $1!="shutdown" && $1!="halt" && $3<1000 && $7!="/sbin/nologin" && $7!="/bin/false") {print}' | tee -a ./audit_results.txt

echo "[i] The output above should be blank.  If not, system accounts can login" | tee -a ./audit_results.txt

var=$(egrep -v "^\+" /etc/passwd | awk -F: '($1!="root" && $1!="sync" && $1!="shutdown" && $1!="halt" && $3<1000 && $7!="/sbin/nologin" && $7!="/bin/false") {print}')

if [ -z "$var" ]; then
	echo "[YES] Output is blank, therefore the control is applied" | tee -a ./audit_results.txt
else
	echo "[NO] Output is NOT blank, therefore the control is NOT applied" | tee -a ./audit_results.txt
fi

#########################################################################################################################################

# 5.4.3 Ensure default group for the root account is GID 0

echo "############################################################################" >> ./audit_results.txt

echo "[i] Confirming default group for the root account is GID 0" | tee -a ./audit_results.txt
echo "[i] Getting GID info for the root account: " | tee -a ./audit_results.txt

grep "^root:" /etc/passwd | cut -f4 -d: | tee -a ./audit_results.txt

echo "[i] The output above should be 0" | tee -a ./audit_results.txt

var=$(grep "^root:" /etc/passwd | cut -f4 -d:)

if [[ "$var" == "0" ]; then
	echo "[YES] The default group for root is 0" | tee -a ./audit_results.txt
else
	echo "[NO] The default group for root is NOT 0" | tee -a ./audit_results.txt
fi

#########################################################################################################################################

# 5.4.4 Ensure default user umask is 027 or more restrictive

echo "############################################################################" >> ./audit_results.txt

echo "[i] Ensuring default umask is 027" | tee -a ./audit_results.txt
echo "[i] Getting umask info: " | tee -a ./audit_results.txt

grep "umask" /etc/bashrc | tee -a ./audit_results.txt

echo "[i] The output above should be 'umask 027" | tee -a ./audit_results.txt

var=$(grep "umask" /etc/bashrc)

if [[ "$var" == "umask 027" ]; then
	echo "[YES] The default umask is 027" | tee -a ./audit_results.txt
else
	echo "[NO] The default umask is NOT 027" | tee -a ./audit_results.txt
fi

#########################################################################################################################################

# 5.6 Ensure access to the su command is restricted

# 5.4.4 Ensure default user umask is 027 or more restrictive

echo "############################################################################" >> ./audit_results.txt

echo "[i] Ensuring access to the su command is restricted" | tee -a ./audit_results.txt
echo "[i] Getting wheel info: " | tee -a ./audit_results.txt

grep pam_wheel.so /etc/pam.d/su | tee -a ./audit_results.txt

echo "[i] The output above should be 'auth required pam_wheel.so use_uid'" | tee -a ./audit_results.txt

var=$(grep pam_wheel.so /etc/pam.d/su)

if [[ "$var" == "auth required pam_wheel.so use_uid" ]; then
	echo "[YES] Only users in the 'wheel' group can evoke su" | tee -a ./audit_results.txt
else
	echo "[NO] su is not restricted to just users in the 'wheel' group" | tee -a ./audit_results.txt
fi

echo "[i] Checking which users are in the 'wheel' group and can therefore evoke su" | tee -a ./audit_results.txt
echo "[i] Users in the wheel group are: " | tee -a ./audit_results.txt

grep wheel /etc/group | tee -a ./audit_results.txt

echo "[i] Manually review the above user list and ensure there are no users in the wheel group who shouldn't have su privileges" | tee -a ./audit_results.txt

#########################################################################################################################################

# 6.1.2 Ensure permissions on /etc/passwd are configured

echo "############################################################################" >> ./audit_results.txt

echo "[i] Confirming permissions are set correctly on /etc/passwd" | tee -a ./audit_results.txt
echo "[i] Output of the 'stat' command is: " | tee -a ./audit_results.txt

stat /etc/passwd | tee -a ./audit_results.txt

echo "[i] The above output should be 'Access: (0644/-rw-r--r--) Uid: ( 0/ root) Gid: ( 0/ root)'" | tee -a ./audit_results.txt

var=$(stat /etc/passwd)

if [[ "$var" == "Access: (0644/-rw-r--r--) Uid: ( 0/ root) Gid: ( 0/ root)" ]]; then
	echo "[YES] /etc/passwd permissions appear to be set correctly" | tee -a ./audit_results.txt
else
	echo "[NO] /etc/passwd permissions do NOT appear to be set correctly" | tee -a ./audit_results.txt
fi

#---------------------------------------------------------------------------------------------------------------------------------------#

# 6.1.3 Ensure permissions on /etc/shadow are configured 

echo "############################################################################" >> ./audit_results.txt

echo "[i] Confirming permissions are set correctly on /etc/shadow" | tee -a ./audit_results.txt
echo "[i] Output of the 'stat' command is: " | tee -a ./audit_results.txt

stat /etc/shadow | tee -a ./audit_results.txt

echo "[i] The above output should be 'Access: (0000/----------) Uid: ( 0/ root) Gid: ( 0/ root)" | tee -a ./audit_results.txt

var=$(stat /etc/shadow)

if [[ "$var" == "Access: (0000/----------) Uid: ( 0/ root) Gid: ( 0/ root)" ]]; then
	echo "[YES] /etc/shadow permissions appear to be set correctly" | tee -a ./audit_results.txt
else
	echo "[NO] /etc/shadow permissions do NOT appear to be set correctly" | tee -a ./audit_results.txt
fi

#---------------------------------------------------------------------------------------------------------------------------------------#

# 6.1.4 Ensure permissions on /etc/group are configured

echo "############################################################################" >> ./audit_results.txt

echo "[i] Confirming permissions are set correctly on /etc/group" | tee -a ./audit_results.txt
echo "[i] Output of the 'stat' command is: " | tee -a ./audit_results.txt

stat /etc/group | tee -a ./audit_results.txt

echo "[i] The above output should be 'Access: (0644/-rw-r--r--) Uid: ( 0/ root) Gid: ( 0/ root)'" | tee -a ./audit_results.txt

var=$(stat /etc/group)

if [[ "$var" == "Access: (0644/-rw-r--r--) Uid: ( 0/ root) Gid: ( 0/ root)" ]]; then
	echo "[YES] /etc/group permissions appear to be set correctly" | tee -a ./audit_results.txt
else
	echo "[NO] /etc/group permissions do NOT appear to be set correctly" | tee -a ./audit_results.txt
fi

#---------------------------------------------------------------------------------------------------------------------------------------#

# 6.1.5 Ensure permissions on /etc/gshadow are configured 

echo "############################################################################" >> ./audit_results.txt

echo "[i] Confirming permissions are set correctly on /etc/gshadow" | tee -a ./audit_results.txt
echo "[i] Output of the 'stat' command is: " | tee -a ./audit_results.txt

stat /etc/gshadow | tee -a ./audit_results.txt

echo "[i] The above output should be 'Access: (0000/----------) Uid: ( 0/ root) Gid: ( 0/ root)" | tee -a ./audit_results.txt

var=$(stat /etc/gshadow)

if [[ "$var" == "Access: (0000/----------) Uid: ( 0/ root) Gid: ( 0/ root)" ]]; then
	echo "[YES] /etc/gshadow permissions appear to be set correctly" | tee -a ./audit_results.txt
else
	echo "[NO] /etc/gshadow permissions do NOT appear to be set correctly" | tee -a ./audit_results.txt
fi

#---------------------------------------------------------------------------------------------------------------------------------------#

# 6.1.6 Ensure permission on /etc/passwd- are configured 

echo "############################################################################" >> ./audit_results.txt

echo "[i] Confirming permissions are set correctly on /etc/passwd-" | tee -a ./audit_results.txt
echo "[i] Output of the 'stat' command is: " | tee -a ./audit_results.txt

stat /etc/passwd- | tee -a ./audit_results.txt

echo "[i] The above output should be 'Access: (0644/-rw-------) Uid: ( 0/ root) Gid: ( 0/ root)" | tee -a ./audit_results.txt

var=$(stat /etc/passwd-)

if [[ "$var" == "Access: (0644/-rw-------) Uid: ( 0/ root) Gid: ( 0/ root)" ]]; then
	echo "[YES] /etc/passwd- permissions appear to be set correctly" | tee -a ./audit_results.txt
else
	echo "[NO] /etc/passwd- permissions do NOT appear to be set correctly" | tee -a ./audit_results.txt
fi

#---------------------------------------------------------------------------------------------------------------------------------------#

# 6.1.7 Ensure permissions on /etc/shadow- are configured 

echo "############################################################################" >> ./audit_results.txt

echo "[i] Confirming permissions are set correctly on /etc/shadow-" | tee -a ./audit_results.txt
echo "[i] Output of the 'stat' command is: " | tee -a ./audit_results.txt

stat /etc/shadow- | tee -a ./audit_results.txt

echo "[i] The above output should be 'Access: (0000/----------) Uid: ( 0/ root) Gid: ( 0/ root)" | tee -a ./audit_results.txt

var=$(stat /etc/shadow-)

if [[ "$var" == "Access: (0000/----------) Uid: ( 0/ root) Gid: ( 0/ root)" ]]; then
	echo "[YES] /etc/shadow- permissions appear to be set correctly" | tee -a ./audit_results.txt
else
	echo "[NO] /etc/shadow- permissions do NOT appear to be set correctly" | tee -a ./audit_results.txt
fi

#---------------------------------------------------------------------------------------------------------------------------------------#

# 6.1.8 Ensure permissions on /etc/group- are configured

echo "############################################################################" >> ./audit_results.txt

echo "[i] Confirming permissions are set correctly on /etc/group-" | tee -a ./audit_results.txt
echo "[i] Output of the 'stat' command is: " | tee -a ./audit_results.txt

stat /etc/group- | tee -a ./audit_results.txt

echo "[i] The above output should be 'Access: (0644/-rw-------) Uid: ( 0/ root) Gid: ( 0/ root)" | tee -a ./audit_results.txt

var=$(stat /etc/group-)

if [[ "$var" == "Access: (0644/-rw-------) Uid: ( 0/ root) Gid: ( 0/ root)" ]]; then
	echo "[YES] /etc/group- permissions appear to be set correctly" | tee -a ./audit_results.txt
else
	echo "[NO] /etc/group- permissions do NOT appear to be set correctly" | tee -a ./audit_results.txt
fi

#---------------------------------------------------------------------------------------------------------------------------------------#

# 6.1.9 Ensure permissions on /etc/gshadow- are configured

echo "############################################################################" >> ./audit_results.txt

echo "[i] Confirming permissions are set correctly on /etc/gshadow-" | tee -a ./audit_results.txt
echo "[i] Output of the 'stat' command is: " | tee -a ./audit_results.txt

stat /etc/gshadow- | tee -a ./audit_results.txt

echo "[i] The above output should be 'Access: (0000/----------) Uid: ( 0/ root) Gid: ( 0/ root)" | tee -a ./audit_results.txt

var=$(stat /etc/gshadow-)

if [[ "$var" == "Access: (0000/----------) Uid: ( 0/ root) Gid: ( 0/ root)" ]]; then
	echo "[YES] /etc/gshadow- permissions appear to be set correctly" | tee -a ./audit_results.txt
else
	echo "[NO] /etc/gshadow- permissions do NOT appear to be set correctly" | tee -a ./audit_results.txt
fi

#########################################################################################################################################

# 6.1.10 Ensure no world writable files 

echo "############################################################################" >> ./audit_results.txt

echo "[i] Confirming no world writable files exist" | tee -a ./audit_results.txt
echo "[i] Getting list of world writable files: " | tee -a ./audit_results.txt

df --local -P | awk {'if (NR!=1) print $6'} | xargs -I '{}' find '{}' -xdev -type f -perm -0002 | tee -a ./audit_results.txt

echo "[i] The output above should be blank. If not, remediation will be required to change permissions on any file identified" | tee -a ./audit_results.txt

var=$(df --local -P | awk {'if (NR!=1) print $6'} | xargs -I '{}' find '{}' -xdev -type f -perm -0002)

if [ -z "$var" ]; then
	echo "[YES] Output is blank, therefore no world writable files exist" | tee -a ./audit_results.txt
else
	echo "[NO] Output is NOT blank, therefore remediation is required" | tee -a ./audit_results.txt
fi

#---------------------------------------------------------------------------------------------------------------------------------------#

# 6.1.11 Ensure no unowned files or directories exist

echo "############################################################################" >> ./audit_results.txt

echo "[i] Confirming no unowned files or directories exist" | tee -a ./audit_results.txt
echo "[i] Getting list of unowned files and directories: " | tee -a ./audit_results.txt

df --local -P | awk {'if (NR!=1) print $6'} | xargs -I '{}' find '{}' -xdev -nouser | tee -a ./audit_results.txt

echo "[i] The output above should be blank. If not, remediation will be required to change permissions on any files or directories identified" | tee -a ./audit_results.txt

var=$(df --local -P | awk {'if (NR!=1) print $6'} | xargs -I '{}' find '{}' -xdev -nouser)

if [ -z "$var" ]; then
	echo "[YES] Output is blank, therefore no unowned files or directories exist" | tee -a ./audit_results.txt
else
	echo "[NO] Output is NOT blank, therefore remediation is required" | tee -a ./audit_results.txt
fi

#---------------------------------------------------------------------------------------------------------------------------------------#

# 6.1.12 Ensure no ungrouped files or directories exist 

echo "############################################################################" >> ./audit_results.txt

echo "[i] Confirming no ungrouped files or directories exist" | tee -a ./audit_results.txt
echo "[i] Getting list of ungrouped files and directories: " | tee -a ./audit_results.txt

df --local -P | awk {'if (NR!=1) print $6'} | xargs -I '{}' find '{}' -xdev -nogroup | tee -a ./audit_results.txt

echo "[i] The output above should be blank. If not, remediation will be required" | tee -a ./audit_results.txt

var=$(df --local -P | awk {'if (NR!=1) print $6'} | xargs -I '{}' find '{}' -xdev -nogroup)

if [ -z "$var" ]; then
	echo "[YES] Output is blank, therefore no ungrouped files or directories exist" | tee -a ./audit_results.txt
else
	echo "[NO] Output is NOT blank, therefore remediation is required" | tee -a ./audit_results.txt
fi

#---------------------------------------------------------------------------------------------------------------------------------------#

# 6.2.1 Ensure password fields are not empty

echo "############################################################################" >> ./audit_results.txt

echo "[i] Ensuring password fields are not empty" | tee -a ./audit_results.txt
echo "[i] Getting password fields from /etc/shadow: " | tee -a ./audit_results.txt

cat /etc/shadow | awk -F: '($2 == "" ) { print $1 " does not have a password "}' | tee -a ./audit_results.txt

echo "[i] The output above should be blank. If not, remediation will be required on all usernames listed" | tee -a ./audit_results.txt

#---------------------------------------------------------------------------------------------------------------------------------------#

# 6.2.2 Ensure no legacy "+" entries exist in /etc/passwd

echo "############################################################################" >> ./audit_results.txt

echo "[i] Ensuring no legacy '+' entries exist in /etc/passwd" | tee -a ./audit_results.txt
echo "[i] Getting contents of /etc/passwd: " | tee -a ./audit_results.txt

grep '^\+:' /etc/passwd | tee -a ./audit_results.txt

echo "[i] The output above should be blank. If not, remediation will be required" | tee -a ./audit_results.txt

var=$(grep '^\+:' /etc/passwd)

if [ -z "$var" ]; then
	echo "[YES] Output is blank, therefore no legacy '+' entries exist in /etc/passwd" | tee -a ./audit_results.txt
else
	echo "[NO] Output is NOT blank, therefore remediation is required" | tee -a ./audit_results.txt
fi

#---------------------------------------------------------------------------------------------------------------------------------------#

# 6.2.3 Ensure no legacy "+" entries exist in /etc/shadow

echo "############################################################################" >> ./audit_results.txt

echo "[i] Ensuring no legacy '+' entries exist in /etc/shadow" | tee -a ./audit_results.txt
echo "[i] Getting contents of /etc/shadow: " | tee -a ./audit_results.txt

grep '^\+:' /etc/shadow | tee -a ./audit_results.txt

echo "[i] The output above should be blank. If not, remediation will be required" | tee -a ./audit_results.txt

var=$(grep '^\+:' /etc/shadow)

if [ -z "$var" ]; then
	echo "[YES] Output is blank, therefore no legacy '+' entries exist in /etc/shadow" | tee -a ./audit_results.txt
else
	echo "[NO] Output is NOT blank, therefore remediation is required" | tee -a ./audit_results.txt
fi

#---------------------------------------------------------------------------------------------------------------------------------------#

# 6.2.4 Ensure no legacy "+" entries exist in /etc/group

echo "############################################################################" >> ./audit_results.txt

echo "[i] Ensuring no legacy '+' entries exist in /etc/group" | tee -a ./audit_results.txt
echo "[i] Getting contents of /etc/group: " | tee -a ./audit_results.txt

grep '^\+:' /etc/group | tee -a ./audit_results.txt

echo "[i] The output above should be blank. If not, remediation will be required" | tee -a ./audit_results.txt

var=$(grep '^\+:' /etc/group)

if [ -z "$var" ]; then
	echo "[YES] Output is blank, therefore no legacy '+' entries exist in /etc/group" | tee -a ./audit_results.txt
else
	echo "[NO] Output is NOT blank, therefore remediation is required" | tee -a ./audit_results.txt
fi

#---------------------------------------------------------------------------------------------------------------------------------------#

# 6.2.5 Ensure root is the only UID 0 account

echo "############################################################################" >> ./audit_results.txt

echo "[i] Ensuring root is the only UID 0 account" | tee -a ./audit_results.txt
echo "[i] Getting list of all accounts with UID 0: " | tee -a ./audit_results.txt

cat /etc/passwd | awk -F: '($3 == 0) { print $1 }' | tee -a ./audit_results.txt

echo "[i] The output above should only include 'root' and no other accounts" | tee -a ./audit_results.txt

var=$(cat /etc/passwd | awk -F: '($3 == 0) { print $1 }')

if [[ "$var" == "root" ]; then
	echo "[YES] root is the only account with UID 0" | tee -a ./audit_results.txt
else
	echo "[NO] There are more accounts with UID 0 than just root.  Remediation will be required" | tee -a ./audit_results.txt
fi

#---------------------------------------------------------------------------------------------------------------------------------------#

# 6.2.6 Ensure root PATH integrity

echo "############################################################################" >> ./audit_results.txt

echo "[i] Ensuring root PATH integrity" | tee -a ./audit_results.txt
echo "[i] Running script to verify: " | tee -a ./audit_results.txt

if [ "`echo $PATH | grep ::`" != "" ]; then
	echo "Empty Directory in PATH (::)" | tee -a ./audit_results.txt
fi 

if [ "`echo $PATH | grep :$`" != "" ]; then
	echo "Trailing : in PATH"  | tee -a ./audit_results.txt
fi

p=`echo $PATH | sed -e 's/::/:/' -e 's/:$//' -e 's/:/ /g'`
set -- $p 
while [ "$1" != "" ]; do 
	if [ "$1" = "." ]; then 
		echo "PATH contains ." | tee -a ./audit_results.txt
		shift 
		continue 
	fi 
	if [ -d $1 ]; then 
		dirperm=`ls -ldH $1 | cut -f1 -d" "` 
		if [ `echo $dirperm | cut -c6` != "-" ]; then 
			echo "Group Write permission set on directory $1" | tee -a ./audit_results.txt
		fi 
		if [ `echo $dirperm | cut -c9` != "-" ]; then 
			echo "Other Write permission set on directory $1" | tee -a ./audit_results.txt
		fi 
		dirown=`ls -ldH $1 | awk '{print $3}'` 
		if [ "$dirown" != "root" ] ; then 
			echo $1 is not owned by root  | tee -a ./audit_results.txt
		fi
	else
		echo $1 is not a directory | tee -a ./audit_results.txt
	fi
	shift
done

echo "[i] The script should NOT have returned any results.  If it does, they will need to be remediated" | tee -a ./audit_results.txt

#---------------------------------------------------------------------------------------------------------------------------------------#

# 6.2.7 Ensure all users' home directories exist

echo "############################################################################" >> ./audit_results.txt

echo "[i] Ensuring all users' home directories exist" | tee -a ./audit_results.txt
echo "[i] Running script to verify: " | tee -a ./audit_results.txt

cat /etc/passwd | egrep -v '^(root|halt|sync|shutdown)' | awk -F: '($7 != "/sbin/nologin" && $7 != "/bin/false") { print $1 " " $6 }' | while read user dir; do 
	if [ ! -d "$dir" ]; then 
		echo "The home directory ($dir) of user $user does not exist." | tee -a ./audit_results.txt
	fi
done

echo "[i] The script should NOT have returned any results.  If it does, they will need to be remediated" | tee -a ./audit_results.txt

#---------------------------------------------------------------------------------------------------------------------------------------#

# 6.2.8 Ensure all users' home directories permissions are 750 or more restrictive

echo "############################################################################" >> ./audit_results.txt

echo "[i] Ensuring all users' home directories permissions are 750 or more restrictive" | tee -a ./audit_results.txt
echo "[i] Running script to verify: " | tee -a ./audit_results.txt

cat /etc/passwd | egrep -v '^(root|halt|sync|shutdown)' | awk -F: '($7 != "/sbin/nologin" && $7 != "/bin/false") { print $1 " " $6 }' | while read user dir; do
	if [ ! -d "$dir" ]; then 
		echo "The home directory ($dir) of user $user does not exist." | tee -a ./audit_results.txt
	else 
		dirperm=`ls -ld $dir | cut -f1 -d" "` 
		if [ `echo $dirperm | cut -c6` != "-" ]; then 
			echo "Group Write permission set on the home directory ($dir) of user $user" | tee -a ./audit_results.txt
		fi 
		if [ `echo $dirperm | cut -c8` != "-" ]; then 
			echo "Other Read permission set on the home directory ($dir) of user $user" | tee -a ./audit_results.txt
		fi 
		if [ `echo $dirperm | cut -c9` != "-" ]; then 
			echo "Other Write permission set on the home directory ($dir) of user $user" | tee -a ./audit_results.txt
		fi 
		if [ `echo $dirperm | cut -c10` != "-" ]; then 
			echo "Other Execute permission set on the home directory ($dir) of user $user" | tee -a ./audit_results.txt
		fi 
	fi 
done

echo "[i] The script should NOT have returned any results.  If it does, they will need to be remediated" | tee -a ./audit_results.txt

#---------------------------------------------------------------------------------------------------------------------------------------#

# 6.2.9 Ensure users own their home directories

echo "############################################################################" >> ./audit_results.txt

echo "[i] Ensuring all users' own their home directories" | tee -a ./audit_results.txt
echo "[i] Running script to verify: " | tee -a ./audit_results.txt

cat /etc/passwd | egrep -v '^(root|halt|sync|shutdown)' | awk -F: '($7 != "/sbin/nologin" && $7 != "/bin/false") { print $1 " " $6 }' | while read user dir; do 
	if [ ! -d "$dir" ]; then 
		echo "The home directory ($dir) of user $user does not exist." | tee -a ./audit_results.txt
	else 
		owner=$(stat -L -c "%U" "$dir") 
		if [ "$owner" != "$user" ]; then 
			echo "The home directory ($dir) of user $user is owned by $owner." | tee -a ./audit_results.txt
		fi 
	fi 
done

echo "[i] The script should NOT have returned any results.  If it does, they will need to be remediated" | tee -a ./audit_results.txt

#---------------------------------------------------------------------------------------------------------------------------------------#

# 6.2.10 Ensure users' dot files are not group or world writable

echo "############################################################################" >> ./audit_results.txt

echo "[i] Ensuring users' dot files are not group or world writable" | tee -a ./audit_results.txt
echo "[i] Running script to verify: " | tee -a ./audit_results.txt

cat /etc/passwd | egrep -v '^(root|halt|sync|shutdown)' | awk -F: '($7 != "/sbin/nologin" && $7 != "/bin/false") { print $1 " " $6 }' | while read user dir; do 
	if [ ! -d "$dir" ]; then 
		echo "The home directory ($dir) of user $user does not exist." tee -a ./audit_results.txt
	else 
		for file in $dir/.[A-Za-z0-9]*; do 
			if [ ! -h "$file" -a -f "$file" ]; then 
				fileperm=`ls -ld $file | cut -f1 -d" "` 
				if [ `echo $fileperm | cut -c6` != "-" ]; then 
					echo "Group Write permission set on file $file" tee -a ./audit_results.txt
				fi 
				if [ `echo $fileperm | cut -c9` != "-" ]; then 
					echo "Other Write permission set on file $file" tee -a ./audit_results.txt
				fi 
			fi 
		done 
	fi 
done

echo "[i] The script should NOT have returned any results.  If it does, they will need to be remediated" | tee -a ./audit_results.txt

#---------------------------------------------------------------------------------------------------------------------------------------#

# 6.2.11 Ensure no users have .forward files

echo "############################################################################" >> ./audit_results.txt

echo "[i] Ensuring no users have .forward files " | tee -a ./audit_results.txt
echo "[i] Running script to verify: " | tee -a ./audit_results.txt

cat /etc/passwd | egrep -v '^(root|halt|sync|shutdown)' | awk -F: '($7 != "/sbin/nologin" && $7 != "/bin/false") { print $1 " " $6 }' | while read user dir; do 
	if [ ! -d "$dir" ]; then 
		echo "The home directory ($dir) of user $user does not exist."  tee -a ./audit_results.txt
	else 
		if [ ! -h "$dir/.forward" -a -f "$dir/.forward" ]; then 
			echo ".forward file $dir/.forward exists"  tee -a ./audit_results.txt
		fi 
	fi 
done

echo "[i] The script should NOT have returned any results.  If it does, they will need to be remediated" | tee -a ./audit_results.txt

#---------------------------------------------------------------------------------------------------------------------------------------#

# 6.2.12 Ensure no users have .netrc files

echo "############################################################################" >> ./audit_results.txt

echo "[i] Ensuring no users have .netrc files " | tee -a ./audit_results.txt
echo "[i] Running script to verify: " | tee -a ./audit_results.txt

cat /etc/passwd | egrep -v '^(root|halt|sync|shutdown)' | awk -F: '($7 != "/sbin/nologin" && $7 != "/bin/false") { print $1 " " $6 }' | while read user dir; do 
	if [ ! -d "$dir" ]; then 
		echo "The home directory ($dir) of user $user does not exist." | tee -a ./audit_results.txt
	else 
		if [ ! -h "$dir/.netrc" -a -f "$dir/.netrc" ]; then 
			echo ".netrc file $dir/.netrc exists" | tee -a ./audit_results.txt
		fi 
	fi 
done

echo "[i] The script should NOT have returned any results.  If it does, they will need to be remediated" | tee -a ./audit_results.txt

#---------------------------------------------------------------------------------------------------------------------------------------#

# 6.2.13 Ensure users' .netrc Files are not group or world accessible

echo "############################################################################" >> ./audit_results.txt

echo "[i] Ensuring users .netrc files are not group or world accessible" | tee -a ./audit_results.txt
echo "[i] Running script to verify: " | tee -a ./audit_results.txt

cat /etc/passwd | egrep -v '^(root|halt|sync|shutdown)' | awk -F: '($7 != "/sbin/nologin" && $7 != "/bin/false") { print $1 " " $6 }' | while read user dir; do 
	if [ ! -d "$dir" ]; then 
		echo "The home directory ($dir) of user $user does not exist." 
	else 
		for file in $dir/.netrc; do 
			if [ ! -h "$file" -a -f "$file" ]; then 
				fileperm=`ls -ld $file | cut -f1 -d" "` 
				if [ `echo $fileperm | cut -c5` != "-" ]; then 
					echo "Group Read set on $file" | tee -a ./audit_results.txt
				fi 
				if [ `echo $fileperm | cut -c6` != "-" ]; then 
					echo "Group Write set on $file" | tee -a ./audit_results.txt
				fi 
				if [ `echo $fileperm | cut -c7` != "-" ]; then 
					echo "Group Execute set on $file" | tee -a ./audit_results.txt
				fi 
				if [ `echo $fileperm | cut -c8` != "-" ]; then 
					echo "Other Read set on $file" | tee -a ./audit_results.txt
				fi 
				if [ `echo $fileperm | cut -c9` != "-" ]; then 
					echo "Other Write set on $file" | tee -a ./audit_results.txt
				fi
				if [ `echo $fileperm | cut -c10` != "-" ]; then 
					echo "Other Execute set on $file" | tee -a ./audit_results.txt
				fi
			fi 
		done 
	fi
done

echo "[i] The script should NOT have returned any results.  If it does, they will need to be remediated" | tee -a ./audit_results.txt

#---------------------------------------------------------------------------------------------------------------------------------------#

# 6.2.14 Ensure no users have .rhosts files

echo "############################################################################" >> ./audit_results.txt

echo "[i] Ensuring no users have .rhosts files" | tee -a ./audit_results.txt
echo "[i] Running script to verify: " | tee -a ./audit_results.txt

cat /etc/passwd | egrep -v '^(root|halt|sync|shutdown)' | awk -F: '($7 != "/sbin/nologin" && $7 != "/bin/false") { print $1 " " $6 }' | while read user dir; do 
	if [ ! -d "$dir" ]; then 
		echo "The home directory ($dir) of user $user does not exist." | tee -a ./audit_results.txt
	else 
		for file in $dir/.rhosts; do 
			if [ ! -h "$file" -a -f "$file" ]; then 
				echo ".rhosts file in $dir" | tee -a ./audit_results.txt
			fi 
		done 
	fi 
done

echo "[i] The script should NOT have returned any results.  If it does, they will need to be remediated" | tee -a ./audit_results.txt

#---------------------------------------------------------------------------------------------------------------------------------------#

# 6.2.15 Ensure all groups in /etc/passwd exist in /etc/group

echo "############################################################################" >> ./audit_results.txt

echo "[i] Ensuring all groups in /etc/passwd exist in /etc/group" | tee -a ./audit_results.txt
echo "[i] Running script to verify: " | tee -a ./audit_results.txt

for i in $(cut -s -d: -f4 /etc/passwd | sort -u ); do 
	grep -q -P "^.*?:[^:]*:$i:" /etc/group 
	if [ $? -ne 0 ]; then 
		echo "Group $i is referenced by /etc/passwd but does not exist in /etc/group" | tee -a ./audit_results.txt
	fi 
done

echo "[i] The script should NOT have returned any results.  If it does, they will need to be remediated" | tee -a ./audit_results.txt

#---------------------------------------------------------------------------------------------------------------------------------------#

# 6.2.16 Ensure no duplicate UIDs exist

echo "############################################################################" >> ./audit_results.txt

echo "[i] Ensuring no duplicate UIDs exist" | tee -a ./audit_results.txt
echo "[i] Running script to verify: " | tee -a ./audit_results.txt

cat /etc/passwd | cut -f3 -d":" | sort -n | uniq -c | while read x ; do 
	[ -z "${x}" ] && break 
	set - $x 
	if [ $1 -gt 1 ]; then 
		users=`awk -F: '($3 == n) { print $1 }' n=$2 /etc/passwd | xargs` 
		echo "Duplicate UID ($2): ${users}" | tee -a ./audit_results.txt
	fi
done

echo "[i] The script should NOT have returned any results.  If it does, they will need to be remediated" | tee -a ./audit_results.txt

#---------------------------------------------------------------------------------------------------------------------------------------#

# 6.2.17 Ensure no duplicate GIDs exist

echo "############################################################################" >> ./audit_results.txt

echo "[i] Ensuring no duplicate GIDs exist" | tee -a ./audit_results.txt
echo "[i] Running script to verify: " | tee -a ./audit_results.txt

cat /etc/group | cut -f3 -d":" | sort -n | uniq -c | while read x ; do 
	[ -z "${x}" ] && break 
	set - $x 
	if [ $1 -gt 1 ]; then 
		groups=`awk -F: '($3 == n) { print $1 }' n=$2 /etc/group | xargs` 
		echo "Duplicate GID ($2): ${groups}" | tee -a ./audit_results.txt 
	fi
done

echo "[i] The script should NOT have returned any results.  If it does, they will need to be remediated" | tee -a ./audit_results.txt

#---------------------------------------------------------------------------------------------------------------------------------------#

# 6.2.18 Ensure no duplicate user names exist

echo "############################################################################" >> ./audit_results.txt

echo "[i] Ensuring no duplicate user names exist" | tee -a ./audit_results.txt
echo "[i] Running script to verify: " | tee -a ./audit_results.txt

cat /etc/passwd | cut -f1 -d":" | sort -n | uniq -c | while read x ; do 
	[ -z "${x}" ] && break 
	set - $x 
	if [ $1 -gt 1 ]; then 
		uids=`awk -F: '($1 == n) { print $3 }' n=$2 /etc/passwd | xargs` 
		echo "Duplicate User Name ($2): ${uids}" | tee -a ./audit_results.txt
	fi 
done

echo "[i] The script should NOT have returned any results.  If it does, they will need to be remediated" | tee -a ./audit_results.txt

#---------------------------------------------------------------------------------------------------------------------------------------#

# 6.2.19 Ensure no duplicate group names exist

echo "############################################################################" >> ./audit_results.txt

echo "[i] Ensuring no duplicate group names exist" | tee -a ./audit_results.txt
echo "[i] Running script to verify: " | tee -a ./audit_results.txt

cat /etc/group | cut -f1 -d":" | sort -n | uniq -c | while read x ; do 
	[ -z "${x}" ] && break 
	set - $x 
	if [ $1 -gt 1 ]; then 
		gids=`gawk -F: '($1 == n) { print $3 }' n=$2 /etc/group | xargs` 
		echo "Duplicate Group Name ($2): ${gids}" | tee -a ./audit_results.txt
	fi 
done

echo "[i] The script should NOT have returned any results.  If it does, they will need to be remediated" | tee -a ./audit_results.txt

#########################################################################################################################################

echo "[i] Audit script has now completed."

