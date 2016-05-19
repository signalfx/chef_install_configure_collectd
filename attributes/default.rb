default['write_http']['AWS_integration'] = true
default['write_http']['Ingest_host'] = 'https://ingest.signalfx.com/v1/collectd'
default['write_http']['API_TOKEN'] = ''

default['collectd_version'] = 'latest'

default['SignalFx']['collectd']['interval'] = 10
default['SignalFx']['collectd']['timeout'] = 2
default['SignalFx']['collectd']['FQDNLookup'] = true