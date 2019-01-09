#!/bin/bash
echo "be sure to execute script with sudo priviliges" 
echo "Pls enter your filename:"
read filename
if [ ! -f $filename ]; then
	echo "no such file, terminating script"
    exit 1
fi;

echo "Extracting $filename to /" 
tar xvf $filename --overwrite --strip-components 1 -C /

#services to restart 
services=(
mstpd
frr
sshd
lldpd
)
 
#Commands 
echo "executing ifreload -a"
ifreload -a

for service in ${services[@]}
do
	echo "restarting $service "
	service $service restart
done
echo "Configuration restore finished, switchd will be restarted which will drop active connection also!" 
service switchd restart