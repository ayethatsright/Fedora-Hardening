#! /bin/bash


# This is the test script to establish which hardening is currently causing problems with Wifi on Dell machines.
# I've commented out all the likely suspects for the issue and will re-enable them in turn to identify which one is problematic
# and can then work out what needs to be done to remediate it

#########################################################################################################################################

# Confirming that the script has been run with sudo

if [[ $EUID -ne 0 ]]; then
	echo "You need to run this script as root (with sudo)"
	exit
fi

echo "[i] Beginning hardening process"

#########################################################################################################################################

# POSSIBLE SUSPECT %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

# Updating system

#echo "[i] Updating the OS"

#yum -y upgrade

#########################################################################################################################################

# 1.1.1.1 	Ensure mounting of cramfs filesystems is disabled

echo "[i] Disabling the mounting of cramfs filesystems"

if [ -f "/etc/modprobe.d/CIS.conf" ]; then
    echo "install cramfs /bin/true" >> /etc/modprobe.d/CIS.conf
else
    echo "install cramfs /bin/true" > /etc/modprobe.d/CIS.conf
fi

#---------------------------------------------------------------------------------------------------------------------------------------#

# 1.1.1.2 Ensure mounting of freevxfs filesystems is disabled

echo "[i] Disabling the mounting of freevxfs filesystems"

echo "install freevxfs /bin/true" >> /etc/modprobe.d/CIS.conf

#---------------------------------------------------------------------------------------------------------------------------------------#

# 1.1.1.3 Ensure mounting of jffs2 filesystems is disabled

echo "[i] Disabling the mounting of jffs2 filesystems"

echo "install jffs2 /bin/true" >> /etc/modprobe.d/CIS.conf
#---------------------------------------------------------------------------------------------------------------------------------------#

# 1.1.1.4 Ensure mounting of hfs filesystems is disabled

echo "[i] Disabling the mounting of hfs filesystems"

echo "install hfs /bin/true" >> /etc/modprobe.d/CIS.conf

#---------------------------------------------------------------------------------------------------------------------------------------#

# 1.1.1.5 Ensure mounting of hfsplus filesystems is disabled

echo "[i] Disabling the mounting of hfsplus filesystems"

echo "install hfsplus /bin/true" >> /etc/modprobe.d/CIS.conf

#---------------------------------------------------------------------------------------------------------------------------------------#

# 1.1.1.6 Ensure mounting of squashfs filesystems is disabled

echo "[i] Disabling the mounting of squashfs filesystems"

echo "install squashfs /bin/true" >> /etc/modprobe.d/CIS.conf

#---------------------------------------------------------------------------------------------------------------------------------------#

# 1.1.1.7 Ensure mounting of udf filesystems is disabled

echo "[i] Disabling the mounting of udf filesystems"

echo "install udf /bin/true" >> /etc/modprobe.d/CIS.conf


#########################################################################################################################################

# 1.1.8 Ensure nodev option set on /var/tmp partition
# 1.1.9 Ensure nosuid option set on /var/tmp partition
# 1.1.10 Ensure noexec option set on /var/tmp partition

echo "[i] Setting nodev, nosuid and noexec options on the /var/tmp partition"

LINEVARTMP="tmpfs /var/tmp tmpfs nosuid,noexec,nodev 0 0"

grep -F "$LINEVARTMP" /etc/fstab || echo "$LINEVARTMP" | tee -a /etc/fstab > /dev/null

#---------------------------------------------------------------------------------------------------------------------------------------#

# 1.1.14 Ensure nodev option set on /home partition

echo "[i] Setting nodev option on the /home partition"
echo "[i] If you have a separate home partition, you need to provide it's name"
echo "[i] If a separate home partition doesn't exist, leave this blank."
echo "[i] Home partition example: /dev/xvda1"
read -p "[?] Enter home partition: " HOME_PARTITION

if [ -b $HOME_PARTITION ]
then
    LINEHOME="$HOME_PARTITION /home ext4 rw,relatime,nodev,data=ordered 0 0"
    grep -F "$LINEHOME" /etc/fstab || echo "$LINEHOME" | tee -a /etc/fstab > /dev/null
fi

mount -o remount,nodev /home

#---------------------------------------------------------------------------------------------------------------------------------------#

