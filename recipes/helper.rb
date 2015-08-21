# down lood remote file

def download_file(remote_link, local_location)
  remote_file local_location do
    source remote_link
  end
end

# install rpms package

def install_rpm_package(name, location)
  rpm_package name do
    source location
    action :install
  end
end

# install ppa

def install_ppa(ppa_name, ppa_uri)
  apt_repository ppa_name do
    uri ppa_uri
    distribution node['lsb']['codename']
  end
end

# create Directory

def createDirectory( folder_path, folder_mode )
  directory folder_path do
    mode folder_mode
    action :create
    recursive true
  end
end

# get aws instance unique id

def getAWSInfor
  begin
    Timeout::timeout(10) do
      aws_metadata = open('http://169.254.169.254/2014-11-05/dynamic/instance-identity/document'){ |io| data = io.read }
      aws_JSON_Information = JSON.parse(aws_metadata)
      return "#{aws_JSON_Information['instanceId']}_#{aws_JSON_Information['region']}_#{aws_JSON_Information['accountId']}"
  end
  rescue
    Chef::Log.warn('Unable to get AWS instance ID, Timeout due to reading') 
    return ''
  end
end

# get http uri

def getHttpUri
  uri_items = Hash.new
  aws_infor = getAWSInfor
  if aws_infor != ''
    puts uri_items['sfxdim_AWSUniqueId'] = getAWSInfor
  end

  parameters_object = node['write_http']['Ingest_host_parameters']
  if parameters_object != nil
    parameters_object.each do |k,v|
      puts uri_items['sfxdim_' + k] = v
    end
  end

  ingesturl = node['write_http']['Ingest_host']
  if uri_items.length != 0
    ingesturl = ingesturl + '?' + URI.encode_www_form(uri_items)
  end
  return ingesturl
end

# ensure collectd start 

def start_collectd
  service 'collectd' do
    supports enable: true, start: true, stop: true
    action [:enable, :start]
  end
end

#install on centos

def install_package_on_redhat( package_name )
  if node['platform'] == 'centos' or node['platform'] == 'amazon'
    install_package package_name
  end
end

def install_package(package_name)
  if node.include? 'collectd_version' and node['collectd_version'] != 'latest'
    package package_name do
      version node['collectd_version']
      action :install
    end
  else
    package package_name
  end  
end

def ubuntu_update
  execute 'apt_update' do
    command 'apt-get update'
    action :run
  end
end

def install_python_pip
  if node['platform'] == 'centos' or node['platform'] == 'amazon'
    package ['python-pip']
  else
    package ['python-setuptools', 'python-dev', 'build-essential']
    execute 'apt_update' do
      command 'easy_install pip'
      action :run
    end
  end
end
