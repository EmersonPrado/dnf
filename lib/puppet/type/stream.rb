Puppet::Type.newtype(:stream) do

  @doc = <<-EOS
    Manage DNF module stream
    Perform actions specific to the modules streams
    To manage DNF module itself or its profiles, use corresponding resources
  EOS

  newparam(:title, :namevar => true) do
    desc "Resource title"
  end

  newparam(:module) do
    desc "Module name"
  end

  newparam(:stream) do
    desc "Module stream"
  end

  newproperty(:action) do
    desc <<-EOS
      Action to be performed on module stream
      Use "switch" instead of "switch-to"
    EOS
    newvalues(:enable, :switch)
  end

end
