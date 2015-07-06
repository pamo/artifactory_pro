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

    it 'installs rsync' do
      expect(chef_run).to install_package('rsync')
    end

    it 'downloads the artifactory rpm' do
      expect(chef_run).to create_remote_file("#{Chef::Config[:file_cache_path]}/artifactory-3.8.0.rpm")
    end

    it 'installs the artifactory rpm' do
      expect(chef_run).to install_rpm_package('artifactory')
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

    it 'installs rsync' do
      expect(chef_run).to install_package('rsync')
    end

    it 'does not download the artifactory rpm' do
      expect(chef_run).to_not create_remote_file("#{Chef::Config[:file_cache_path]}/artifactory-3.8.0.rpm")
    end

    it 'does not install the artifactory rpm' do
      expect(chef_run).to_not install_rpm_package('artifactory')
    end
  end
end