# 1.1.15 Ensure nodev option set on /dev/shm partition
# 1.1.16 Ensure nosuid option set on /dev/shm partition
# 1.1.17 Ensure noexec option set on /dev/shm partition

echo "[i] Setting nodev, nosuid and noexec options on the /dev/shm partition"

LINEDEVSHM="tmpfs /dev/shm tmpfs nosuid,noexec,nodev,relatime,rw 0 0"

grep -F "$LINEDEVSHM" /etc/fstab || echo "$LINEDEVSHM" | tee -a /etc/fstab > /dev/null

mount -o remount,nodev,nosuid,noexec /dev/shm

#---------------------------------------------------------------------------------------------------------------------------------------#

# 1.1.21 Ensure sticky bit is set on all world-writable directories

echo "[i] Setting the sticky bit on all world-writable directories"

df --local -P | awk {'if (NR!=1) print $6'} | xargs -I '{}' find '{}' -xdev -type d -perm -0002 2>/dev/null | xargs chmod a+t

#########################################################################################################################################

# 1.2.2 Ensure gpgcheck is globally activated

echo "[i] Globally activating gpgcheck"

echo "gpgcheck=1" > /etc/yum.conf

#########################################################################################################################################


# POSSIBLE SUSPECT %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

# 1.3.1 Ensure AIDE is installed

#echo "[i] Installing, configuring and initialising AIDE (the file integrity checking tool)"

# Installing AIDE:
#yum -y install aide 

# Inistialising AIDE
#aide --init
#mv /var/lib/aide/aide.db.new.gz /var/lib/aide/aide.db.gz

# Due to a bug in Red Hat there will be some errors reported that 'algorithm 7 not available'

#---------------------------------------------------------------------------------------------------------------------------------------#


# POSSIBLE SUSPECT %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

# 1.3.2 Ensure filesystem integrity is regularly checked

#echo "[i] Creating a cron job to regularly check filesystem integrity using AIDE"

#LINEAIDECRON="0 5 * * * /usr/bin/aide.wrapper --config /etc/aide/aide.conf --check"
#AIDECRONFILE=/home/tmp.cron

#crontab -l -u root 2>/dev/null

#if [ $? -eq 0 ]
#then
#    crontab -u root -l > $AIDECRONFILE
#else
#    touch $AIDECRONFILE
#fi

#grep -qF "$LINEAIDECRON" "$AIDECRONFILE" || echo "$LINEAIDECRON" | tee -a "$AIDECRONFILE" > /dev/null

#crontab -u root $AIDECRONFILE

#rm $AIDECRONFILE

#########################################################################################################################################

# 1.4.1 Ensure permissions on bootloader config are configured

echo "[i] Setting correct permissions for the bootloader config"

chown root:root /boot/efi/EFI/fedora/grub.cfg
chmod og-rwx /boot/efi/EFI/fedora/grub.cfg


#---------------------------------------------------------------------------------------------------------------------------------------#

# 1.4.3 Ensure authentication required for single user mode

echo "[i] Configuring 'single user mode' to require authentication"

if grep -q "ExecStart=" /usr/lib/systemd/system/rescue.service; then 
	sed -i 's/^ExecStart=.*/ExecStart=-\/bin\/sh -c "\/sbin\/sulogin; \/usr\/bin\/systemctl --fail --no-block default"/' /usr/lib/systemd/system/rescue.service
else
    echo "ExecStart=-/bin/sh -c \"/sbin/sulogin; /usr/bin/systemctl --fail --no-block default\"" >> /usr/lib/systemd/system/rescue.service
fi


if grep -q "ExecStart=" /usr/lib/systemd/system/emergency.service; then 
	sed -i 's/^ExecStart=.*/ExecStart=-\/bin\/sh -c "\/sbin\/sulogin; \/usr\/bin\/systemctl --fail --no-block default"/' /usr/lib/systemd/system/emergency.service
else
    echo "ExecStart=-/bin/sh -c \"/sbin/sulogin; /usr/bin/systemctl --fail --no-block default\"" >> /usr/lib/systemd/system/emergency.service
fi

#########################################################################################################################################

# 1.5.1 Ensure core dumps are restricted

echo "[i] Ensuring core dumps are restricted"

DUMPLINE="* hard core 0"
DUMPFILE=/etc/security/limits.conf

