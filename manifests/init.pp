# A description of what this class does
#
# @summary A short summary of the purpose of this class
#
# @example
#   include telly
class telly (
  Boolean                 $package_manage = true,
  Boolean                 $service_manage = true,
  Boolean                 $service_active = true,
  String                  $user           = 'telly',
  String                  $group          = 'telly',
  String                  $install_path   = '/opt',
  String                  $config         = 'telly.config.toml',
  Integer                 $port           = 6077,
  Optional[Integer[1,10]] $keep           = 1,
  ) {

  contain telly::config
  contain telly::install
  contain telly::service

  Class['::telly::install']
  -> Class['::telly::config']
  ~> Class['::telly::service']

}
# vim: nu tabstop=8 expandtab shiftwidth=2 softtabstop=2