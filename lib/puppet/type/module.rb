Puppet::Type.newtype(:module) do
  @doc = 'Manage DNF module'
  newparam(:name) do
    desc "Module name"
  end
  newproperty(:action) do
    desc "Action to be performed on module"
    newvalues(:disable, :enable, :install, :remove, :reset, :switch_to, :update)
  end
end
