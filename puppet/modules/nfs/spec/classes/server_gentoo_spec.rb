require 'spec_helper'
describe 'nfs::server::gentoo' do

  it do
    should contain_class('nfs::client::gentoo')
    should contain_service('nfs').with( 'ensure' => 'running'  )
  end
  context ":nfs_v4 => true" do
    let(:params) {{ :nfs_v4 => true , :nfs_v4_idmap_domain => 'teststring' }}
    it do
      should contain_augeas('/etc/idmapd.conf').with_changes(/set Domain teststring/)
    end

  end
end