require 'spec_helper'

describe 'artifactory_pro::default' do
  context 'artifactory is not installed' do
    let(:chef_run) do
      ChefSpec::ServerRunner.new(platform: 'centos', version: '7.1').converge(described_recipe)
    end

    before do
      allow(Chef::Config).to receive(:file_cache_path).and_return('/var/chef/cache')
      stub_command('rpm -ql artifactory').and_return(false)
    end

    it 'includes the `configuration` recipe' do
      expect(chef_run).to include_recipe('artifactory_pro::configuration')
    end
  end

  context 'artifactory is installed' do
    let(:chef_run) do
      ChefSpec::ServerRunner.new(platform: 'centos', version: '7.1').converge(described_recipe)
    end

    before do
      allow(Chef::Config).to receive(:file_cache_path).and_return('/var/chef/cache')
      stub_command('rpm -ql artifactory').and_return(true)
    end

    it 'includes the `configuration` recipe' do
      expect(chef_run).to include_recipe('artifactory_pro::configuration')
    end
  end
end
