#!/bin/zsh
windapsearch -d $DOMAIN -u $USER -p $PASSWORD --dc $DC --module users --json | jq -r '.[].sAMAccountName' | tee $TARGETS/all_users.list;
windapsearch -d $DOMAIN -u $USER -p $PASSWORD --dc $DC --module computers --json | jq -r '.[].dNSHostName' | tee $TARGETS/computers.list;
cme smb $TARGETS/computers.list | tee $TARGETS/reached_computers.cme;
cat $TARGETS/reached_computers.cme | cut -d ' ' -f 10 | tee $TARGETS/reached_computers.list;
cat $TARGETS/reached_computers.list | grep -v 'Windows 10\|Windows 7' | cut -d ' ' -f 10 | tee $TARGETS/reached_non_workstations.list;
cat $TARGETS/reached_computers.cme | grep 'signing:False' | cut -d ' ' -f 10 | tee $TARGETS/relay_targets.list
while read in; do host "$in"; done < $TARGETS/relay_targets.list | grep -oE "\b([0-9]{1,3}\.){3}[0-9]{1,3}\b" | tee $TARGETS/relay_targets.ip;
while read in; do host "$in"; done < $TARGETS/reached_computers.list | grep -oE "\b([0-9]{1,3}\.){3}[0-9]{1,3}\b" | tee $TARGETS/reached_computers.ip;
while read in; do host "$in"; done < $TARGETS/computers.list | grep -oE "\b([0-9]{1,3}\.){3}[0-9]{1,3}\b" | tee $TARGETS/computers.ip;
cat $TARGETS/reached_computers.ip | cut -d '.' -f 1,2,3 | sort | uniq -c | sort -nr | tee $TARGETS/reached_computers.ranges;
cat $TARGETS/computers.ip | cut -d '.' -f 1,2,3 | sort | uniq -c | sort -nr | tee $TARGETS/computers.ranges;