grep -qF "$DUMPLINE" "$DUMPFILE" || echo "$DUMPLINE" | tee -a "$DUMPFILE" > /dev/null

DUMPABLELINE="fs.suid_dumpable=0"
DUMPABLEFILE=/etc/sysctl.conf

grep -qF "$DUMPABLELINE" "$DUMPABLEFILE" || echo "$DUMPABLELINE" | tee -a "$DUMPABLEFILE" > /dev/null

sysctl -w fs.suid_dumpable=0

#---------------------------------------------------------------------------------------------------------------------------------------#

# 1.5.3 Ensure address space layout randomization (ASLR) is enabled

echo "[i] Enabling address space layout randomization (ASLR)"

if grep -q "^kernel.randomize_va_space" /etc/sysctl.conf; then 
	sed -i 's/^kernel.randomize_va_space.*/kernel.randomize_va_space = 2/' /etc/sysctl.conf
else
    echo "kernel.randomize_va_space = 2" >> /etc/sysctl.conf
fi

sysctl -w kernel.randomize_va_space=2


#########################################################################################################################################

# 1.7.1.1 Ensure message of the day is configured properly

echo "[i] Creating the message of the day"

echo "Unauthorised use of this system is an offence under the Computer Misuse Act 1990. All activity may be monitored and reported." > /etc/motd

#---------------------------------------------------------------------------------------------------------------------------------------#

# 1.7.1.2 Ensure local login warning banner is configured properly

echo "[i] Creating the local login warning banner"

echo "Unauthorised use of this system is an offence under the Computer Misuse Act 1990. All activity may be monitored and reported." > /etc/issue

#---------------------------------------------------------------------------------------------------------------------------------------#

# 1.7.1.3 Ensure remote login warning banner is configured properly

echo "[i] Creating the remote login warning banner"

echo "Unauthorised use of this system is an offence under the Computer Misuse Act 1990. All activity may be monitored and reported." > /etc/issue.net

#---------------------------------------------------------------------------------------------------------------------------------------#

# 1.7.1.4 Ensure permissions on /etc/motd are configured

echo "[i] Setting correct permissions on /etc/motd"

chown root:root /etc/motd
chmod 644 /etc/motd

#---------------------------------------------------------------------------------------------------------------------------------------#

# 1.7.1.5 Ensure permissions on /etc/issue are configured

echo "[i] Setting correct permissions on /etc/issue"

chown root:root /etc/issue
chmod 644 /etc/issue

#---------------------------------------------------------------------------------------------------------------------------------------#

# 1.7.1.6 Ensure permissions on /etc/issue.net are configured

echo "[i] Setting correct permissions on /etc/issue.net"
chown root:root /etc/issue.net
chmod 644 /etc/issue.net

#---------------------------------------------------------------------------------------------------------------------------------------#


# POSSIBLE SUSPECT %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
# I seem to recall this caused some issues on the Ubuntu hardening

# 1.7.2 Ensure GDM login banner is configured

#echo "[i] Setting the GDM login banner"

#echo "user-db:user" > /etc/dconf/profile/gdm
#echo "system-db:gdm" >> /etc/dconf/profile/gdm
#echo "file-db:/usr/share/gdm/greeter-dconf-defaults" >> /etc/dconf/profile/gdm

#makedir /etc/dconf/db/gdm.d/

#echo "[org/gnome/login-screen]" > /etc/dconf/db/gdm.d/01-banner-message
#echo "banner-message-enable=true" >> /etc/dconf/db/gdm.d/01-banner-message
#echo "banner-message-text='Unauthorised use of this system is an offence under the Computer Misuse Act 1990. All activity may be monitored and reported.'" >> /etc/dconf/db/gdm.d/01-banner-message

#dconf update

#########################################################################################################################################

# 2.2.1.2 Ensure ntp is configured

echo "[i] Installing ntp"

yum -y install ntp

echo "[i] Configuring ntp"

echo "restrict -4 default kod nomodify notrap nopeer noquery" > /etc/ntp.conf
echo "restrict -6 default kod nomodify notrap nopeer noquery" >> /etc/ntp.conf

# Adding NTP servers for the UK

