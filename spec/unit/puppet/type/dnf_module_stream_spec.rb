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

  it 'has expected parameters' do
    params.each do |param|
      expect(dnf_module_stream.parameters).to be_include(param)
    end
  end
end
