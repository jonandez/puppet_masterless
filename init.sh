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
touch /etc/puppet/puppet.conf
cat << 'EOF' > /etc/puppet/puppet.conf

[main]
logdir=/var/log/puppet
vardir=/var/lib/puppet
ssldir=/var/lib/puppet/ssl
rundir=/var/run/puppet
factpath=$confdir/facter

EOF

# Create run config
touch /etc/puppet/manifests/site.pp
cat << 'EOF' > /etc/puppet/manifests/site.pp

node default {
    include init_conf
    include basic_server
}

EOF

# Pull repo
cd /etc/puppet/modules/ && git clone https://github.com/jonandez/puppet_masterless.git
mv /etc/puppet/modules/puppet_masterless/modules /etc/puppet/modules/ 
rm -rf /etc/puppet/modules/puppet_masterless/