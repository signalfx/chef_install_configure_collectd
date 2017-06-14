require 'chefspec'

describe 'chef_install_configure_collectd::default' do
  context 'Ubuntu_12.04' do
    let(:chef_run) { ChefSpec::SoloRunner.new(platform: 'ubuntu', version: '12.04').converge(described_recipe) }

    it 'should include recipes by default' do
      expect(chef_run).to include_recipe 'chef_install_configure_collectd::install-collectd'
      expect(chef_run).to include_recipe 'chef_install_configure_collectd::config-collectd'
    end
  end

  context 'Ubuntu_14.04' do
    let(:chef_run) { ChefSpec::SoloRunner.new(platform: 'ubuntu', version: '14.04').converge(described_recipe) }

    it 'should include recipes by default' do
      expect(chef_run).to include_recipe 'chef_install_configure_collectd::install-collectd'
      expect(chef_run).to include_recipe 'chef_install_configure_collectd::config-collectd'
    end
  end

  context 'Ubuntu_16.04' do
    let(:chef_run) { ChefSpec::SoloRunner.new(platform: 'ubuntu', version: '16.04').converge(described_recipe) }

    it 'should include recipes by default' do
      expect(chef_run).to include_recipe 'chef_install_configure_collectd::install-collectd'
      expect(chef_run).to include_recipe 'chef_install_configure_collectd::config-collectd'
    end
  end
end
