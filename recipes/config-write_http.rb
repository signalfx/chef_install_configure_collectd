# Recipe:: config-collectd
#
# Function:
# This recipe can configure the write_http plugin to send metrics to signalfx
#
# Copyright (c) 2015 SignalFx, Inc, All Rights Reserved.

#
# This function is to get collectd configure file path. For centos and amazon,
# the path is on /etc/collectd.conf. For ubuntu, the path is on /etc/collectd/collectd.conf.
#
require File.expand_path("../helper.rb", __FILE__)
#require_relative './helper.rb'

install_package_on_redhat 'collectd-write_http'

ingesturl = getHttpUri

template "#{node['collectd_managed_conf_folder']}/10-write_http-plugin.conf" do
  source '10-write_http-plugin.conf.erb'
  variables({
    :INGEST_HOST => ingesturl, 
    :API_TOKEN => node['write_http']['API_TOKEN']
  })
  notifies :restart, 'service[collectd]'
end

start_collectd
