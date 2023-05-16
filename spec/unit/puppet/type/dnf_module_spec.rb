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

  it 'has expected parameters' do
    params.each do |param|
      expect(dnf_module.parameters).to be_include(param)
    end
  end
end
