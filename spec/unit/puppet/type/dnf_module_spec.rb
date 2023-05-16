# frozen_string_literal: true

require 'spec_helper'

dnf_module = Puppet::Type.type(:dnf_module)
RSpec.describe dnf_module do
  it 'loads' do
    expect(dnf_module).not_to be_nil
  end

  let :params do
    [
      :title,
      :module,
      :profile,
    ]
  end

  let :properties do
    [ :action ]
  end

  it 'has expected parameters' do
    params.each do |param|
      expect(dnf_module.parameters).to be_include(param)
    end
  end

  it 'has expected properties' do
    properties.each do |property|
      expect(dnf_module.properties.map(&:name)).to be_include(property)
    end
  end
end
