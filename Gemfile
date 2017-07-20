source 'https://rubygems.org'

gem "chef", "~> 12.5.1"
gem "chef-config", "~> 12.5.1"
gem "chef-zero", "~> 4.3.2"
gem "chefspec", "~> 4.4.0"
gem "chef-dk"
gem "cheffish", "~> 1.5.0"
gem "chef-vault", "~> 2.6.1"


gem "berkshelf", "~> 4.0.1"
gem "foodcritic", "~> 11.3.0"
gem "rake"
gem "rubocop", "~> 0.28.0"

group :integration do
  gem "busser-serverspec", "~> 0.5.3"
  gem "kitchen-vagrant", "~> 0.15.0"
  gem "test-kitchen", "~> 1.3.1"
end

group :development do
  gem 'guard',            '~> 2.12'
  gem 'guard-rubocop',    '~> 1.2'
  gem 'guard-foodcritic', '~> 3.0'
  gem 'guard-kitchen',    '~> 0.0'
  gem 'guard-rspec',      '~> 4.5'
  gem 'rb-fsevent', :require => false
  gem 'rb-inotify', :require => false
  gem 'terminal-notifier-guard', :require => false
  gem 'psych', '~> 2.0.12'
  require 'rbconfig'
  if RbConfig::CONFIG['target_os'] =~ /mswin|mingw|cygwin/i
    gem 'wdm', '>= 0.1.0'
    gem 'win32console'
  end
end

gem "kitchen-docker", '2.3.0'
