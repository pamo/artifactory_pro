require 'spec_helper'

describe 'artifactory_pro::default' do
  context 'artifactory is not installed' do
    let(:chef_run) do
      ChefSpec::ServerRunner.new(platform: 'centos', version: '6.6').converge(described_recipe)
    end

    before do
      allow(Chef::Config).to receive(:file_cache_path).and_return('/var/chef/cache')
      stub_command('rpm -ql artifactory').and_return(false)
    end

    it 'does not write the licence file' do
      expect(chef_run).to_not create_file('/var/opt/jfrog/artifactory/etc/artifactory.lic').with(
        user: 'artifactory',
        group: 'artifactory',
      )
    end
  end

  context 'artifactory is installed' do
    let(:chef_run) do
      ChefSpec::ServerRunner.new(platform: 'centos', version: '6.6').converge(described_recipe)
    end

    before do
      allow(Chef::Config).to receive(:file_cache_path).and_return('/var/chef/cache')
      stub_command('rpm -ql artifactory').and_return(true)
    end

    it 'writes the licence file' do
      expect(chef_run).to create_file('/var/opt/jfrog/artifactory/etc/artifactory.lic').with(
        user: 'artifactory',
        group: 'artifactory',
      )
    end
  end
end
