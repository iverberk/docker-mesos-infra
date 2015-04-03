require 'spec_helper'
describe 'nfs::client::redhat' do
  context "operatingsystemrelease => 7.0" do
    let(:facts) { {:operatingsystemrelease => 7.0 } }
    it do
      should contain_class('nfs::client::redhat::install')
      should contain_class('nfs::client::redhat::configure')
      should contain_class('nfs::client::redhat::service')
      should contain_service('nfslock').with(
        'ensure' => 'running'
      )
      should contain_package('nfs-utils')
      should contain_class('nfs::client::redhat')
      should contain_package('rpcbind')
      should contain_service('rpcbind').with(
        'ensure' => 'running'
      )
    end
  end

  context "operatingsystemrelease => 6.4" do
    let(:facts) { {:operatingsystemrelease => 6.4 } }
    it do
      should contain_class('nfs::client::redhat::install')
      should contain_class('nfs::client::redhat::configure')
      should contain_class('nfs::client::redhat::service')

      should contain_service('nfslock').with(
        'ensure' => 'running'
      )
      should contain_service('netfs').with(
        'enable' => 'true'
      )
      should contain_package('nfs-utils')
      should contain_class('nfs::client::redhat')
      should contain_package('rpcbind')
      should contain_service('rpcbind').with(
        'ensure' => 'running'
      )
    end
  end

  context ":nfs_v4 => true" do
    let(:params) {{ :nfs_v4 => true }}
    let(:facts) {{ :operatingsystemrelease => 6.4 }}
    it do
      should contain_augeas('/etc/idmapd.conf') 
    end
  end

  context "operatingsystemrelease => 5.3" do
    let(:facts) { {:operatingsystemrelease => 5.3 } }
    it do
      should contain_class('nfs::client::redhat')
      should contain_package('portmap')

      should contain_service('portmap').with(
        'ensure' => 'running'
      )
    end
  end
end
