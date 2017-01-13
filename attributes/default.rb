default['write_http']['AWS_integration'] = true
default['write_http']['Ingest_host'] = 'https://ingest.signalfx.com/v1/collectd'
default['write_http']['API_TOKEN'] = ''

default['collectd_version'] = 'latest'

default['SignalFx']['collectd']['interval'] = 10
default['SignalFx']['collectd']['timeout'] = 2
default['SignalFx']['collectd']['FQDNLookup'] = true

default['SignalFx']['collectd']['logfile']['LogLevel'] = 'info'
default['SignalFx']['collectd']['logfile']['File'] = '/var/log/collectd.log'
default['SignalFx']['collectd']['logfile']['PrintSeverity'] = false

# set this to true to enable the dogstatsd compatible statsd listener
default['SignalFx']['collectd']['enable_statsd'] = false
default['SignalFx']['collectd']['statsd_port'] = 8125

default['SignalFx']['collectd']['protocols']['values'] = [
  "Icmp:InDestUnreachs",
  "Tcp:CurrEstab",
  "Tcp:OutSegs",
  "Tcp:RetransSegs",
  "TcpExt:DelayedACKs",
  "TcpExt:DelayedACKs",
  "/Tcp:.*Opens/",
  "/^TcpExt:.*Octets/",
]
