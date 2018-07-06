#!/bin/bash
cat > /etc/ssmtp/ssmtp.conf << EOF
root=postmaster
mailhub=${RELAYHOST:-localhost}:${RELAYPORT:-25}
hostname=`hostname`
FromLineOverride=YES
EOF
