#
# Cookbook Name:: chef_install_configure_collectd 
# Recipe:: config-elasticsearch
#
# Function:
# This recipe can configure the elasticsearch plugin for collectd
#
# Copyright (c) 2015 SignalFx, Inc, All Rights Reserved.

require File.expand_path("../helper.rb", __FILE__)

include_recipe 'chef_install_configure_collectd::default'

directory node['elasticsearch']['python_folder'] do
  action :create
  recursive true
end

template "#{node['elasticsearch']['python_folder']}/elasticsearch_collectd.py" do
  source 'elasticsearch_collectd.py.erb'
  notifies :restart, 'service[collectd]'
end

template "#{node['collectd_managed_conf_folder']}/10-elasticsearch.conf" do
  source '10-elasticsearch.conf.erb'
  variables({
    :clustername => node['elasticsearch']['clustername'],
    :indexes => node['elasticsearch']['indexes'],
    :python_folder => node['elasticsearch']['python_folder'],
    :config => node['elasticsearch']['config'],
  })
  notifies :restart, 'service[collectd]'
end

start_collectd
