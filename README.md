# taskd

[![Build Status](https://travis-ci.org/towo/puppet-taskd.svg?branch=master)](https://travis-ci.org/towo/puppet-taskd/builds)
[![Coverage Status](https://coveralls.io/repos/github/towo/puppet-taskd/badge.svg?branch=master)](https://coveralls.io/github/towo/puppet-taskd?branch=master)

#### Table of Contents

1. [Description](#description)
2. [Setup - The basics of getting started with taskd](#setup)
    * [What taskd affects](#what-taskd-affects)
    * [Setup requirements](#setup-requirements)
    * [Beginning with taskd](#beginning-with-taskd)
3. [Usage - Configuration options and additional functionality](#usage)
4. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
5. [Limitations - OS compatibility, etc.](#limitations)
6. [Development - Guide for contributing to the module](#development)

## Description

This module will install the [Taskwarrior](https://taskwarrior.org) "taskserver" (taskd).

It will take of installing the software and generating self-signed server-client certificates.

## Setup

### Beginning with taskd

First, some basic details for certificate generation need to be set (with hiera):

```yaml
taskd::pki_vars:
  organization: 'My Cool Org'
  country: 'DE'
  state: 'North Rhine-Westphalia'
  locality: 'Cologne'
```

Additional variables have defined defaults:

| Variable        | Default value |
|-----------------|---------------|
| cn              | `$fqdn`       |
| bits            | 4096          |
| expiration_days | 365           |

Then simply include the taskd class on whatever node you want it to be set up:

```puppet
include taskd
```

This will install taskd, make it listen on the default port (53589) on your node's FQDN, and generate the default self-signed certificates.

## Usage

### Creating users

A defined type `taskd::user` facilitates creating users. Example:

```puppet
taskd::user { 'towo': }
```

You can specify the actual name of the user used as well as the org:

```puppet
taskd::user { 'Tobias Wolter':
  name => 'towo',
  org  => 'My cool Org'
}
```

## Reference

Markdown documentation is available in [REFERENCE.md](REFERENCE.md). HTML documentation is available in [doc/](doc/index.html).

## Limitations

This module has only been tested with Debian `stretch` (9.0). It should work with `jessie` using backports.

## Testing

A Vagrantfile is provided to test the working state of the module. Using the
Vagrantfile requires `vagrant-puppet-install`. Just execute it with `vagrant
up`.

## Development

Feel free to open issues.

Use the standard GitHub approach of forking, pull request, etc. to submit code modifications.
