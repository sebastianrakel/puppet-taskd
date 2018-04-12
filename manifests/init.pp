# taskd
#
# Installs and configures the taskwarrior taskd server.
#
# @summary Installs and configures the taskwarrior taskd server.
#
# @example
#   include taskd
class taskd (
  String $package_name
) {
  package { $package_name:
    ensure => present,
  }
}
