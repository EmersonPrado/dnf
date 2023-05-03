Puppet::Type.newtype(:module) do
  @doc = <<-EOS
    Manage DNF module
    Perform actions specific to the modules itself
    To manage DNF module streams or profiles, use corresponding resources
  EOS

  newparam(:title, :namevar => true) do
    desc 'Resource title'
  end

  newparam(:module) do
    desc 'Module name'
  end

  newproperty(:action) do
    desc 'Action to be performed on module'
    newvalues(:disable, :enable, :install, :remove, :reset, :update)
  end
end
