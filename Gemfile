source 'https://rubygems.org'

gem "chef", "~> 12.5"
gem "chef-config", "~> 12.5"
gem "chef-zero", "~> 5.1"
gem "chefspec", "~> 5.3"
gem "chef-dk"
gem "cheffish", "~> 4.0"
gem "chef-vault", "~> 2.9"


gem "berkshelf", "~> 5.0"
gem "foodcritic", "~> 8.1"
gem "rake"
gem "rubocop", "~> 0.28"

group :integration do
  gem "busser-serverspec", "~> 0.5"
  gem "kitchen-vagrant", "~> 0.15"
  gem "test-kitchen", "~> 1.3"
end

group :development do
  gem 'guard'
  gem 'guard-rubocop'
  gem 'guard-foodcritic'
  gem 'guard-kitchen'
  gem 'guard-rspec'
  gem 'rb-fsevent', :require => false
  gem 'rb-inotify', :require => false
  gem 'terminal-notifier-guard', :require => false
  gem 'psych', '~> 2.0'
  require 'rbconfig'
  if RbConfig::CONFIG['target_os'] =~ /mswin|mingw|cygwin/i
    gem 'wdm', '~> 0.1'
    gem 'win32console'
  end
end

gem "kitchen-docker", '~> 2.3'
