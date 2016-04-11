#
# Cookbook Name:: chef_install_configure_collectd 
# Recipe:: config-zookeeper
#
# Function:
# This recipe can configure the zookeeper plugin for collectd
#
# Copyright (c) 2015 SignalFx, Inc, All Rights Reserved.

require File.expand_path("../helper.rb", __FILE__)

include_recipe 'chef_install_configure_collectd::default'

directory node['zookeeper']['python_folder'] do
  action :create
  recursive true
end

template "#{node['zookeeper']['python_folder']}/zk-collectd.py" do
  source 'zk-collectd.py.erb'
  notifies :restart, 'service[collectd]'
end

template "#{node['collectd_managed_conf_folder']}/20-zookeeper.conf" do
  source '20-zookeeper.conf.erb'
  variables({
    :hostname => node['zookeeper']['hostname'],
    :port => node['zookeeper']['port'],
    :python_folder => node['zookeeper']['python_folder']
  })
  notifies :restart, 'service[collectd]'
end

start_collectd
