# A description of what this class does
#
# @summary A short summary of the purpose of this class
#
# @example
#   include telly::service
class telly::service {
  if $telly::service_manage == true {
    systemd::unit_file { 'telly.service':
      enable  => $telly::service_enable,
      active  => $telly::service_active,
      content => template('telly/telly.service.erb'),
    }
  }
}
# vim: number tabstop=8 expandtab shiftwidth=2 softtabstop=2 ai

