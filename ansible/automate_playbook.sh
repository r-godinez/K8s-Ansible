#!/bin/bash

export PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

SSHPASS="/usr/bin/sshpass"
ANSIBLE="/home/monitor/.local/bin/ansible-playbook"

PASSWORD="ece"

INVENTORY="/home/monitor/ansible/hosts"
PLAYBOOK="/home/monitor/ansible/recover-node-exporter.yaml"
LOGFILE="/home/monitor/ansible/ansible.log"
DEBUGFILE="/home/monitor/ansible/debug.log"

# Debug
echo "Start: $(date)" >> "$DEBUGFILE"
echo "PATH: $PATH" >> "$DEBUGFILE"

# Log start
echo "Running Ansible Playbook at $(date)" >> "$LOGFILE"

# Run Ansible with sshpass
$SSHPASS -p "$PASSWORD" $ANSIBLE -i "$INVENTORY" "$PLAYBOOK" \
	--user=monitor \
	--ask-become-pass \
	--extra-vars "ansible_ssh_pass=$PASSWORD ansible_become_pass=$PASSWORD" >> "$LOGFILE" 2>&1

# Log end
echo "Finished at $(date)" >> "$LOGFILE"
