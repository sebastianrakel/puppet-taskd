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

```
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

```
include taskd
```

This will install taskd, make it listen on the default port (53589) on your node's FQDN, and generate the default self-signed certificates.

## Usage

FIXME
This section is where you describe how to customize, configure, and do the fancy stuff with your module here. It's especially helpful if you include usage examples and code samples for doing things with your module.

## Reference

FIXME
Users need a complete list of your module's classes, types, defined types providers, facts, and functions, along with the parameters for each. You can provide this list either via Puppet Strings code comments or as a complete list in the README Reference section.

* If you are using Puppet Strings code comments, this Reference section should include Strings information so that your users know how to access your documentation.

* If you are not using Puppet Strings, include a list of all of your classes, defined types, and so on, along with their parameters. Each element in this listing should include:

  * The data type, if applicable.
  * A description of what the element does.
  * Valid values, if the data type doesn't make it obvious.
  * Default value, if any.

## Limitations

This module has only been tested with Debian `stretch` (9.0). It should work with `jessie` using backports.

## Testing

A Vagrantfile is provided to test the working state of the module. Using the
Vagrantfile requires `vagrant-puppet-install`. Just execute it with `vagrant
up`.

## Development

FIXME
Since your module is awesome, other users will want to play with it. Let them know what the ground rules for contributing are.
