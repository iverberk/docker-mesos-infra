require 'spec_helper'
describe 'nfs::client::gentoo' do

  it do
    should contain_class('nfs::client::gentoo')
    should contain_class('nfs::client::gentoo::install')
    should contain_class('nfs::client::gentoo::configure')
    should contain_class('nfs::client::gentoo::service')

    should contain_package('net-nds/rpcbind')
    should contain_package('net-fs/nfs-utils')
    should contain_package('net-libs/libnfsidmap')


  end

  context ":nfs_v4 => true" do
    let(:params) {{ :nfs_v4 => true }}
    it do
      should contain_augeas('/etc/conf.d/nfs')
      should contain_augeas('/etc/idmapd.conf')
    end
  end

end
