Puppet::Type.type(:stream).provide(:stream) do
  desc "Implements DNF module stream actions"

  commands :dnf => 'dnf'

  def get(item, *state)
    dnf('-q', 'module', 'list', *state, item)
  end

  def action
    true
  end
  def action=(action_name)
    true
  end

end
