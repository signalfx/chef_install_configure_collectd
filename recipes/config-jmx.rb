#
# Cookbook Name:: chef_install_configure_collectd 
# Recipe:: config_jmx
#
# Function:
# This recipe can configure the jmx plugin for collectd
#
# Copyright (c) 2015 SignalFx, Inc, All Rights Reserved.

require File.expand_path("../helper.rb", __FILE__)

include_recipe 'chef_install_configure_collectd::default'
install_package_on_redhat 'collectd-java'

template "#{node['collectd_managed_conf_folder']}/10-jmx.conf" do
  source '10-jmx.conf.erb'
  notifies :restart, 'service[collectd]'
end

template "#{node['collectd_conf_folder']}/signalfx_types_db" do
  source 'signalfx_types_db.erb'
  notifies :restart, 'service[collectd]'
end

start_collectd
