# Changelog

All notable changes to this project will be documented in this file.

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
