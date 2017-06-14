## v0.3.0
* Refactor to use `poise-python` instead of `python` cookbook
* Adding tests for `Ubuntu 14.04`, `Ubuntu 16.04`
* Bumping `apt` cookbook to `< 6.0`
  * Note that `apt` cookbook `~> 6.0` has breaking changes: https://github.com/chef-cookbooks/apt/blob/master/CHANGELOG.md#600-2017-02-08
* Requiring `chef-client` at `~> 12.5`
  * Even this version of the `chef-client` is getting very old
* Removing testing for Chef client versions from `.travis.yml`: `12.4.1`, `12.4.3`
* Adding testing for Chef client versions to `.travis.yml`: `12`, `12.5`, `12.17`
* Bumping ruby version in `.travis.yml` to match ChefDK: `2.3`
* Making `Gemfile` version pinning less restrictive
* Removing unsupported platforms from `.kitchen.yml`: `centos-6.5`, `centos-5.10`
  * These images are not available from Hashicorp (404).
* Removing `Gemfile.lock`
* Adding files to `.gitignore`
* Fixing integration tests

## v0.2.5
* update elasticsearch plugin v1.3.2

## v0.2.4
* Fix collectd installation on Centos-based boxes by flushing cache before install.

## v0.2.3
* add support for amazon linux 2016.09

## v0.2.2
* update docker recipe with latest plugin

## v0.2.1
* update mongodb recipe with latest plugin and support amazon

## v0.2.0
* add fix for jmx plugin

## v0.1.11
* added iostat plugin
* added vmstat plugin

## v0.1.10
* removed beta support for mongodb
* added support for mongodb 3.2.8
* added supported ubuntu 16.04

## v0.1.4
* add types.db to chef for plugin update collectd.conf to reflect modern day
* fix chef install and configuration
* add foodcritic
* fix amazon install and logging

## v0.1.3:
* Support Debian GNU/Linux 7, 8
* Add ChefUniqueId as a dimension

## v0.1.1:

* Fix the bug about more bak file of collectd.conf file

## v0.1.0:

* Initial release.
* Implement the basic 3 recipes to install collectd:
- default recipe to install collectd-collectd
- configure recipe to configure collectd
- write-http recipe to configure the write-http plugin of collectd to send metrics to signalfx
