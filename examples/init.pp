class { 'taskd':
  pki_vars     => {
    organization    => 'Testing Automation',
    country         => 'DE',
    state           => 'North Rhine-Westphalia',
    locality        => 'Cologne',
    bits            => 4096,
    expiration_days => 3650,
    cn              => $::fqdn,
  }
}

taskd::user { 'Willi Millowitsch':
  user => 'Willi',
  org  => 'Millowitsch',
}
