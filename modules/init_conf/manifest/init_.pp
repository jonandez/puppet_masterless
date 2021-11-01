# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   include init_config
class init_config {
  notify { 'Basic Server Message':
    message  => 'Apply module init_conf'
  }

  include init_config::init_conf
}





# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   include init_config::init_conf
class init_config::init_conf {

  notify { 'Init Config Class':
    message  => 'Applying Init Config Class'
  }

  file { 'post-hook':
    ensure  => file,
    path    => '/home/vagrant/puppet_masterless/.git/hooks/post-merge',
    source  => 'puppet:///modules/init_config/post-merge',
    mode    => '0755',
    owner   => root,
    group   => root,
  }


  cron { 'puppet-apply':
    ensure  => present,
    command => "cd /home/vagrant/puppet_masterless ; /usr/bin/git pull",
    user    => root,
    minute  => '*/2',
    require => File['post-hook'],
  }


 # exec { 'puppet module install puppet-firewalld --version 4.4.0':
  
  exec { 'puppet module install puppet-firewalld --version 4.4.0':
    path        => ['/usr/bin', '/usr/sbin', '/opt/puppetlabs/puppet/bin'],
  }
}
