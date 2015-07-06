require 'spec_helper'

describe('/var/opt/jfrog/artifactory/etc/artifactory.lic') do
  it { should be_file }
  it { should exist }
  its(:content) { should match(/Override with your license key./) }
end
