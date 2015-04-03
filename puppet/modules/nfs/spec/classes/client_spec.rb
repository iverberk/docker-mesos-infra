require 'spec_helper'

describe 'nfs::client' do
  context "operatingsysten => ubuntu" do
    let(:facts) { {:operatingsystem => 'ubuntu', } }
    it { should contain_class('nfs::client::debian') }
  end
  context "operatingsysten => debian" do
    let(:facts) { {:operatingsystem => 'debian', } }
    it { should contain_class('nfs::client::debian') }
  end
  context "operatingsysten => scientific" do
    let(:facts) { {:operatingsystem => 'scientific', :operatingsystemrelease => 6.4 } }
    it { should contain_class('nfs::client::redhat') }
  end
  context "operatingsysten => SLC" do
    let(:facts) { {:operatingsystem => 'SLC', :operatingsystemrelease => 6.4 } }
    it { should contain_class('nfs::client::redhat') }
  end
  context "operatingsysten => centos v7" do
    let(:facts) { {:operatingsystem => 'centos', :operatingsystemrelease => 7.0 } }
    it { should contain_class('nfs::client::redhat') }
  end
  context "operatingsysten => centos v6" do
    let(:facts) { {:operatingsystem => 'centos', :operatingsystemrelease => 6.4 } }
    it { should contain_class('nfs::client::redhat') }
  end
  context "operatingsysten => centos v5" do
    let(:facts) { {:operatingsystem => 'centos', :operatingsystemrelease => 5.4 } }
    it { should contain_class('nfs::client::redhat') }
  end
  context "operatingsysten => redhat v7" do
    let(:facts) { {:operatingsystem => 'redhat', :operatingsystemrelease => 7.0 } }
    it { should contain_class('nfs::client::redhat') }
  end
  context "operatingsysten => redhat v6" do
    let(:facts) { {:operatingsystem => 'redhat', :operatingsystemrelease => 6.4 } }
    it { should contain_class('nfs::client::redhat') }
  end
  context "operatingsysten => gentoo" do
    let(:facts) { {:operatingsystem => 'gentoo', } }
    it { should contain_class('nfs::client::gentoo') }
  end
  context "operatingsystem => darwin" do
    let(:facts) { {:operatingsystem => 'darwin', } }
    it do
      expect {
        should contain_class('nfs::server::darwin')
      }.to raise_error(Puppet::Error, /NFS client is not supported on Darwin/)
    end
  end
end
