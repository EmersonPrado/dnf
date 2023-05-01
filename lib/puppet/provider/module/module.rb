Puppet::Type.type(:module).provide(:module) do
  desc "Implements DNF module actions"

  def action
    true
  end
  def action=(action_name)
    true
  end

end
