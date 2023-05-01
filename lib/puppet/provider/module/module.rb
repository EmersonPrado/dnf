Puppet::Type.type(:module).provide(:module) do
  desc "Implements DNF module actions"

  commands :dnf => 'dnf'

  def do_action(*params)
    dnf('module', '-q', *params)
  end

  def action
    true
  end
  def action=(action_name)
    true
  end

end
