#
# Cookbook Name:: collectd_install_configure
# Recipe:: config-collectd 
#
# Function:
# This recipe can configure the basic Information for collectd
#
# Copyright (c) 2015 SignalFx, Inc, All Rights Reserved.

require File.expand_path("../helper.rb", __FILE__)

#
# This function is to get the template file. For centos7 we need use the collectd-centos7.conf.erb
# The other os, we need collectd.conf.erb
#
def get_collectd_conf_template
  if node['platform'] == 'centos' && node['platform_version'].to_i >= 7
    return 'collectd-centos7.conf.erb'
  end
  return 'collectd.conf.erb'
end

template = get_collectd_conf_template

template "#{node['collectd_conf_file']}" do
  source template
  notifies :restart, 'service[collectd]'
end

createDirectory("#{node['collectd_managed_conf_folder']}", '0700')
createDirectory("#{node['collectd_filtering_conf_folder']}", '0700')

template "#{node['collectd_managed_conf_folder']}/10-aggregation-cpu.conf" do
  source '10-aggregation-cpu.conf.erb'
  notifies :restart, 'service[collectd]'
end

template "#{node['collectd_filtering_conf_folder']}/filtering.conf" do
  source 'filtering.conf.erb'
  notifies :restart, 'service[collectd]'
end
