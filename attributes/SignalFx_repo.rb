# Arribute:: SignalFx_rpm_repo
#
# Function:
#   This file includes all signalfx rpms name.
#   The repo rpms contains the repo infomation for redhat-based linux os.
#   - The SignalFx-repo
#   - The SignalFx-Plugin_repo
#   - The repo rpms uri
#   - The ubuntu ppa
#   - The ubuntu ppa link
#
#   Sopport operation system 
#   - centos: 6.*, 7.* 
#   - amazon Linux: 14.09, 15.03, 15.09
#   - ubuntu : 12.04 (precise), 14.04 (trusty), 15.04 (vivid)
#  
# Copyright (c) 2015 SignalFx, Inc, All Rights Reserved.

# repo rpms for centos
default['SignalFx_rpm_repo']['centos']['6']['SignalFx-repo'] =
  'SignalFx-collectd-RPMs-centos-release-latest.noarch.rpm'
default['SignalFx_rpm_repo']['centos']['7']['SignalFx-repo'] =
  'SignalFx-collectd-RPMs-centos-release-latest.noarch.rpm'
default['SignalFx_rpm_repo']['centos']['6']['SignalFx-Plugin-repo'] =
  'SignalFx-collectd_plugin-RPMs-centos-release-latest.noarch.rpm'
default['SignalFx_rpm_repo']['centos']['7']['SignalFx-Plugin-repo'] =
  'SignalFx-collectd_plugin-RPMs-centos-release-latest.noarch.rpm'

# repo rpms for amazon linux
default['SignalFx_rpm_repo']['amazon']['2014.09']['SignalFx-repo'] =
  'SignalFx-collectd-RPMs-AWS_EC2_Linux-release-latest.noarch.rpm'
default['SignalFx_rpm_repo']['amazon']['2015.03']['SignalFx-repo'] =
  'SignalFx-collectd-RPMs-AWS_EC2_Linux-release-latest.noarch.rpm'
default['SignalFx_rpm_repo']['amazon']['2015.09']['SignalFx-repo'] =
  'SignalFx-collectd-RPMs-AWS_EC2_Linux-release-latest.noarch.rpm'
default['SignalFx_rpm_repo']['amazon']['2014.09']['SignalFx-Plugin-repo'] =
  'SignalFx-collectd_plugin-RPMs-AWS_EC2_Linux-release-latest.noarch.rpm'
default['SignalFx_rpm_repo']['amazon']['2015.03']['SignalFx-Plugin-repo'] =
  'SignalFx-collectd_plugin-RPMs-AWS_EC2_Linux-release-latest.noarch.rpm'
default['SignalFx_rpm_repo']['amazon']['2015.09']['SignalFx-Plugin-repo'] =
  'SignalFx-collectd_plugin-RPMs-AWS_EC2_Linux-release-latest.noarch.rpm'

# repo rpms uri
default['SignalFx_rpm_repo']['uri'] = 
  'https://dl.signalfx.com/rpms/SignalFx-rpms/release'

# ppa for ubuntu
default['SignalFx_ppa']['collectd']['name'] =
  'signalfx-ubuntu-collectd-release'
default['SignalFx_ppa']['collectd_plugin']['name'] =
  'signalfx-ubuntu-collectd-plugin-release'

# ppa uri for ubuntu
default['SignalFx_ppa']['collectd']['uri'] =
  'ppa:signalfx/collectd-release'
default['SignalFx_ppa']['collectd_plugin']['uri'] =
  'ppa:signalfx/collectd-plugin-release'

# ppa links for Debian
default['SignalFx_debian_ppa']['wheezy']['collectd']['uri'] = 
  'deb https://dl.signalfx.com/debs/collectd/wheezy/release /'
default['SignalFx_debian_ppa']['wheezy']['collectd_plugin']['uri'] = 
  'deb https://dl.signalfx.com/debs/signalfx-collectd-plugin/wheezy/release /'
default['SignalFx_debian_ppa']['jessie']['collectd']['uri'] = 
  'deb https://dl.signalfx.com/debs/collectd/jessie/release /'
default['SignalFx_debian_ppa']['jessie']['collectd_plugin']['uri'] = 
  'deb https://dl.signalfx.com/debs/signalfx-collectd-plugin/jessie/release /'
default['SignalFx_debian_ppa']['keyid'] = 
  '185894C15AE495F6'
