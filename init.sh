#!/bin/bash
########################################################################
#       Puppet provision script: Puppet and Git Installation           #
########################################################################

# Update OS
#apt update -y

# Install puppet agent
apt install puppet-agent -y

# Install Git
apt install git -y

# Create puppet.conf file
cat << 'EOF' > /etc/puppet/puppet.conf

[main]
logdir=/var/log/puppet
vardir=/var/lib/puppet
ssldir=/var/lib/puppet/ssl
rundir=/var/run/puppet
factpath=$confdir/facter

EOF

# Create run config

cat << 'EOF' > /etc/puppet/manifests/site.pp

node default {
    include cron-puppet
}

EOF
