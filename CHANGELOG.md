# Changelog

All notable changes to this project will be documented in this file.

## Release 1.0.1

The "of course I forgot the documentation" release.

**Features**

* Now has Puppet Strings-based documentation.

**Bugfixes**

* Remove FIXMEs from README.md.

**Known Issues**

* Vagrant doesn't work correctly (#9)
* Vagrant test VMs for Ubuntu don't seem to mount /vagrant (probably an issue
  with generic boxes).
* Puppet deb files aren't available for all the dists.

## Release 1.0.0

The "probably should not be 1.0.0" release.

**Features**
* Allow creation and deletion of users.
* Implement completish tests.
* Vagrant environment for all supported OSes.

**Bugfixes**
* Remove useless code in previous tests.
* Set `trust=strict` to suppress unwanted error messages on startup.
* Don't introduce a bug that makes the creation check fail.

**Known Issues**
* Vagrant test VMs for Ubuntu don't seem to mount /vagrant (probably an issue
  with generic boxes).
* Puppet deb files aren't available for all the dists.

## Release 0.3.2

**Bugfixes**
* Style issues with spec.

## Release 0.3.1

**Features**
* Add basic testing.

**Known issues**
* Forgot to increase version number.

## Release 0.3.0

**Features**
* Fully implement user certificate generation.
* A Vagrant testing environment has been included.

**Bugfixes**
* Parsing issues with certificate struct. (closes: #4)
* Generation of malformed configuration files. (closes: #5)
* An issue with scoping in templates.
* Accidentally assigning `crl` to `client` instead of `server` in the
  certificate hash.

## Release 0.2.1

**Features**
* Generate user certificates.

**Bugfixes**
n/a

**Known Issues**
I'll tell you after testing it.

## Release 0.2.0

**Features**
* Generate user/group objects

**Bugfixes**
* Ensure the `orgs` dir exists so taskd won't fail.
* Copy certificates to data directory instead of default location.
* Made `cn` optional for certificate (uses FQDN).
* Some documentation.

**Known Issues**
* Certificates for users aren't yet generated.
* No unit tests.
* Still not king.

## Release 0.1.0

**Features**
* Basic taskserver installation
* Generate self-signed certificates

**Bugfixes**

**Known Issues**
None, since it hasn't even been tested. ;)
