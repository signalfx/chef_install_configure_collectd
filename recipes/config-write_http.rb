%w[ /etc/collectd.d /etc/collectd.d/managed_config ].each do |path|
  directory path do
    mode '0700'
    action :create
  end
end

parameters_array = Array.new
parameters_object = node["write_http"]["Ingest_host_parameters"] 
if parameters_object != nil
  parameters_object.each do |k,v|
    temp = k + "=" + v
    parameters_array << temp
  end
end

template "/etc/collectd.d/managed_config/10-aggregation-cpu.conf" do
  source "10-aggregation-cpu.conf.erb"
end

ingesturl = node["write_http"]["Ingest_host"]
if parameters_array.length != 0
  ingesturl = ingesturl + "?" + parameters_array.join("&")
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
