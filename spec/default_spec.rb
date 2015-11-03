require 'chefspec'

describe 'chef_install_configure_collectd::default' do
  context 'Ubuntu' do
    let(:chef_run) { ChefSpec::SoloRunner.new(platform: 'ubuntu', version: '12.04').converge(described_recipe) }
    
    it 'should include recipes by default' do
      expect(chef_run).to include_recipe 'chef_install_configure_collectd::install-collectd'
      expect(chef_run).to include_recipe 'chef_install_configure_collectd::config-collectd'
    end
  end
end
