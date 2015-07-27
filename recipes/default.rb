#
# Cookbook Name:: collectd_install_configure
# Recipe:: default
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

def install_in_redhat( os, version )

  if node["SignalFx_rpm_repo"][os].include? version
    signalfx_package = node["SignalFx_rpm_repo"][os][version]["SignalFx-repo"]
    signalfx_package_link = node["SignalFx_rpm_repo"][os][version]["SignalFx-repo-link"]

    remote_file "/tmp/#{signalfx_package}" do
      source signalfx_package_link
    end

    rpm_package "#{signalfx_package}" do
      source "/tmp/#{signalfx_package}"
      action :install
    end

    package [ 
              "collectd",
              "collectd-disk",
              "collectd-write_http"
            ]

  end

end

def ubuntu_update()
  execute "apt_update" do
    command "apt-get update"
    action :run
  end
end

def install_in_ubuntu()
  ubuntu_update()
  package "software-properties-common"
  package "python-software-properties"
  execute "add-ppa" do
    command "add-apt-repository ppa:signalfx/collectd-release"
    action :run
  end
  ubuntu_update()
  package "collectd"
end


case node[:platform]
  when "centos"
# Get the centos integer version
    install_in_redhat("centos", node["platform_version"].to_i.to_s)
  when "amazon"
    install_in_redhat("amazon", node["platform_version"])
  when "ubuntu"
    install_in_ubuntu()
  else
    puts "We do not support your system"
end
