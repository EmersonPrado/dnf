Puppet::Type.type(:module).provide(:module) do
  desc "Implements DNF module actions"

  commands :dnf => 'dnf'

  def query_module(module_name, *state)
    begin
      dnf('-q', 'module', *state, 'list', module_name)
    rescue
      false
    else
      true
    end
  end

  def run_action(command, module_name)
    dnf('-y', 'module', command, module_name)
  end

  def action
    raise "Resource #{resource[:name]} doesn't exist!" unless query_module(resource[:name])
  end
  def action=(action_name)
    case action_name
    when :enable,:disable
      return if query_module(resource[:name], "--#{action_name}d")
    when :reset
      return unless query_module(resource[:name], "--enabled") or query_module(resource[:name], "--disabled")
    when :install
      return if query_module(resource[:name], "--installed")
    when :remove,:update
      return unless query_module(resource[:name], "--installed")
    end
    run_action(action_name, resource[:name])
  end

end
