case node[:platform]
  when "centos", "amazon"
    conf_path = "/etc/collectd.conf"
  when "ubuntu"
    conf_path = "/etc/collectd/collectd.conf"
end

if File.exist?(conf_path)
  ruby_block "Rename old collectd.conf" do
    block do
      newname = conf_path + Time.now.utc.iso8601.gsub('-', '').gsub(':', '')
      ::File.rename(conf_path , newname)
    end
  end
end

hostname = open('http://169.254.169.254/latest/meta-data/instance-id'){ |io| data = io.read }

template conf_path do
  source "collectd.conf.erb"
  variables({
    :HOST_NAME => hostname
  })
end

