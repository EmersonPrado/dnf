Puppet::Type.type(:module).provide(:module) do
  desc "Implements DNF module actions"

  commands :dnf => 'dnf'

  def do_action(*params)
    dnf('module', '-q', *params)
  end

  def query_module(module_name, *state)
    dnf('-q', 'module', *state, 'list', module_name).lines.each do |line|
      return true if line.split()[0] == module_name
    end
    return false
  end

  def action
    raise "Resource #{resource[:name]} doesn't exist!" unless query_module(resource[:name])
  end
  def action=(action_name)
    true
  end

end
