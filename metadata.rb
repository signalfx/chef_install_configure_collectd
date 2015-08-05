name 'chef_install_configure_collectd'
maintainer 'SignalFx, Inc.'
maintainer_email 'support+chef@signalfx.com'
license 'Copyright SignalFx, Inc. All rights reserved'
description 'This cookbook provides a set of recipes to install and cofigure the collectd'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version '0.1.0'

supports "centos"
supports "amazon"
supports "ubuntu"

recipe "chef_install_configure_collectd::default",
  "Install the lastest version collectd of SignalFx, Inc"

recipe "chef_install_configure_collectd::config-collectd",
  "Configure the collectd write the collectd.conf file"

recipe "chef_install_configure_collectd::config-write_http",
  "Configure the write_http plugin of collectd"
