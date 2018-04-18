class { 'taskd':
  pki_vars     => {
    organization => 'Testing Automation',
    country      => 'DE',
    state        => 'North Rhine-Westphalia',
    locality     => 'Cologne',
  }
}

taskd::user { 'Willi Millowitsch':
  user => 'Willi',
  org  => 'Millowitsch',
}
