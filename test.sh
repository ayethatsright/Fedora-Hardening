#! /bin/bash


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
