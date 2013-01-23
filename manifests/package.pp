class check_debsums::package {

  package { 'debsums':
    ensure => installed
  }

  file { '/usr/lib/nagios/plugins/check_debsums':
    mode => '0755',
    owner => root,
    group => root,
    source => 'puppet:///modules/debsums/check_debsums'
  }

}
