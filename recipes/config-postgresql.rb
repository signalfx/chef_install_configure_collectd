#
# Cookbook Name:: chef_install_configure_collectd 
# Recipe:: config_postgresql
#
# Function:
# This recipe can configure the postgesql plugin for collectd
#
# Copyright (c) 2015 SignalFx, Inc, All Rights Reserved.

require File.expand_path("../helper.rb", __FILE__)

include_recipe 'chef_install_configure_collectd::default'
install_package_on_redhat 'collectd-postgresql'

template "#{node['collectd_managed_conf_folder']}/10-postgresql.conf" do
  source '10-postgresql.conf.erb'
  variables({
    :hostname => node['postgresql']['hostname'],
    :user => node['postgresql']['user'],
    :password => node['postgresql']['password']
  })
  notifies :restart, 'service[collectd]'
end

start_collectd