echo "server 0.uk.pool.ntp.org" >> /etc/ntp.conf
echo "server 1.uk.pool.ntp.org" >> /etc/ntp.conf
echo "server 2.uk.pool.ntp.org" >> /etc/ntp.conf
echo "server 3.uk.pool.ntp.org" >> /etc/ntp.conf


# Adding '-u ntp:ntp' to the /etc/sysconfig/ntpd

if grep -q "^OPTIONS=" /etc/sysconfig/ntpd; then 
	sed -i 's/^OPTIONS=.*/OPTIONS="-u ntp:ntp"/' /etc/sysconfig/ntpd
else
    echo "OPTIONS=\"-u ntp:ntp\"" >> /etc/init.d/ntp
fi

#---------------------------------------------------------------------------------------------------------------------------------------#

# 2.2.1.3 Ensure chrony is configured 

echo "[i] Configuring chrony"

sed -i 's/^pool.*/#/' /etc/chrony.conf

# Adding NTP servers for the UK
echo "server 0.uk.pool.ntp.org" >> /etc/chrony.conf
echo "server 1.uk.pool.ntp.org" >> /etc/chrony.conf
echo "server 2.uk.pool.ntp.org" >> /etc/chrony.conf
echo "server 3.uk.pool.ntp.org" >> /etc/chrony.conf

#########################################################################################################################################

# POSSIBLE SUSPECT %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
# Shouldn't be this but can't be 100% positive

# 2.2.3 Ensure Avahi Server is not enabled
#echo "[i] Disabling Avahi Server"
#systemctl disable avahi-daemon

#---------------------------------------------------------------------------------------------------------------------------------------#

# 2.2.7 Ensure NFS and RPC are not enabled 
echo "[i] Disabling NFS and RPC"
systemctl disable nfs-server
systemctl disable rpcbind

#---------------------------------------------------------------------------------------------------------------------------------------#

# 2.3.1 Ensure NIS Client is not installed

echo "[i] Uninstalling NIS client"
yum remove -y nis

#---------------------------------------------------------------------------------------------------------------------------------------#

# 2.3.2 Ensure rsh client is not installed

echo "[i] Uninstalling the rsh client"
yum remove -y rsh-client rsh-redone-client

#---------------------------------------------------------------------------------------------------------------------------------------#

# 2.3.3 Ensure talk client is not installed

echo "[i] Uninstalling the talk client"
yum remove -y talk

#---------------------------------------------------------------------------------------------------------------------------------------#

# 2.3.4 Ensure telnet client is not installed 

echo "[i] Uninstalling the telnet client"
yum remove -y telnet

#---------------------------------------------------------------------------------------------------------------------------------------#

# 2.3.5 Ensure LDAP client is not installed 

echo "[i] Uninstalling the LDAP client"
yum remove -y ldap-utils


#########################################################################################################################################


# POSSIBLE SUSPECT %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

# 3.2.1 Ensure source routed packets are not accepted

#echo "[i] Ensuring source routed packets are not accepted"

#if grep -q "^net.ipv4.conf.all.accept_source_route" /etc/sysctl.conf; then 
#	sed -i 's/^net.ipv4.conf.all.accept_source_route.*/net.ipv4.conf.all.accept_source_route = 0/' /etc/sysctl.conf
#else
#    echo "net.ipv4.conf.all.accept_source_route = 0" >> /etc/sysctl.conf
#fi


#if grep -q "^net.ipv4.conf.default.accept_source_route" /etc/sysctl.conf; then 
#	sed -i 's/^net.ipv4.conf.default.accept_source_route.*/net.ipv4.conf.default.accept_source_route = 0/' /etc/sysctl.conf
#else
#    echo "net.ipv4.conf.default.accept_source_route = 0" >> /etc/sysctl.conf
#fi

#sysctl -w net.ipv4.conf.all.accept_source_route=0
#sysctl -w net.ipv4.conf.default.accept_source_route=0
#sysctl -w net.ipv4.route.flush=1

#---------------------------------------------------------------------------------------------------------------------------------------#


# POSSIBLE SUSPECT %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

# 3.2.2 Ensure ICMP redirects are not accepted

#echo "[i] Ensuring ICMP redirects are not accepted"

