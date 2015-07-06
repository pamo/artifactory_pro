require 'spec_helper'

describe package('artifactory') do
  it { should be_installed }
end
