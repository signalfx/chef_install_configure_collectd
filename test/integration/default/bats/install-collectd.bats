#!/usr/bin/env bats

getConfigureFilePath(){
  if [[ "$(cat /etc/issue)" == *"Ubuntu"* ]]; then
     echo "/etc/collectd/collectd.conf"
  else
     echo "/etc/collectd.conf"
  fi
}

getConfigureFileFolder(){
  if [[ "$(cat /etc/issue)" == *"Ubuntu"* ]]; then
     echo "/etc/collectd/managed_config"
  else
     echo "/etc/collectd.d/managed_config"
  fi
}


@test "Collectd install test" {
  path="$(which collectd)"
  [ "$path" != "" ]
}

@test "Collectd version test" {
  version="$(collectd -h | grep -E "collectd\s(.+)\.sfx")"
  [ "$version" != "" ]
}

@test "Configure file exist test" {
  confFilePath=$(getConfigureFilePath)
  [ -f $confFilePath ]
}

@test "Configure file correct test" {
  confFilePath=$(getConfigureFilePath)
  if [[ "$(uname -a)" == *"centos-7"* ]]; then
     cat $confFilePath | grep stdout
  else
     cat $confFilePath | grep /var/log/collectd.log
  fi
}

@test "Configure directory test" {
  confDirectory=$(getConfigureFileFolder)
  [ -d "$confDirectory" ]
}

@test "Configure cpu plugin file test" {
  [ -f "$(getConfigureFileFolder)/10-aggregation-cpu.conf" ]
}
