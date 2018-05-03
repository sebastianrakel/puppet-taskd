# Reference

## Classes
* [`taskd`](#taskd): Installs and configures the taskwarrior taskd server.
## Defined types
* [`taskd::user`](#taskduser): Generates a new user (certicate).
## Classes

### taskd

taskd

Installs and configures the taskwarrior taskd server.
It will generate self-signed certificates in the default configuration.
Module defaults are sourced from hiera.

#### Examples
##### 
```puppet
include taskd
```


#### Parameters

The following parameters are available in the `taskd` class.

##### `package_name`

Data type: `String`

The package name of taskd to use for installation.

##### `service_name`

Data type: `String`

The installed service name for taskd.

##### `config_file`

Data type: `String`

Location of the taskd configuration.

##### `owner`

Data type: `String`

Owner for files/directories. Should be the taskd user.

##### `group`

Data type: `String`

Group for files/directories. Should be the taskd user's group.

##### `config`

Data type: `Hash`

(Additional) configuration options that should be defined; the module supplies minimal defaults via hiera.

##### `certificate`

Data type: `Struct[{
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
  }]`

Hash of configuration settings for client, server and ca cert/key/crl.

##### `pki_base_dir`

Data type: `Optional[String]`

Base directory of the taskd PKI scripts. Only used when $generate_certificates is true.

##### `pki_vars_file`

Data type: `Optional[String]`

Location to put PKI vars file for generation. Only used when $generate_certificates is true.

##### `pki_vars`

Data type: `Optional[Struct[{
    bits            => Numeric,
    expiration_days => Numeric,
    cn              => String[1],
    organization    => String[1],
    country         => String[1],
    state           => String[1],
    locality        => String[1],
  }]]`

PKI variables for generation certificates. Only used when $generate_certificates is true.

##### `generate_certificates`

Data type: `Boolean`

Generate self-signed certificates with the taskd PKI. Defaults to 'true'.

Default value: `true`


## Defined types

### taskd::user

taskd::user

Generates a new user (certicate).
The certificate will be placed in the taskd root directory.

#### Examples
##### 
```puppet
taskd::user { 'namevar': }
```


#### Parameters

The following parameters are available in the `taskd::user` defined type.

##### `user`

Data type: `String`

Name of the user to create. Defaults to namevar.

Default value: $name

##### `org`

Data type: `String`

Name of the organization for the user. Will be created if necessary; defaults to namevar.

Default value: $name

##### `ensure`

Data type: `Enum['present', 'absent']`

State of the user; valid values are 'present' and 'absent'. Defaults to 'present'.

Default value: 'present'


