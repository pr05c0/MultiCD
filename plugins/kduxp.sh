#!/bin/sh
set -e
. ./functions.sh
#KDuXP plugin for multicd.sh
#version 6.6
#Copyright (c) 2011 libertyernie
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

if [ $1 = links ];then
	echo "KDuXPv*.iso kduxp.iso none"
elif [ $1 = scan ];then
	if [ -f kduxp.iso ];then
		echo "KDuXP"
	fi
elif [ $1 = copy ];then
	if [ -f kduxp.iso ];then
		echo "Copying KDuXP..."
		ubuntucommon kduxp
	fi
elif [ $1 = writecfg ];then
	 if [ -f kduxp.iso ];then
		if [ -f kduxp.version ];then
			KDUVER=" $(cat kduxp.version)"
			if [ "$KDUVER" == "" ];then
				KDUVER=""
			fi
		else
			KDUVER=""
		fi
		echo "label kduxp
		menu label --> KDuXP$KDUVER Menu
		com32 menu.c32
		append /boot/kduxp/kduxp.cfg
		" >> multicd-working/boot/isolinux/isolinux.cfg
		echo "label back
		menu label Back to main menu
		com32 menu.c32
		append /boot/isolinux/isolinux.cfg
		" >> multicd-working/boot/kduxp/kduxp.cfg
	fi
else
	echo "Usage: $0 {links|scan|copy|writecfg}"
	echo "Use only from within multicd.sh or a compatible script!"
	echo "Don't use this plugin script on its own!"
fi