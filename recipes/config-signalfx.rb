#
# Cookbook Name:: signalfx_plugin.rb
# Recipe:: signalfx_plugin
#
# Function:
# This recipe can configure the basic Information for collectd
#
# Copyright (c) 2015 SignalFx, Inc, All Rights Reserved.

#
# This recipe is to install and config signalfx_plugin
#
#require_relative './helper.rb'
require File.expand_path("../helper.rb", __FILE__)

install_package 'signalfx-collectd-plugin'

ingesturl = getHttpUri

template "#{node['collectd_managed_conf_folder']}/10-signalfx.conf" do
  source '10-signalfx.conf.erb'
  variables({
    :INGEST_HOST => ingesturl,
    :API_TOKEN => node['write_http']['API_TOKEN'],
    :ENABLE_STATSD => node['SignalFx']['collectd']['enable_statsd'],
    :STATSD_PORT => node['SignalFx']['collectd']['statsd_port']
  })
  notifies :restart, 'service[collectd]'
end

start_collectd
include_recipe 'chef_install_configure_collectd::config-write_http'
