name 'chef_install_configure_collectd'
maintainer 'SignalFx, Inc.'
maintainer_email 'support+chef@signalfx.com'
license 'Copyright SignalFx, Inc. All rights reserved'
description 'This cookbook provides a set of recipes to install and cofigure the collectd'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version '0.1.2'

supports "centos"
supports "amazon"
supports "ubuntu"

depends 'apt', '> 2.8'
depends 'python', '> 1.4'
