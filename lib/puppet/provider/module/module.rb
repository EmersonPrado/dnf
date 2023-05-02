Puppet::Type.type(:module).provide(:module) do
  desc "Implements DNF module actions"

  commands :dnf => 'dnf'

  def query_module(module_name, *state)
    begin
      dnf('-q', 'module', *state, 'list', module_name)
    rescue
      return false
    else
      return true
    end
  end

  def run_action(command, module_name)
    dnf('-y', 'module', command, module_name)
  end

  def action
    raise "Resource #{resource[:name]} doesn't exist!" unless query_module(resource[:name])
  end
  def action=(action_name)
    true
  end

end
