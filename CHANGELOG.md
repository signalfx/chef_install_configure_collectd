## v0.3.4
* Adding support for Debian 9 (Stretch)

## v0.3.3
* Adding support for Amazon Linux 2017.03 and all future versions

## v0.3.1/0.3.2
* Fixing license information, no code changes

## v0.3.0
* Support for RHEL 6/7
* Switching from deprecated `python` cookbook to `poise-python`
* Adding more flexible config options for the elasticsearch plugin
* Adding more flexible config options for the protocol plugin

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
