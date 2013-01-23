define check_debsums (
  $packages
) {

  if ! is_array($packages) {
    fail("packages must be an array: '${packages}'")
  }

  file { '/etc/nagios/nrpe.d/check_debsums':
    mode => '0644',
    owner => root,
    group => root,
    content => inline_template("[check_debsums]=/usr/lib/nagios/plugins/check_debsums <%= packages.join(' ') -%>")
  }

}