#if grep -q "^net.ipv4.conf.all.accept_redirects" /etc/sysctl.conf; then 
#	sed -i 's/^net.ipv4.conf.all.accept_redirects.*/net.ipv4.conf.all.accept_redirects = 0/' /etc/sysctl.conf
#else
#    echo "net.ipv4.conf.all.accept_redirects = 0" >> /etc/sysctl.conf
#fi


#if grep -q "^net.ipv4.conf.default.accept_redirects" /etc/sysctl.conf; then 
#	sed -i 's/^net.ipv4.conf.default.accept_redirects.*/net.ipv4.conf.default.accept_redirects = 0/' /etc/sysctl.conf
#else
#    echo "net.ipv4.conf.default.accept_redirects = 0" >> /etc/sysctl.conf
#fi

#sysctl -w net.ipv4.conf.all.accept_redirects=0
#sysctl -w net.ipv4.conf.default.accept_redirects=0
#sysctl -w net.ipv4.route.flush=1

#---------------------------------------------------------------------------------------------------------------------------------------#


# POSSIBLE SUSPECT %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

# 3.2.3 Ensure secure ICMP redirects are not accepted

#echo "[i] Ensuring secure ICMP redirects are not accepted"

#if grep -q "^net.ipv4.conf.all.secure_redirects" /etc/sysctl.conf; then 
#	sed -i 's/^net.ipv4.conf.all.secure_redirects.*/net.ipv4.conf.all.secure_redirects = 0/' /etc/sysctl.conf
#else
#    echo "net.ipv4.conf.all.secure_redirects = 0" >> /etc/sysctl.conf
#fi


#if grep -q "^net.ipv4.conf.default.secure_redirects" /etc/sysctl.conf; then 
#	sed -i 's/^net.ipv4.conf.default.secure_redirects.*/net.ipv4.conf.default.secure_redirects = 0/' /etc/sysctl.conf
#else
#    echo "net.ipv4.conf.default.secure_redirects = 0" >> /etc/sysctl.conf
#fi

#sysctl -w net.ipv4.conf.all.secure_redirects=0
#sysctl -w net.ipv4.conf.default.secure_redirects=0
#sysctl -w net.ipv4.route.flush=1

#---------------------------------------------------------------------------------------------------------------------------------------#


# POSSIBLE SUSPECT %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


# 3.2.4 Ensure suspicious packets are logged 

#echo "[i] Ensuring suspicious packets are logged"

#if grep -q "^net.ipv4.conf.all.log_martians" /etc/sysctl.conf; then 
#	sed -i 's/^net.ipv4.conf.all.log_martians.*/net.ipv4.conf.all.log_martians = 1/' /etc/sysctl.conf
#else
#    echo "net.ipv4.conf.all.log_martians = 1" >> /etc/sysctl.conf
#fi


#if grep -q "^net.ipv4.conf.default.log_martians" /etc/sysctl.conf; then 
#	sed -i 's/^net.ipv4.conf.default.log_martians.*/net.ipv4.conf.default.log_martians = 1/' /etc/sysctl.conf
#else
#    echo "net.ipv4.conf.default.log_martians = 1" >> /etc/sysctl.conf
#fi


#sysctl -w net.ipv4.conf.all.log_martians=1
#sysctl -w net.ipv4.conf.default.log_martians=1
#sysctl -w net.ipv4.route.flush=1

#---------------------------------------------------------------------------------------------------------------------------------------#



# POSSIBLE SUSPECT %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

# 3.2.5 Ensure broadcast ICMP requests are ignored

#echo "[i] Ensuring broadcast ICMP requests are ignored"

#if grep -q "^net.ipv4.icmp_echo_ignore_broadcasts" /etc/sysctl.conf; then 
#	sed -i 's/^net.ipv4.icmp_echo_ignore_broadcasts.*/net.ipv4.icmp_echo_ignore_broadcasts = 1/' /etc/sysctl.conf
#else
#    echo "net.ipv4.icmp_echo_ignore_broadcasts = 1" >> /etc/sysctl.conf
#fi

#sysctl -w net.ipv4.icmp_echo_ignore_broadcasts=1
#sysctl -w net.ipv4.route.flush=1

#---------------------------------------------------------------------------------------------------------------------------------------#

# 3.2.6 Ensure bogus ICMP responses are ignored

#echo "[i] Ensuring bogus ICMP responses are ignored"

