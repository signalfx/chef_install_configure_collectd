#
# Cookbook Name:: chef_install_configure_collectd 
# Recipe:: config-mesos-master
#
# Function:
# This recipe can configure the mesos master plugin for collectd
#
# Copyright (c) 2015 SignalFx, Inc, All Rights Reserved.

require File.expand_path("../helper.rb", __FILE__)

include_recipe 'chef_install_configure_collectd::default'

directory node['mesos']['master']['python_folder'] do
  action :create
  recursive true
end

template "#{node['mesos']['master']['python_folder']}/mesos_collectd.py" do
  source 'mesos_collectd.py.erb'
  notifies :restart, 'service[collectd]'
end

template "#{node['mesos']['master']['python_folder']}/mesos-master.py" do
  source 'mesos-master.py.erb'
  notifies :restart, 'service[collectd]'
end

template "#{node['collectd_managed_conf_folder']}/10-mesos-master.conf" do
  source '10-mesos-master.conf.erb'
  variables({
    :python_folder => node['mesos']['master']['python_folder'],
    :cluster => node['mesos']['master']['cluster'],
    :instance => node['mesos']['master']['instance'],
    :binary_path => node['mesos']['master']['binary_path'],
    :hostname => node['mesos']['master']['hostname'],
    :port => node['mesos']['master']['port']
  })
  notifies :restart, 'service[collectd]'
end

start_collectd
