# frozen_string_literal: true

require 'spec_helper'
require 'puppet/type/dnf_module_stream'

RSpec.describe 'dnf_module_stream custom resource type' do
  it 'loads' do
    expect(Puppet::Type.type(:dnf_module_stream)).not_to be_nil
  end
end
