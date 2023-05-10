# frozen_string_literal: true

require 'spec_helper'
require 'puppet/type/dnf_module_stream'

RSpec.describe 'dnf_module_stream custom resource type' do
  it 'loads' do
    expect(Puppet::Type.type(:dnf_module_stream)).not_to be_nil
  end

  let(:params) do
    {
      'module' => 'nginx',
      'stream' => '1.20',
    }
  end

  on_supported_os.each do |os, os_facts|
    context "on #{os}" do
      let(:facts) do
        os_facts
      end

      ['enable', 'switch_to'].each do |action|
        context "#{action} nginx module 1.20 stream" do
          let(:params) do
            super().merge({ 'action' => action })
          end

          it { is_expected.to compile }
          it { is_expected.to compile.with_all_deps }
          it { is_expected.to be_valid_type }
          it { is_expected.to be_valid_type.with_provider('dnf_module_stream') }
        end
      end
    end
  end
end
