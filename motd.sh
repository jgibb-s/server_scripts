#! /bin/bash

#clear

# get the load averages
read one five fifteen rest < /proc/loadavg

#ascii font from http://patorjk.com/software/taag/#p=display&f=Delta%20Corps%20Priest%201&t=bloch
echo "
 _______  _                 _        _______ _________
(  ____ \| \    /\|\     /|( (    /|(  ____ \\__   __/
| (    \/|  \  / /( \   / )|  \  ( || (    \/   ) (   
| (_____ |  (_/ /  \ (_) / |   \ | || (__       | |   
(_____  )|   _ (    \   /  | (\ \) ||  __)      | |   
      ) ||  ( \ \    ) (   | | \   || (         | |   
/\____) ||  /  \ \   | |   | )  \  || (____/\   | |   
\_______)|_/    \/   \_/   |/    )_)(_______/   )_(   
                                                                                                    
 `date +"%A, %e %B %Y, %r"`
 `uname -srmo`$(tput setaf 1) 
$(tput setaf 3)
////////////////////////////////////////////////////
| Uptime.........: `uptime | sed -E 's/^[^,]*up *//; s/, *[[:digit:]]* users.*//; s/min/minutes/; s/([[:digit:]]+):0?([[:digit:]]+)/\1 hours, \2 minutes/' | cut -d',' -f1-2` 
| Load Averages..: ${one}, ${five}, ${fifteen} (1, 5, 15 min)  
| IP Addresses...: `ip a | grep "/24" | awk '{print $2}' | cut -d"/" -f 1` and `cat ~/.ip`
| SSH Logins.....: Currently $(who -q | tail -n 1 | cut -d'=' -f2) user(s) logged in
//////////////////////////////////////////////////// $(tput sgr0)"
~/scripts/config.sh
~/scripts/services.sh
echo -e ""
~/scripts/docker-services.sh
echo""
~/scripts/disk_space.sh
#~/scripts/hddtemp.sh

echo  ""

#`
# Running Processes..: `ps ax | wc -l | tr -d " "`
# Uptime.............: $(uptime | awk -F'( |,|:)+' '{print $6,$7",",$8,"hours,",$9,"minutes."}')
