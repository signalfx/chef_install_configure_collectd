#
# Cookbook Name:: chef_install_configure_collectd 
# Recipe:: config_cassandra
#
# Function:
# This recipe can configure the cassandra plugin for collectd
#
# Copyright (c) 2015 SignalFx, Inc, All Rights Reserved.

require File.expand_path("../helper.rb", __FILE__)

include_recipe 'chef_install_configure_collectd::config-jmx'

template "#{node['collectd_managed_conf_folder']}/20-cassandra.conf" do
  source '20-cassandra.conf.erb'
  variables({
    :hostname => node['fqdn'],
    :serviceurl => node['cassandra']['serviceurl']
  })
  notifies :restart, 'service[collectd]'
end

start_collectd
