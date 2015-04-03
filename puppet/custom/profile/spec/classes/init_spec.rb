require 'spec_helper'
describe 'profile' do

  context 'with defaults for all parameters' do
    it { should contain_class('profile') }
  end
end
