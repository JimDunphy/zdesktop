#!/bin/bash
#
# Jim Dunphy 7/10/2015
#
# Wrapper to open zimbra desktop with a modern/different browser and
# bypass the older built-in browser that is the default.
#
# Usage:
# Save this script as a short cut on the users desktop.
#

export PATH=/usr/bin:/bin:/usr/sbin

# change to users home directory
cd ~

# 
if [ -e Library ]; then
   #echo mac 
   webapp='./Library/Zimbra Desktop/zdesktop.webapp/webapp.ini'
   zdesktop='./Library/Zimbra Desktop/bin/zdesktop'
   browser='open -a safari'
   ps -ef |grep Desktop |grep java > /dev/null 2>/dev/null
   isRunning=$?
else
   #linux
   webapp=./zdesktop/zdesktop.webapp/webapp.ini
   zdesktop='./zdesktop/bin/zdesktop'
   browser='google-chrome'
   ps auxw | grep zdesktop | grep jar > /dev/null 2>/dev/null
   isRunning=$?
fi

# bring up the backend first if not running
if [ ! $isRunning -eq 0 ]; then
  $zdesktop start
  sleep 2
fi

# the URL is created on the fly by the backend
url=$(grep uri "$webapp" |sed 's/uri=//')

#launch browser with this URL
$browser $url

#%%% need to shutdown but what if user has other instances running
#    including the original zimbra desktop instance.
#echo waiting
#$zdesktop stop
