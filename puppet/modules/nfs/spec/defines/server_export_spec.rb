
require 'spec_helper'

describe 'nfs::server::export' do
  let(:facts) {{ :concat_basedir => '/dne' }}
  let(:title) { '/srv/test' }
  #let(:params) {{ :server => 'nfs.int.net', :share => '/srv/share' } }
  it do
    should contain_nfs__server__export__configure('/srv/test')
  end
end
