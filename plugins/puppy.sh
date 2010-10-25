#!/bin/sh
set -e
#Puppy Linux plugin for multicd.sh
#version 6.0
#Copyright (c) 2010 maybeway36
#
#Permission is hereby granted, free of charge, to any person obtaining a copy
#of this software and associated documentation files (the "Software"), to deal
#in the Software without restriction, including without limitation the rights
#to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
#copies of the Software, and to permit persons to whom the Software is
#furnished to do so, subject to the following conditions:
#
#The above copyright notice and this permission notice shall be included in
#all copies or substantial portions of the Software.
#
#THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
#IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
#FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
#AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
#LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
#OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
#THE SOFTWARE.
if [ $1 = scan ];then
	if [ -f puppy.iso ];then
		echo "Puppy Linux"
		touch $TAGS/puppies/puppy
		#touch $TAGS/puppy.needsname #Comment out this line and multicd.sh won't ask for a custom name for this ISO
	fi
elif [ $1 = copy ];then
	if [ -f puppy.iso ];then
		echo "Copying Puppy..."
		puppycommon puppy
	fi
elif [ $1 = writecfg ];then
#BEGIN PUPPY ENTRY#
if [ -f puppy.iso ];then
if [ -f $TAGS/puppy.name ] && [ "$(cat $TAGS/puppy.name)" != "" ];then
	PUPNAME=$(cat $TAGS/puppy.name)
else
	PUPNAME="Puppy Linux"
fi
if [ -d $WORK/puppy ];then
	EXTRAARGS="psubdir=puppy"
fi
echo "label puppy
menu label ^$PUPNAME
kernel /puppy/vmlinuz
append pmedia=cd $EXTRAARGS
initrd /puppy/initrd.gz
#label puppy-nox
#menu label $PUPNAME (boot to command line)
#kernel /puppy/vmlinuz
#append pmedia=cd pfix=nox $EXTRAARGS
#initrd /puppy/initrd.gz
#label puppy-noram
#menu label $PUPNAME (don't load to RAM)
#kernel /puppy/vmlinuz
#append pmedia=cd pfix=noram $EXTRAARGS
#initrd /puppy/initrd.gz
" >> $WORK/boot/isolinux/isolinux.cfg
fi
#END PUPPY ENTRY#
else
	echo "Usage: $0 {scan|copy|writecfg}"
	echo "Use only from within multicd.sh or a compatible script!"
	echo "Don't use this plugin script on its own!"
fi
