#
# Cookbook Name:: chef_install_configure_collectd 
# Recipe:: config_nginx
#
# Function:
# This recipe can configure the nginx plugin for collectd
#
# Copyright (c) 2015 SignalFx, Inc, All Rights Reserved.

require File.expand_path("../helper.rb", __FILE__)

include_recipe 'chef_install_configure_collectd::default'
install_package_on_redhat 'collectd-nginx'

template "#{node['collectd_managed_conf_folder']}/10-nginx.conf" do
  source '10-nginx.conf.erb'
  variables({
    :url => node['nginx']['url']
  })
  notifies :restart, 'service[collectd]'
end

start_collectd
