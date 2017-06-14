name 'chef_install_configure_collectd'
maintainer 'SignalFx, Inc.'
maintainer_email 'support+chef@signalfx.com'
source_url 'https://github.com/signalfx/chef_install_configure_collectd'
issues_url 'https://github.com/signalfx/chef_install_configure_collectd/issues'
license 'Copyright SignalFx, Inc. All rights reserved'
description 'Use this cookbook to install the SignalFx collectd agent and collectd plugins.'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version '0.3.0'

chef_version '~> 12.5'

supports "centos"
supports "amazon"
supports "ubuntu"
supports "debian"

depends 'apt', '< 6.0'
depends 'poise-python', '>= 1.6'
