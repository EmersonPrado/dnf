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

  ['disable', 'enable', 'install', 'remove', 'reset', 'update'].each do |action|
    context "#{action} nginx module" do
      let(:params) do
        {
          'profile' => :undef,
          'action'  => action,
        }
      end

      it is_expected.to compile
    end
  end

  ['install', 'remove', 'update'].each do |action|
    context "#{action} nginx module common profile" do
      let(:params) do
        {
          'profile' => 'common',
          'action'  => action,
        }
      end

      it is_expected.to compile
    end
  end
end