#if grep -q "^net.ipv4.icmp_ignore_bogus_error_responses" /etc/sysctl.conf; then 
#	sed -i 's/^net.ipv4.icmp_ignore_bogus_error_responses.*/net.ipv4.icmp_ignore_bogus_error_responses = 1/' /etc/sysctl.conf
#else
#    echo "net.ipv4.icmp_ignore_bogus_error_responses = 1" >> /etc/sysctl.conf
#fi


#sysctl -w net.ipv4.icmp_ignore_bogus_error_responses=1
#sysctl -w net.ipv4.route.flush=1

#---------------------------------------------------------------------------------------------------------------------------------------#


# POSSIBLE SUSPECT %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


# 3.2.7 Ensure Reverse Path Filtering is enabled

#echo "[i] Ensuring Reverse Path Filtering is enabled"

#if grep -q "^net.ipv4.conf.all.rp_filter" /etc/sysctl.conf; then 
#	sed -i 's/^net.ipv4.conf.all.rp_filter.*/net.ipv4.conf.all.rp_filter = 1/' /etc/sysctl.conf
#else
#    echo "net.ipv4.conf.all.rp_filter = 1" >> /etc/sysctl.conf
#fi


#if grep -q "^net.ipv4.conf.default.rp_filter" /etc/sysctl.conf; then 
#	sed -i 's/^net.ipv4.conf.default.rp_filter.*/net.ipv4.conf.default.rp_filter = 1/' /etc/sysctl.conf
#else
#    echo "net.ipv4.conf.default.rp_filter = 1" >> /etc/sysctl.conf
#fi


#sysctl -w net.ipv4.conf.all.rp_filter=1
#sysctl -w net.ipv4.conf.default.rp_filter=1
#sysctl -w net.ipv4.route.flush=1

#---------------------------------------------------------------------------------------------------------------------------------------#


# POSSIBLE SUSPECT %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

# 3.2.8 Ensure TCP SYN Cookies is enabled

#echo "[i] Ensuring TCP SYN Cookies is enabled"

#if grep -q "^net.ipv4.tcp_syncookies" /etc/sysctl.conf; then 
#	sed -i 's/^net.ipv4.tcp_syncookies.*/net.ipv4.tcp_syncookies = 1/' /etc/sysctl.conf
#else
 #   echo "net.ipv4.tcp_syncookies = 1" >> /etc/sysctl.conf
#fi


#sysctl -w net.ipv4.tcp_syncookies=1
#sysctl -w net.ipv4.route.flush=1

#########################################################################################################################################



# POSSIBLE SUSPECT %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



# 3.4.1 Ensure TCP Wrappers is installed 

#echo "[i] Installing TCP Wrappers"
#yum install -y tcp_wrappers

#---------------------------------------------------------------------------------------------------------------------------------------#


# POSSIBLE SUSPECT %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

# 3.4.2 Ensure /etc/hosts.allow is configured 

# This control is dependent on the individual organisation so will need to be set manually
# By default, nothing is in the hosts.allow so when we generate the hosts.deny in the next section, no IP addresses with be permitted to connect with the host

#echo "[i] Creating a default hosts.allow file"
#echo "ALL: 192.168.0.0/255.255.0.0" > /etc/hosts.allow

#---------------------------------------------------------------------------------------------------------------------------------------#


# POSSIBLE SUSPECT %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

# 3.4.3 Ensure /etc/hosts.deny is configured 

#echo "[i] The hosts.deny file is being created with a default 'deny all' rule"
#echo "ALL: ALL" >> /etc/hosts.deny

#---------------------------------------------------------------------------------------------------------------------------------------#


# POSSIBLE SUSPECT %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


# 3.4.4 Ensure permissions on /etc/hosts.allow are configured
#echo "[i] Setting the correct permissions for the 'hosts.allow' file"

#chown root:root /etc/hosts.allow
#chmod 644 /etc/hosts.allow

#---------------------------------------------------------------------------------------------------------------------------------------#


# POSSIBLE SUSPECT %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


# 3.4.4 Ensure permissions on /etc/hosts.deny are configured

#echo "[i] Setting the correct permissions for the 'hosts.deny' file"

#chown root:root /etc/hosts.deny
#chmod 644 /etc/hosts.deny

