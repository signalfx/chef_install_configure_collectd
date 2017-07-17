#
# Cookbook Name:: chef_install_configure_collectd 
# Recipe:: config-docker
#
# Function:
# This recipe can configure the docker plugin for collectd
#
# Copyright (c) 2015 SignalFx, Inc, All Rights Reserved.

require File.expand_path("../helper.rb", __FILE__)

include_recipe 'chef_install_configure_collectd::default'
epel_release_for_redhat
install_python_pip

pip_python_module("py-dateutil", "2.2")
pip_python_module("docker-py", "1.10.3")
pip_python_module("jsonpath_rw", "1.4.0")

directory node['docker']['python_folder'] do
  action :create
  recursive true
end

template "#{node['docker']['python_folder']}/dockerplugin.py" do
  source 'dockerplugin.py.erb'
  notifies :restart, 'service[collectd]'
end

directory node['docker']['dbfile_folder'] do
  action :create
  recursive true
end

template "#{node['docker']['dbfile_folder']}/dockerplugin.db" do
  source 'dockerplugin.db.erb'
  notifies :restart, 'service[collectd]'
end

template "#{node['collectd_managed_conf_folder']}/10-docker.conf" do
  source '10-docker.conf.erb'
  variables({
    :dbfile_path => "#{node['docker']['dbfile_folder']}/dockerplugin.db",
    :python_folder => node['docker']['python_folder'],
    :base_url => node['docker']['base_url']
  })
  notifies :restart, 'service[collectd]'
end

start_collectd
