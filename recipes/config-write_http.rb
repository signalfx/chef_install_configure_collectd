%w[ /etc/collectd.d /etc/collectd.d/managed_config ].each do |path|
  directory path do
    mode '0700'
    action :create
  end
end

uri_items = Hash.new()

if node["write_http"]["set_aws_instanceId"] == true 
  begin
    Timeout::timeout(10) do
      AWSInstanceID = open('http://169.254.169.254/latest/meta-data/instance-id'){ |io| data = io.read }
      puts uri_items["sfxdim_InstanceId"] = AWSInstanceID
  end
  rescue Timeout::Error
     puts "ERROR: Unable to get AWS instance ID, Timeout due to reading"
  end
end

parameters_object = node["write_http"]["Ingest_host_parameters"] 
if parameters_object != nil
  parameters_object.each do |k,v|
    puts uri_items["sfxdim_" + k] = v
  end
end

template "/etc/collectd.d/managed_config/10-aggregation-cpu.conf" do
  source "10-aggregation-cpu.conf.erb"
end

ingesturl = node["write_http"]["Ingest_host"]
if uri_items.length != 0
  ingesturl = ingesturl + "?" + URI.encode_www_form(uri_items)
end


template "/etc/collectd.d/managed_config/10-write_http-plugin.conf" do
  source "10-write_http-plugin.conf.erb"
  variables({
    :INGEST_HOST => ingesturl, 
    :API_TOKEN => node["write_http"]["API_TOKEN"]
  })
end

service 'collectd' do
  action [:enable, :stop, :start]
end
