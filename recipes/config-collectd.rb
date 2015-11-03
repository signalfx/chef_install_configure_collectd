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
# This fucntion is to get collectd configure file path. For centos and amazon,
# the path is on /etc/collectd.conf. For ubuntu, the path is on /etc/collectd/collectd.conf.
#
def get_collectd_path
  case node['platform']
    when 'centos', 'amazon'
      return '/etc/collectd.conf'
    when 'ubuntu'
      return '/etc/collectd/collectd.conf'
  end
end

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
path = get_collectd_path

template path do
  source template
  notifies :restart, 'service[collectd]'
end

createDirectory(node['collectd_conf_folder'], '0700')

template "#{node['collectd_conf_folder']}/10-aggregation-cpu.conf" do
  source '10-aggregation-cpu.conf.erb'
  notifies :restart, 'service[collectd]'
end
