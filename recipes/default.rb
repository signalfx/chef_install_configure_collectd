def get_collectd_conf_folder
  case node['platform']
    when 'centos', 'amazon'
      return '/etc/collectd.d'
    when 'ubuntu', 'debian'
      return '/etc/collectd'
  end
end

def get_collectd_conf_file
  case node['platform']
    when 'centos', 'amazon'
      return '/etc/collectd.conf'
    when 'ubuntu', 'debian'
      return '/etc/collectd/collectd.conf'
  end
end

node.default['collectd_conf_file'] = get_collectd_conf_file
node.default['collectd_conf_folder'] = get_collectd_conf_folder
node.default['collectd_managed_conf_folder'] = "#{node['collectd_conf_folder']}/managed_config"
node.default['collectd_filtering_conf_folder'] = "#{node['collectd_conf_folder']}/filtering_config"

include_recipe 'chef_install_configure_collectd::install-collectd'
include_recipe 'chef_install_configure_collectd::config-collectd'
include_recipe 'chef_install_configure_collectd::config-signalfx'

