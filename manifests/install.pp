# A description of what this class does
#
# @summary A short summary of the purpose of this class
#
# @example
#   include telly::install
class telly::install {
  # Make sure version has is a string with at least 1 char
  unless $::telly_version =~ String[1] {
    fail ("telly_version must be a non zero length string '${::telly_version}'")
  }
  $package_name    = 'telly.Binaries.Mono'
  $package_version = $::telly_version
  $install_path    = $::telly::install_path
  $extract_dir     = "${install_path}/telly-${package_version}"
  $creates         = "${extract_dir}/telly"
  $link            = "${install_path}/telly"
  $repository_url  = 'https://github.com/telly/telly/releases/download/'
  $package_source  = "${repository_url}/${package_version}/${package_name}.tar.gz"
  $archive_name    = "${package_name}-${package_version}.tar.gz"
  $archive_path    = "${install_path}/${archive_name}"

  if $telly::package_manage {
    file { $extract_dir:
      ensure => directory,
      owner  => $::telly::user,
      group  => $::telly::group,
    }

    archive { $archive_name:
      path         => $archive_path,
      source       => $package_source,
      extract      => true,
      extract_path => $extract_dir,
      creates      => $creates,
      cleanup      => true,
      user         => $::telly::user,
      group        => $::telly::group,
      notify       => Service['telly.service'],
    }
    file { $link:
      ensure    => 'link',
      target    => $creates,
      subscribe => Archive[$archive_name],
    }
    exec {'telly_tidy':
      cwd         => $install_path,
      path        => '/usr/sbin:/usr/bin:/sbin:/bin:',
      command     => "ls -dtr ${link}-* | head -n -${telly::keep} | xargs rm -rf",
      #onlyif      => "test $(ls -d ${link}-* | wc -l) -gt ${telly::keep}",
      refreshonly => true,
      subscribe   => Archive[$archive_name],
    }
  }
}
# vim: number tabstop=8 expandtab shiftwidth=2 softtabstop=2

