# frozen_string_literal: true

require 'spec_helper'
require 'puppet/type/dnf_module'

RSpec.describe 'dnf_module custom resource type' do
  it 'loads' do
    expect(Puppet::Type.type(:dnf_module)).not_to be_nil
  end

  let(:params) do
    { 'module' => 'nginx' }
  end

  on_supported_os.each do |os, os_facts|
    context "on #{os}" do
      let(:facts) do
        os_facts
      end

      ['disable', 'enable', 'install', 'remove', 'reset', 'update'].each do |action|
        context "#{action} nginx module" do
          let(:params) do
            super().merge(
              {
                'profile' => :undef,
                'action'  => action,
              },
            )
          end

          it { is_expected.to compile }
          it { is_expected.to compile.with_all_deps }
          it { is_expected.to be_valid_type }
          it { is_expected.to be_valid_type.with_provider('dnf_module') }
        end
      end

      ['install', 'remove', 'update'].each do |action|
        context "#{action} nginx module common profile" do
          let(:params) do
            super().merge(
              {
                'profile' => 'common',
                'action'  => action,
              },
            )
          end

          it { is_expected.to compile }
          it { is_expected.to compile.with_all_deps }
        end
      end

      ['disable', 'enable', 'reset'].each do |action|
        context "#{action} nginx module common profile" do
          let(:params) do
            super().merge(
              {
                'profile' => 'common',
                'action'  => action,
              },
            )
          end

          it {
            is_expected.to compile.and_raise_error(%r{Profile specification only for actions install, remove and update!})
          }
          it { is_expected.to compile.with_all_deps }
        end
      end
    end
  end
end
