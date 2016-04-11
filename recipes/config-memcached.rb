#
# Cookbook Name:: chef_install_configure_collectd 
# Recipe:: config_memcached
#
# Function:
# This recipe can configure the postgesql plugin for collectd
#
# Copyright (c) 2015 SignalFx, Inc, All Rights Reserved.

require File.expand_path("../helper.rb", __FILE__)

include_recipe 'chef_install_configure_collectd::default'

template "#{node['collectd_managed_conf_folder']}/10-memcached.conf" do
  source '10-memcached.conf.erb'
  variables({
    :hostname => node['memcached']['hostname'],
    :port => node['memcached']['port']
  })
  notifies :restart, 'service[collectd]'
end

start_collectd
