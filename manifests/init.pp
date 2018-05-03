# taskd
#
# Installs and configures the taskwarrior taskd server.
# It will generate self-signed certificates in the default configuration.
# Module defaults are sourced from hiera.
#
# @summary Installs and configures the taskwarrior taskd server.
#
# @example
#   include taskd
#
# @param package_name
#   The package name of taskd to use for installation.
# @param service_name
#   The installed service name for taskd.
# @param config_file
#   Location of the taskd configuration.
# @param owner
#   Owner for files/directories. Should be the taskd user.
# @param group
#   Group for files/directories. Should be the taskd user's group.
# @param config
#   (Additional) configuration options that should be defined; the module supplies minimal defaults via hiera.
# @param certificate
#   Hash of configuration settings for client, server and ca cert/key/crl.
# @param pki_base_dir
#   Base directory of the taskd PKI scripts. Only used when $generate_certificates is true.
# @param pki_vars_file
#   Location to put PKI vars file for generation. Only used when $generate_certificates is true.
# @param pki_vars
#   PKI variables for generation certificates. Only used when $generate_certificates is true.
# @param generate_certificates
#   Generate self-signed certificates with the taskd PKI. Defaults to 'true'.
class taskd (
  String $package_name,
  String $service_name,
  String $config_file,
  String $owner,
  String $group,
  Hash $config,
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
