# chef_install_configure_collectd #
[![Build Status](https://travis-ci.org/signalfx/chef_install_configure_collectd.svg?branch=master)](https://travis-ci.org/signalfx/chef_install_configure_collectd)

# Description #

Use this cookbook to install and configure collectd to send data to SignalFx. It can perform the following tasks:

- Install [SignalFx's build of collectd](https://github.com/signalfx/collectd), an open-source monitoring daemon.
- Install and configure [SignalFx's metadata plugin for collectd](https://github.com/signalfx/signalfx-collectd-plugin)
- Configure collectd's write_http plugin to send data to SignalFx
- Install and configure collectd plugins for data collection from the following software:
   - Apache webserver
   - Cassandra
   - Docker
   - ElasticSearch
   - Iostat
   - Kafka
   - Memcached
   - Mesos
   - MongoDB
   - MySQL
   - Nginx
   - Postgres
   - Redis
   - Varnish
   - Vmstat
   - Zookeeper

# System Requirements #

This cookbook has been tested on the following operating systems:

CentOS 6, 7;
Amazon Linux 1503, 1509, 1603, 1609;
RHEL 6, 7;
Ubuntu 1204, 1404, 1504, 1604;
Debian GNU/Linux 7, 8, 9;

# Usage #

* Use the default recipe to install collectd, configure plugins, and configure collectd to send metrics to SignalFx.
* Use the individual collectd plugin recipes to install individual collectd plugins.

## 1. Install all cookbook dependencies and upload to the Chef Server

## 2. Install on your local machine ##

```knife cookbook site install chef_install_configure_collectd --skip-dependencies```

This command installs the `chef_install_configure_collectd` cookbook to your local machine.

## 3. Supply your SignalFx API token.

In order to send data to SignalFx, you must provide a value for your SignalFx API token in `attributes/default.rb` as follows, replacing `YOUR_SIGNALFX_API_TOKEN` with the API token for your SignalFx organization:

```
default['write_http']['API_TOKEN'] = 'YOUR_SIGNALFX_API_TOKEN'
```

## 4. (Optional) Supply configuration for collectd and plugins.

This cookbook includes default configuration for collectd in `attributes/default.rb`, and for plugins in individually-named files in the attributes directory. Before using this cookbook to install collectd plugins, supply configuration values for each plugin you will install in that plugin's attributes file.

See [Attributes](#attributes) below for a detailed list of all available attributes.

## 5. Upload to Chef server ##
```knife cookbook upload chef_install_configure_collectd```

This command uploads the `chef_install_configure_collectd` cookbook to the Chef server.

## 6. Apply to Chef clients ##

### Using bootstrap ###

After supplying attributes, use `knife bootstrap` to apply the recipes to Chef clients. For example, the following command applies the `chef_install_configure_collectd` recipe and installs the Apache collectd plugin:

```knife bootstrap $ip --ssh-user $username --node-name $nodename --run-list 'recipe[chef_install_configure_collectd], recipe[chef_install_configure_collectd::config-apache]'```

# Attributes #

## Collectd Attributes ##

* attributes/SignalFx_repo.rb - Contains the names and locations of SignalFx collectd packages.
* attributes/default.rb - Basic attributes for SignalFx configuration.
   - default['write_http']['AWS_integration'] : 'true' if you want to sync AWS metadata to SignalFx, otherwise 'false' (default: 'true')
   - default['write_http']['Ingest_host'] : URL of the SignalFx ingest service.
   - default['write_http']['API_TOKEN'] : Your SignalFx API token.
   - default['collectd_version'] : The version of SignalFx collectd to install. (default: 'latest')
   - default['SignalFx']['collectd']['interval'] : Interval in seconds to collectd data (default: 10 seconds)
   - default['SignalFx']['collectd']['timeout'] : Collectd Timeout (default: 2 iterations)
   - default['SignalFx']['collectd']['FQDNLookup'] : Collectd Directive to lookup FQDN when setting hostname (default: 'true')
   - default['SignalFx']['collectd']['logfile']['LogLevel'] : Collectd Logging Level (default: 'info')
   - default['SignalFx']['collectd']['logfile']['File'] : Collectd Log file (default: '/var/log/collectd.log')
   - default['SignalFx']['collectd']['logfile']['PrintSeverity'] : Collectd directive to log severity level (default: 'false')

* To add a dimension to every datapoint sent to SignalFx, add an entry to default.rb as follows:

```ruby
   default["write_http"]["Ingest_host_parameters"]["YOUR_KEY1"] = "YOUR_VALUE1"
   default["write_http"]["Ingest_host_parameters"]["YOUR_KEY2"] = "YOUR_VALUE2"
```

* To enable the built-in statsd listener, set the following:
   - default['SignalFx']['collectd']['enable_statsd'] = true
   - default['SignalFx']['collectd']['statsd_port'] : The port on which to listen (default 8125)

## Plugin-specific Attributes ##

### Apache ###
* attributes/apache_plugin.rb
   - default['apache']['instanceName'] : Name of your Apache instance
   - default['apache']['url'] : URL at which to access the output of Apache's mod_status module. (default: 'http://localhost/mod_status?auto')

### Cassandra ###
* attributes/cassandra_plugin.rb
   - default['cassandra']['serviceurl'] : Your Cassandra service URL (default: 'service:jmx:rmi:///jndi/rmi://localhost:7199/jmxrmi')

### Docker ###
* attributes/docker_plugin.rb
   - default['docker']['dbfile_folder'] : The location on disk to store this plugin's DB files. (default: '/usr/share/collectd/docker-collectd-plugin')
   - default['docker']['python_folder'] : The location on disk to store this plugin's Python files. (default: '/usr/share/collectd/docker-collectd-plugin')
   - default['docker']['base_url'] : URL at which to connect to the Docker instance to be monitored. (default : 'unix://var/run/docker.sock')

### Elasticsearch ###
* attributes/elasticsearch_plugin.rb
   - default['elasticsearch']['clustername'] : Name of your ElasticSearch cluster. (default: 'elasticsearch')
   - default['elasticsearch']['indexes'] : Which indexes to monitor. (default: '_all')
   - default['elasticsearch']['python_folder'] : The location on disk of the collectd Python plugin. (default: '/usr/share/collectd/python')

### Iostat ###
* attributes/iostat_plugin.rb
   - default['iostat']['path'] : The location of the iostat executable. (default: '/usr/bin/iostat')
   - default['iostat']['verbose'] : True for verbose logging. (default: 'false')
   - default['iostat']['include'] : Metrics to collect. (default: '["tps", "kB_read/s", "kB_wrtn/s", "kB_read", "kB_wrtn", "rrqm/s", "wrqm/s", "r/s", "w/s", "rsec/s", "rkB/s", "wsec/s", "wkB/s", "avgrq-sz", "avgqu-sz", "await", "r_await", "w_await", "svctm", "%util"]')
   - default['iostat']['python_folder'] : The location on disk of the collectd Python plugin. (default: '/usr/share/collectd/python')

### Kafka ###
* attributes/kafka_plugin.rb
   - default['kafka']['serviceurl'] : Your Kafka service URL (default: 'service:jmx:rmi:///jndi/rmi://localhost:7099/jmxrmi')

### Memcached ###
* attributes/memcached_plugin.rb
   - default['memcached']['hostname'] : Memcached hostname
   - default['memcached']['port'] : Memcached port

### Mesos ###
* attributes/mesos_master_plugin.rb
   - default['mesos']['master']['python_folder'] The location on disk to store this plugin's Python files. (default: '/usr/share/collectd/mesos-collectd-plugin')
   - default['mesos']['master']['cluster'] = Cluster Name
   - default['mesos']['master']['instance'] = Instance Name
   - default['mesos']['master']['binary_path'] = Path to the directory containing mesos executables (default: '/usr/bin')
   - default['mesos']['master']['hostname'] = Mesos Master Hostname (default: 'localhost')
   - default['mesos']['master']['port'] = Mesos Master Port (default: 5050)

* attributes/mesos_slave_plugin.rb
   - default['mesos']['slave']['python_folder'] The location on disk to store this plugin's Python files. (default: '/usr/share/collectd/mesos-collectd-plugin')
   - default['mesos']['slave']['cluster'] = Cluster Name
   - default['mesos']['slave']['instance'] = Instance Name
   - default['mesos']['slave']['binary_path'] = Path to the directory containing mesos executables (default: '/usr/bin')
   - default['mesos']['slave']['hostname'] = Mesos Slave Hostname (default: 'localhost')
   - default['mesos']['slave']['port'] = Mesos Slave Port (default: 5050)

### MySQL ###
* attributes/mysql_plugin.rb
   - default['mysql']['database']... : 'database' is the database name that will be reported to SignalFx.
   - default['mysql']['database']['Host'] : IP address of MySQL database
   - default['mysql']['database']['Socket'] : Socket of MySQL database
   - default['mysql']['database']['User'] : Database username
   - default['mysql']['database']['Password'] : Database password
   - default['mysql']['database']['Database'] : Database name

### Nginx ###
* attributes/nginx_plugin.rb
   - default['nginx']['url'] : URL at which to access Nginx status. (default: 'http://localhost:80/nginx_status')

### PostgreSQL ###
* attributes/postgresql_plugin.rb
   - default['postgresql']['hostname'] : Hostname or IP address of your PostgreSQL database.
   - default['postgresql']['user'] : Database username
   - default['postgresql']['password'] : Database password

### Redis ###
* attributes/redis_master_plugin.rb
   - default['redis_master']['hostname'] : Hostname or IP address of your Redis master instance.
   - default['redis_master']['port'] : Port on which your Redis master runs.
   - default['redis_master']['python_folder'] : The location on disk of the collectd Python plugin. (default: '/usr/share/collectd/python')

* attributes/redis_slave_plugin.rb
   - default['redis_slave']['hostname'] : Hostname or IP address of your Redis slave instance.
   - default['redis_slave']['port'] : Port on which your Redis slave runs.
   - default['redis_slave']['python_folder'] : The location on disk of the collectd Python plugin. (default: '/usr/share/collectd/python')

### Vmstat ###
* attributes/vmstat_plugin.rb
   - default['vmstat']['path'] : The location of the vmstat executable. (default: '/usr/bin/vmstat')
   - default['vmstat']['verbose'] : True for verbose logging. (default: 'false')
   - default['vmstat']['include'] : Metrics to collect. (default: '["r", "b", "swpd", "free", "buff", "cache", "inact", "active", "si", "so", "bi", "bo", "in", "cs", "us", "sy", "id", "wa", "st"]')
   - default['vmstat']['python_folder'] : The location on disk of the collectd Python plugin. (default: '/usr/share/collectd/python')

### Zookeeper ###
* attributes/zookeeper_plugin.rb
   - default['zookeeper']['hostname'] = Hostname or IP address of your Zookeeper instance.
   - default['zookeeper']['port'] : Port on which your Zookeeper instance runs.
   - default['zookeeper']['python_folder'] : The location on disk of the collectd Python plugin. (default: '/usr/share/collectd/python')

# License & Author #

Author:: SignalFx Inc (<support+chef@signalfx.com>)

Copyright::2015, SignalFx, Inc.
