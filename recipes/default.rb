#
# The default recipes are install collectd, config-collectd, config-write_http
#
node.default['collectd_conf_folder'] = '/etc/collectd.d/managed_config'
node.default['collectd_conf_parent_folder'] = '/etc/collectd.d'

include_recipe 'chef_install_configure_collectd::install-collectd'
include_recipe 'chef_install_configure_collectd::config-collectd'
include_recipe 'chef_install_configure_collectd::config-signalfx'
