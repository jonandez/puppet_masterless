class init_conf {
  file { 'post-hook':
    ensure  => file,
    path    => '/home/vagrant/puppet_masterless.git/hooks/post-merge',
    source  => 'puppet:///modules/init_conf/post-merge',
    mode    => 0755,
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


  exec { 'puppet module install puppet-firewalld --version 4.4.0':
    path   => '/usr/bin:/usr/sbin:/bin',
  }

}
