#
# Cookbook Name:: chef_install_configure_collectd 
# Recipe:: config_vmstat
#
# Function:
# This recipe can configure the vmstat plugin for collectd
#
# Copyright (c) 2016 SignalFx, Inc, All Rights Reserved.

require File.expand_path("../helper.rb", __FILE__)

include_recipe 'chef_install_configure_collectd::default'
epel_release_for_redhat
package "procps"

directory node['vmstat']['python_folder'] do
  action :create
  recursive true
end

template "#{node['vmstat']['python_folder']}/vmstat_collectd.py" do
  source 'vmstat_collectd.py.erb'
  notifies :restart, 'service[collectd]'
end

template "#{node['collectd_managed_conf_folder']}/10-vmstat.conf" do
  source '10-vmstat.conf.erb'
  variables({
    :path => node['vmstat']['path'],
    :verbose => node['vmstat']['verbose'],
    :python_folder => node['vmstat']['python_folder'],
    :include => node['vmstat']['include']
  })
  notifies :restart, 'service[collectd]'
end

start_collectd