#---------------------------------------------------------------------------------------------------------------------------------------#

# 3.6.1 Ensure iptables is installed
# 3.6.2 Ensure default deny firewall policy 
# 3.6.3 Ensure loopback traffic is configured 
# 3.6.5 Ensure firewall rules exist for all open ports 


# POSSIBLE SUSPECT %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
# POSSIBLE SUSPECT %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

#echo "[i] Installing iptables"

#yum install -y iptables

#echo "[i] Flushing iptable rules"

#iptables -F

#echo "[i] Adding default deny firewall policy"

#iptables -P INPUT DROP
#iptables -P OUTPUT DROP 
#iptables -P FORWARD DROP

#echo "[i] Configuring loopback traffic rules within firewall policy"

#iptables -A INPUT -i lo -j ACCEPT
#iptables -A OUTPUT -o lo -j ACCEPT
#iptables -A INPUT -s 127.0.0.0/8 -j DROP

#echo "[i] Opening inbound ssh (tcp port 22) connections within the firewall policy" 

#iptables -A INPUT -p tcp --dport 22 -m state --state NEW -j ACCEPT

#echo "[i] All additional rules will need to be added manually if required"

#########################################################################################################################################

# 4.2.1.1 Ensure rsyslog Service is enabled 
# 4.2.3 Ensure rsyslog or syslog-ng is installed

yum install -y rsyslog
yum install -y syslog-ng

echo "[i] Enabling rsyslog service"
systemctl enable rsyslog

# 4.2.1.3 Ensure rsyslog default file permissions configured 

echo "[i] Configuring rsyslog default file permissions"
if grep -q "^$FileCreateMode" /etc/sysctl.conf; then 
	sed -i 's/^$FileCreateMode.*/$FileCreateMode 0640/' /etc/sysctl.conf
else
    echo "$FileCreateMode 0640" >> /etc/sysctl.conf
fi


#---------------------------------------------------------------------------------------------------------------------------------------#

# 4.2.2.1 Ensure syslog-ng service is enabled

echo "[i] Enabling syslog-ng service"
systemctl enable syslog-ng

#---------------------------------------------------------------------------------------------------------------------------------------#

# 4.2.2.3 Ensure syslog-ng default file permissions configured

echo "[i] Configuring the syslog-ng default file permissions"
if grep -q "^options {" /etc/syslog-ng/syslog-ng.conf; then 
	sed -i 's/^options {.*/options { chain_hostnames(off); flush_lines(0); perm(0640); stats_freq(3600); threaded(yes); };/' /etc/syslog-ng/syslog-ng.conf
else
	echo "options { chain_hostnames(off); flush_lines(0); perm(0640); stats_freq(3600); threaded(yes); };" >> /etc/syslog-ng/syslog-ng.conf
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

# 5.4.1.2 Ensure minimum days between password changes is 7 or more

echo "[i] Setting the minimum days between password changes to 7"

if grep -q "PASS_MIN_DAYS" /etc/login.defs; then
	sed -i 's/^PASS_MIN_DAYS.*/PASS_MIN_DAYS 7/' /etc/login.defs
else
	echo "PASS_MIN_DAYS 7" >> /etc/login.defs
fi


#---------------------------------------------------------------------------------------------------------------------------------------#

# 5.4.1.4 Ensure inactive password lock is 30 days or less

echo "[i] Locking passwords after 30 days of inactivity"

useradd -D -f 30


#########################################################################################################################################

# 5.4.3 Ensure default group for the root account is GID 0

echo "[i] Setting the default group for root to GID 0"
usermod -g 0 root

#########################################################################################################################################

# 5.4.4 Ensure default user umask is 027 or more restrictive

echo "[i] Setting default user umask to 027"

umask 027

#########################################################################################################################################


# POSSIBLE SUSPECT %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
# POSSIBLE SUSPECT %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
# POSSIBLE SUSPECT %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
# POSSIBLE SUSPECT %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
# POSSIBLE SUSPECT %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

# this is a possible suspect but i'm leaving it in originally 

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

chown root:root /etc/shadow
chmod 000 /etc/shadow

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

# Rebooting system to ensure all changes take effect

read -r -p "[i] System will now reboot to ensure all changes take effect. Press ENTER to continue..."

sudo reboot




