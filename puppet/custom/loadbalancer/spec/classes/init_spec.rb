require 'spec_helper'
describe 'loadbalancer' do

  context 'with defaults for all parameters' do
    it { should contain_class('loadbalancer') }
  end
end
