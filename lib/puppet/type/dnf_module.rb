Puppet::Type.newtype(:dnf_module) do
  @doc = <<-EOS
    Manage DNF module
    Perform actions specific to the modules itself
    To manage DNF module streams, use resource dnf_module_stream
  EOS

  newparam(:title, namevar: true) do
    desc 'Resource title'
  end

  newparam(:module) do
    desc 'Module name'
    validate do |value|
      raise "Module #{value} doesn't exist!" unless Facter['dnf_modules'].value.key?(value)
    end
  end

  newparam(:profile) do
    desc 'Profile name (optional)'
  end

  newproperty(:action) do
    desc 'Action to be performed on module'
    newvalues(:disable, :enable, :install, :remove, :reset, :update)
  end
end
