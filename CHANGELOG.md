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
