#
# Cookbook Name:: collectd_install_configure
# Recipe:: default
#
# Function:
# This recipe can install SignalFx collectd for amazon Linux, centos and ubuntu.
#
# Copyright (c) 2015 SignalFx, Inc, All Rights Reserved.

#
# This function is to install one rpm repo
# - Download repo rpm
# - install repo rpm
#
require File.expand_path("../helper.rb", __FILE__)

#require_relative './helper.rb'

def install_single_rpm_repo(rpm_package)
  download_file("#{SignalFx_Repo_Link}/#{rpm_package}",
                "/tmp/#{rpm_package}")
  install_rpm_package(rpm_package, "/tmp/#{rpm_package}")
end

#
# This function is to install SignalFx rpm repos for redhat_based linux.
# All of rpmpackage names are writen in the
# chef_install_configure_collectd/attributes/SignalFx_rpm_repo.rb
#
# If we do not support your os, we will raise a exception.
#
def install_repo_rpms(os, version)
  unless node['SignalFx_rpm_repo'][os].include? version
    raise ("Do not support your system #{node['platform']}_#{node['platform_version']}") 
  end
  
  install_single_rpm_repo(node['SignalFx_rpm_repo'][os][version]['SignalFx-repo'])
  install_single_rpm_repo(node['SignalFx_rpm_repo'][os][version]['SignalFx-Plugin-repo'])
end

#
# This function is to install collectd for centos and amazon OS.
#
# For redhat-base OS, signalfx has a collectd rpm package
# and bunch of plugin rpm packages.
#
# os: Operation System name. We only support the centos and amazon.
# version: Version Number of operation system
#
#  The process is :
#  - install the repo rpm
#  - install the collectd and collectd-disk plugin
#

def install_in_redhat(os, version)
  install_repo_rpms(os, version)
  install_package 'collectd'
  install_package 'collectd-disk'
end

#
# This function is to update the ubuntu. It depends on the apt cookbook.
# For ubuntu, signalfx has a collectd package which contains all plugins.
#
# The process is :
# - add the ppa info
# - install the collectd package
#

def install_in_ubuntu
  install_ppa(node['SignalFx_ppa']['collectd']['name'],
              node['SignalFx_ppa']['collectd']['uri'])
  install_ppa(node['SignalFx_ppa']['collectd_plugin']['name'],
              node['SignalFx_ppa']['collectd_plugin']['uri'])
  ubuntu_update
  install_package 'collectd'
end

#
# This function install collectd packages on the Debian OSs
#
# The process is :
# - add the SignalFx PPA
# - install the collectd package
#

def install_in_debian
  package 'apt-transport-https'
  package 'dirmngr' if get_debian_os_name == 'stretch'
  collectd_ppa_source = node['SignalFx_debian_ppa'][get_debian_os_name]['collectd']['uri']
  signalfx_collectd_plugin_ppa_source = node['SignalFx_debian_ppa'][get_debian_os_name]['collectd_plugin']['uri']
  signalfx_keyid = node['SignalFx_debian_ppa']['keyid']
  execute 'add SignalFx PPA' do
    command "apt-key adv --keyserver keyserver.ubuntu.com --recv-keys #{signalfx_keyid} && 
             echo #{collectd_ppa_source} > /etc/apt/sources.list.d/signalfx_collectd.list && 
             echo #{signalfx_collectd_plugin_ppa_source} > /etc/apt/sources.list.d/signalfx_collectd_plugin.list"
    action :run
  end
  ubuntu_update
  install_package 'collectd'
end

#
# This function is to check the operation system and
# the version number and install collectd.
#

SignalFx_Repo_Link = node['SignalFx_rpm_repo']['uri']
case node['platform']
when 'redhat'
  # Get the rhel integer version
  install_in_redhat('rhel', node['platform_version'].to_i.to_s)
when 'centos'
  # Get the centos integer version
  install_in_redhat('centos', node['platform_version'].to_i.to_s)
when 'amazon'
  install_in_redhat('amazon', 'all')
when 'ubuntu'
  install_in_ubuntu
when 'debian'
  install_in_debian
else
  raise ("Do not support your system #{node['platform']}_#{node['platform_version']}")
end
