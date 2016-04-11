#
# Cookbook Name:: chef_install_configure_collectd 
# Recipe:: config-redis-master
#
# Function:
# This recipe can configure the redis master plugin for collectd
#
# Copyright (c) 2015 SignalFx, Inc, All Rights Reserved.

require File.expand_path("../helper.rb", __FILE__)

include_recipe 'chef_install_configure_collectd::default'

directory node['redis_master']['python_folder'] do
  action :create
  recursive true
end

template "#{node['redis_master']['python_folder']}/redis_info.py" do
  source 'redis_info.py.erb'
  notifies :restart, 'service[collectd]'
end

template "#{node['collectd_managed_conf_folder']}/10-redis_master.conf" do
  source '10-redis_master.conf.erb'
  variables({
    :hostname => node['redis_master']['hostname'],
    :port => node['redis_master']['port'],
    :python_folder => node['redis_master']['python_folder']
  })
  notifies :restart, 'service[collectd]'
end

start_collectd
