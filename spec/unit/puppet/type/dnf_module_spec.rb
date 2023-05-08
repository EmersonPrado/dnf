# frozen_string_literal: true

require 'spec_helper'
require 'puppet/type/dnf_module'

RSpec.describe 'dnf_module custom resource type' do
  it 'loads' do
    expect(Puppet::Type.type(:dnf_module)).not_to be_nil
  end
end
