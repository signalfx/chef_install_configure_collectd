#
# Cookbook Name:: chef_install_configure_collectd 
# Recipe:: config_mysql 
#
# Function:
# This recipe can configure the mysql plugin for collectd
#
# Copyright (c) 2015 SignalFx, Inc, All Rights Reserved.

require File.expand_path("../helper.rb", __FILE__)

include_recipe 'chef_install_configure_collectd::default'
install_package_on_redhat 'collectd-mysql'

template "#{node['collectd_managed_conf_folder']}/10-mysql.conf" do
  source '10-mysql.conf.erb'
  variables({
    :all_database => node[:mysql]
  })
  notifies :restart, 'service[collectd]'
end

start_collectd
