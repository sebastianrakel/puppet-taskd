# taskd
#
# Installs and configures the taskwarrior taskd server.
# It will generate self-signed certificates in the default configuration.
#
# @summary Installs and configures the taskwarrior taskd server.
#
# @example
#   include taskd
class taskd (
  String $package_name,
  String $service_name,
  String $config_file,
  Hash $config,
  Struct[{
    bits            => Optional[Numeric],
    expiration_days => Optional[Numeric],
    organization    => String[1],
    cn              => String[1],
    country         => String[1],
    state           => String[1],
    locality        => String[1],
  }] $pki_vars,
  Struct[{
    client => {
      cert => String[1],
      key  => String[1],
      crl  => String[1],
    },
    server => {
      cert => String[1],
      key  => String[1],
    },
    ca     => {
      cert => String[1],
    },
  }] $certificate,
  Optional[String] $pki_base_dir,
  Optional[String] $pki_vars_file,
  Boolean $generate_certificates = true,
) {
  package { $package_name:
    ensure => present,
  }

  service { $service_name:
    ensure  => running,
    enable  => true,
    require => Package[$::package_name],
  }

    # Generate taskserver certificates unless user says otherwise
  if $generate_certificates {
    # Location for the SSL variable file
    file { $pki_vars_file:
      ensure  => present,
      content => template('vars'),
      require => Package[$package_name],
    }

    exec { 'Generate taskserver certificaties':
      command => "${pki_base_dir}/generate",
      cwd     => $pki_base_dir,
      path    => [ '/usr/bin', '/usr/sbin', '/bin', '/sbin' ],
      creates => $certificate['server']['cert'],
    }
  }

  file { $config_file:
    ensure  => present,
    content => template('config'),
  }
}
