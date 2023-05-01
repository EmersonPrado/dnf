Puppet::Type.newtype(:module) do
  @doc = 'Manage DNF module'
  newparam(:name) do
    true
  end
end
