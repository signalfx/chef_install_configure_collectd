#!/usr/bin/env bats

getConfigureFilePath(){
  if [[ "$(cat /etc/issue)" == *"Ubuntu"* ]]; then
     echo "/etc/collectd/collectd.conf"
  else
     echo "/etc/collectd.conf"
  fi
}

getConfigureFileFolder(){
  echo "/etc/collectd.d/managed_config"
}


@test "Collectd install test" {
  path="$(which collectd)"
  [ "$path" != "" ]
}

@test "Collectd version test" {
  version="$(collectd -h | grep collectd\ 5.5.0.sfx)"
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

@test "Configure cpu plugin confige file test" {
  [ -f "/etc/collectd.d/managed_config/10-aggregation-cpu.conf" ]
}
