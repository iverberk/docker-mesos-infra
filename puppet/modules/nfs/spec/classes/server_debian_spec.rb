
require 'spec_helper'
describe 'nfs::server::debian' do
  it do
    should contain_class('nfs::client::debian')
    should contain_package('nfs-kernel-server')
    should contain_service('nfs-kernel-server').with( 'ensure' => 'running'  )
  end
  context ":nfs_v4 => true" do
    let(:params) {{ :nfs_v4 => true }}
    it do
      should contain_service('idmapd').with( 'ensure' => 'running'  )
    end

  end
end

