#
# Cookbook Name:: chef_install_configure_collectd 
# Recipe:: config_kafka
#
# Function:
# This recipe can configure the kafka plugin for collectd
#
# Copyright (c) 2015 SignalFx, Inc, All Rights Reserved.

require File.expand_path("../helper.rb", __FILE__)

include_recipe 'chef_install_configure_collectd::config-jmx'

template "#{node['collectd_managed_conf_folder']}/20-kafka_82.conf" do
  source '20-kafka_82.conf.erb'
  variables({
    :hostname => node['fqdn'],
    :serviceurl => node['kafka']['serviceurl']
  })
  notifies :restart, 'service[collectd]'
end

start_collectd
