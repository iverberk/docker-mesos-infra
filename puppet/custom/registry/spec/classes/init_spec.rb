require 'spec_helper'
describe 'registry' do

  context 'with defaults for all parameters' do
    it { should contain_class('registry') }
  end
end
