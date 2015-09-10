# chef_install_configure_collectd #

# DESCRIPTION #

- Install the [collectd of SignalFx](https://github.com/signalfx/collectd/) monitoring daemon.
- Configure the basic plugins of collected.
- Configure the write_http plugin of collectd which can send metrics to SignalFx Inc.

# REQUIREMENTS #

This cookbook has been tested on 
Centos 5, 6, 7;
Amazon Linux 1409, 1503;
Ubuntu 1504, 1410, 1404

# Attributes #

* attributes/default.rb - Basic attributes for collectd write_http plugin.
* attributes/SignalFx_rpm_repo.rb - SignalFx rpms names and links for centos and amazon linux.

# Templates #

* templates/default/collectd.conf.erb - Template to configure the collectd.conf file.
* templates/default/10-write_http-plugin.conf.erb - Template to configure the write_http plugin of collectd.
* templates/default/10-aggregation-cpu.conf.erb - Template to configure the CPU aggregation.

# USAGE #

Three main recipes are provided: 

* chef_install_configure_collectd - Install the SignalFx.rpm and newest release collectd of SignalFx Inc.
* chef_install_configure_collectd::config-collectd - Set up collectd.conf file.
* chef_install_configure_collectd::config-write_http - Configure the write_http plugin for collectd.

## Install collectd of SignalFx Inc. ##

* Run chef_install_configure_collectd::default recipe which can check the operation system and install collectd packages.

## Configure the collectd ##

* Run the chef_install_configure_collectd::config-collectd recipe which can set up collectd.conf file.

## Configure to send the metrics to SignalFx ##
* Run the chef_install_configure_collectd::config-write_http recipe.
* Users can use the default attributes in attributes/default.rb. The collectd will use the default Ingest_host URL to send metrics to SignalFx Inc, but users have to fill your API TOKEN.
* If users want use your own ingest host URL or ingest host parameters, you should rewrite attributes/default.rb defines their attributes. Example:

```ruby
   default["write_http"]["AWS_integration"] = true
   default["write_http"]["Ingest_host"] = "YOUR_INGEST_HOST"
   default["write_http"]["API_TOKEN"] = "YOUR_API_TOKEN"
   default["write_http"]["Ingest_host_parameters"]["YOUR_KEY1"] = "YOUR_VALUE1"
   default["write_http"]["Ingest_host_parameters"]["YOUR_KEY2"] = "YOUR_VALUE2"
```
* The attribute default["write_http"]["AWS_integration"] means if user want to integerate by AWS.
* All of the other attributes are to configure the 10-write_http-plugin.conf file. 
If you use the attributes above, the configuration file (10-write_http-plugin.conf) is like:

```ruby
LoadPlugin write_http
<Plugin "write_http">
  <URL "YOUR_INGEST_HOST&sfxdim_InstanceId=YOUR_AWS_INSTANCE_ID&sfxdim_YOUR_KEY1=YOUR_VALUE1&sfxdim_YOUR_KEY2=YOUR_VALUE2">
    User "auth"
    Password "YOUR_API_TOKEN"
    Format "JSON"
  </URL>
</Plugin>
```

# LICENSE & AUTHOR #

Author:: Wentao Du (<wentao@signalfx.com>)

Copyright::2015, SignalFx, Inc.

