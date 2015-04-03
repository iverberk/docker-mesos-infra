require 'spec_helper'
describe 'registrator' do

  context 'with defaults for all parameters' do
    it { should contain_class('registrator') }
  end
end
