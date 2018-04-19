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
  String $owner,
  String $group,
  Struct[{
    'pid.file'    => String[1],
    'root'        => String[1],
    'server.cert' => String[1],
    'server.key'  => String[1],
    'server.crl'  => String[1],
    'clinet.cert' => String[1],
    'client.key'  => String[1],
    'ca.cert'     => String[1],
  }] $config,
  Struct[{
    client => Struct[{
      cert => String[1],
      key  => String[1],
    }],
    server => Struct[{
      cert => String[1],
      key  => String[1],
      crl  => String[1],
    }],
    ca     => Struct[{
      cert => String[1],
    }],
  }] $certificate,
  Optional[String] $pki_base_dir,
  Optional[String] $pki_vars_file,
  Optional[Struct[{
    bits            => Numeric,
    expiration_days => Numeric,
    cn              => String[1],
    organization    => String[1],
    country         => String[1],
    state           => String[1],
    locality        => String[1],
  }]] $pki_vars,
  Boolean $generate_certificates = true,
) {
  package { $package_name:
    ensure => present,
  }

  # Generate taskserver certificates unless user says otherwise
  if $generate_certificates {
    # Location for the SSL variable file
    file { $pki_vars_file:
      ensure  => present,
      content => template('taskd/vars.erb'),
      require => Package[$package_name],
      owner   => $owner,
      group   => $group,
    }

    [ 'ca', 'server', 'client'].each |String $type| {
      exec { "Generate taskserver ${type} certificates":
        command => "${pki_base_dir}/generate.${type}",
        cwd     => $config['root'],
        path    => [ '/usr/bin', '/usr/sbin', '/bin', '/sbin' ],
        creates => $certificate[$type]['cert'],
        user    => $owner,
      }
    }

    exec { 'Generate taskserver revocation list':
      command => "${pki_base_dir}/generate.crl",
      cwd     => $config['root'],
      path    => [ '/usr/bin', '/usr/sbin', '/bin', '/sbin' ],
      creates => $certificate['server']['crl'],
      user    => $owner,
    }
  }

  # Template out configuration file
  file { $config_file:
    ensure  => present,
    content => template('taskd/config.erb'),
    owner   => $owner,
    group   => $group,
    notify  => Service[$service_name],
  }

  # Ensure the taskd root directory exists
  file { $config['root']:
    ensure => directory,
    owner  => $owner,
    group  => $group,
  }

  # Ensure the organization directory exists
  file { "${config['root']}/orgs":
    ensure => directory,
    owner  => $owner,
    group  => $group,
  }

  # Ensures service is running after configuration has been rolled out.
  service { $service_name:
    ensure  => running,
    enable  => true,
    require => Package[$package_name],
  }
}
