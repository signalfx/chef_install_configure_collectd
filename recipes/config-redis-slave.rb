#
# Cookbook Name:: chef_install_configure_collectd 
# Recipe:: config-redis-slave
#
# Function:
# This recipe can configure the redis slave plugin for collectd
#
# Copyright (c) 2015 SignalFx, Inc, All Rights Reserved.

require File.expand_path("../helper.rb", __FILE__)

include_recipe 'chef_install_configure_collectd::default'

directory node['redis_slave']['python_folder'] do
  action :create
  recursive true
end

template "#{node['redis_slave']['python_folder']}/redis_info.py" do
  source 'redis_info.py.erb'
  notifies :restart, 'service[collectd]'
end

template "#{node['collectd_managed_conf_folder']}/10-redis_slave.conf" do
  source '10-redis_slave.conf.erb'
  variables({
    :hostname => node['redis_slave']['hostname'],
    :port => node['redis_slave']['port'],
    :python_folder => node['redis_slave']['python_folder']
  })
  notifies :restart, 'service[collectd]'
end

start_collectd
