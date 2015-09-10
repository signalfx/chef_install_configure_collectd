case node[:platform]
  when "centos", "amazon"
    conf_path = "/etc/collectd.conf"
  when "ubuntu"
    conf_path = "/etc/collectd/collectd.conf"
end

template = "collectd.conf.erb"
if node[:platform] == "centos" && node["platform_version"].to_i >= 7
  template = "collectd-centos7.conf.erb"
end

template conf_path do
  source template
end
