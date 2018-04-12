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
  String $group = $name,
) {
  # TODO is there a better way to do this without falling back to ::params?
  $config = lookup('taskd::config')
  $taskd_executable = lookup('taskd::taskd_executable')

  exec { 'Create group if necessary':
    command => "${taskd_executable} --data ${config['root']} add org ${group}",
    onlyif  => "/usr/bin/test ! -d ${config['root']}/orgs/${group}",
  }

  exec { 'Create user if necessary':
    command => "${taskd_executable} --data ${config['root']} add user ${group} ${user}",
    onlyif  => "/bin/grep -v '^user=${user}$' -r ${config['root']}/orgs/${group}",
  }
}
