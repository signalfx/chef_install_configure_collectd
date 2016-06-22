#
# Cookbook Name:: chef_install_configure_collectd 
# Recipe:: config-mesos-slave
#
# Function:
# This recipe can configure the mesos slave plugin for collectd
#
# Copyright (c) 2015 SignalFx, Inc, All Rights Reserved.

require File.expand_path("../helper.rb", __FILE__)

include_recipe 'chef_install_configure_collectd::default'

directory node['mesos']['slave']['python_folder'] do
  action :create
  recursive true
end

template "#{node['mesos']['slave']['python_folder']}/mesos_collectd.py" do
  source 'mesos_collectd.py.erb'
  notifies :restart, 'service[collectd]'
end

template "#{node['mesos']['slave']['python_folder']}/mesos-slave.py" do
  source 'mesos-slave.py.erb'
  notifies :restart, 'service[collectd]'
end

template "#{node['collectd_managed_conf_folder']}/10-mesos-slave.conf" do
  source '10-mesos-slave.conf.erb'
  variables({
    :python_folder => node['mesos']['slave']['python_folder'],
    :cluster => node['mesos']['slave']['cluster'],
    :instance => node['mesos']['slave']['instance'],
    :binary_path => node['mesos']['slave']['binary_path'],
    :hostname => node['mesos']['slave']['hostname'],
    :port => node['mesos']['slave']['port']
  })
  notifies :restart, 'service[collectd]'
end

start_collectd
