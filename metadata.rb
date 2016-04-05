name 'chef_install_configure_collectd'
maintainer 'SignalFx, Inc.'
maintainer_email 'support+chef@signalfx.com'
source_url 'https://github.com/signalfx/chef_install_configure_collectd'
issues_url 'https://github.com/signalfx/chef_install_configure_collectd/issues'
license 'Copyright SignalFx, Inc. All rights reserved'
description 'This cookbook provides a set of recipes to install and cofigure the collectd'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version '0.1.3'

supports "centos"
supports "amazon"
supports "ubuntu"
supports "debian"

depends 'apt', '> 2.8'
depends 'python', '> 1.4'
