require 'spec_helper'
describe 'consul' do

  context 'with defaults for all parameters' do
    it { should contain_class('consul') }
  end
end
