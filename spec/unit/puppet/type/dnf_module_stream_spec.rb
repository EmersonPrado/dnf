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

  ['enable', 'switch_to'].each do |action|
    context "#{action} nginx module 1.20 stream" do
      let(:params) do
        super().merge({ 'action' => action })
      end

      it { is_expected.to compile }
      it { is_expected.to compile.with_all_deps }
    end
  end
end
