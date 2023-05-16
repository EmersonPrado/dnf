# frozen_string_literal: true

require 'spec_helper'

dnf_module_stream = Puppet::Type.type(:dnf_module_stream)
RSpec.describe dnf_module_stream do
  it 'loads' do
    expect(dnf_module_stream).not_to be_nil
  end

  let :params do
    [
      :title,
      :module,
      :stream,
    ]
  end

  let :properties do
    [ :action ]
  end

  it 'has expected parameters' do
    params.each do |param|
      expect(dnf_module_stream.parameters).to be_include(param)
    end
  end

  it 'has expected properties' do
    properties.each do |property|
      expect(dnf_module_stream.properties.map(&:name)).to be_include(property)
    end
  end
end
