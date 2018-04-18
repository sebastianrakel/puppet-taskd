# taskd::user
#
# Generates a new user (certicate).
#
# @summary Generates a new user (certicate).
#
# @example
#   taskd::user { 'namevar': }
define taskd::user(
  String $user = $name,
  String $org = $name,
) {
  # TODO is there a better way to do this without falling back to ::params?
  $config = lookup('taskd::config')
  $taskd_executable = lookup('taskd::taskd_executable')
  $pki_base_dir = lookup('taskd::pki_base_dir')

  exec { "Create org ${org} if necessary":
    command => "${taskd_executable} add --data ${config['root']} org ${org}",
    onlyif  => "/usr/bin/test ! -d ${config['root']}/orgs/${org}",
  }

  exec { "Create user ${user} if necessary":
    command => "${taskd_executable} add --data ${config['root']} user ${org} ${user}",
    unless  => "/bin/grep '^user=${user}$' -r ${config['root']}/orgs/${org}",
  }

  # Sadly, taskd does bad SSL where the user certificate is yet another
  # certificate for the server, just a new key.  This would need a
  # institutional fix, so we're running with it at the moment.
  exec { "Create certificate for ${user}":
    command => "${pki_base_dir}/generate.client ${config['root']}/${org}_${user}",
    cwd     => $pki_base_dir,
    creates => "${config['root']}/${org}_${user}.cert.pem",
  }
}
