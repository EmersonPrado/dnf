Puppet::Type.type(:stream).provide(:stream) do
  desc "Implements DNF module stream actions"

  def action
    true
  end
  def action=(action_name)
    true
  end

end
