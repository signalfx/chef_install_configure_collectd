#
# Cookbook Name:: collectd_install_configure
# Recipe:: config-collectd 
#
# Function:
# This recipe can configure the basic Information for collectd
#
# Copyright (c) 2015 SignalFx, Inc, All Rights Reserved.

require File.expand_path("../helper.rb", __FILE__)

def get_collectd_conf_template
  case node['platform_family']
    when 'rhel', 'amazon'
      return 'collectd-rhel.conf.erb'
    when 'debian'
      return 'collectd.conf.erb'
  end
end

template = get_collectd_conf_template

template node['collectd_conf_file'] do
  source template
  notifies :restart, 'service[collectd]'
end

createDirectory(node['collectd_managed_conf_folder'], '0700')
createDirectory(node['collectd_filtering_conf_folder'], '0700')

template "#{node['collectd_managed_conf_folder']}/10-aggregation-cpu.conf" do
  source '10-aggregation-cpu.conf.erb'
  notifies :restart, 'service[collectd]'
end

template "#{node['collectd_filtering_conf_folder']}/filtering.conf" do
  source 'filtering.conf.erb'
  notifies :restart, 'service[collectd]'
end
