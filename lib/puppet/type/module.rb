Puppet::Type.newtype(:module) do
  @doc = 'Manage DNF module'
  newparam(:name) do
    desc "Module name"
  end
end
