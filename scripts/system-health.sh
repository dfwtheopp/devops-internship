#!/bin/bash

echo " SYSTEM HEALTH REPORT "

echo ""
echo "Hostname:"
hostname

echo ""
echo "Current User:"
whoami

echo ""
echo "Date and Time:"
date

echo ""
echo "Uptime:"
uptime

echo ""
echo "Private IP:"
hostname -I

echo ""
echo "Default Gateway:"
ip route | grep default

echo ""
echo "Disk Usage:"
df -h

echo ""
echo "Memory Usage:"
free -h

echo ""
echo "Top Processes:"
ps aux --sort=-%cpu | head

echo ""
echo "Listening Ports:"
ss -tuln

echo ""
echo " END OF REPORT "