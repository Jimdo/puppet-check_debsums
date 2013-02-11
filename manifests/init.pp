define check_debsums (
  $packages
) {

  if ! is_array($packages) {
    fail("packages must be an array: '${packages}'")
  }

  file { "/etc/nagios/nrpe.d/check_debsums_${name}.cfg":
    mode    => '0644',
    owner   => root,
    group   => root,
    content => inline_template("command[check_debsums_${name}]=sudo /usr/lib/nagios/plugins/check_debsums <%= packages.join(' ') -%>"),
    notify  => Service['nagios-nrpe-server'],
    require => Class['check_debsums::package'],
  }

}
