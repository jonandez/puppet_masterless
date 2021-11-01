class init_conf {
  file { 'post-hook':
    ensure  => file,
    path    => '/etc/puppet/.git/hooks/post-merge',
    source  => 'puppet:///modules/init-conf/post-merge.sh',
    mode    => 0755,
    owner   => root,
    group   => root,
  }


  cron { 'puppet-apply':
    ensure  => present,
    command => "cd /etc/puppet ; /usr/bin/git pull",
    user    => root,
    minute  => '*/60',
    require => File['post-hook'],
  }


  exec { 'puppet module install puppet-firewalld --version 4.4.0':
    path   => '/usr/bin:/usr/sbin:/bin',
  }

}
