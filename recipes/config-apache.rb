#
# Cookbook Name:: chef_install_configure_collectd 
# Recipe:: config_apache 
#
# Function:
# This recipe can configure the apache plugin for collectd
#
# Copyright (c) 2015 SignalFx, Inc, All Rights Reserved.

require File.expand_path("../helper.rb", __FILE__)

include_recipe 'chef_install_configure_collectd::default'
install_package_on_redhat 'collectd-apache'

template "#{node['collectd_conf_folder']}/10-apache.conf" do
  source '10-apache.conf.erb'
  variables({
    :instanceName => node['apache']['instanceName'],
    :url => node['apache']['url']
  })
  notifies :restart, 'service[collectd]'
end

start_collectd
