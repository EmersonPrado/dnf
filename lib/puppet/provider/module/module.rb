Puppet::Type.type(:module).provide(:module) do
  desc "Implements DNF module actions"

  commands :dnf => 'dnf'

  def get_module(module_name, *state)
    begin
      dnf('-q', 'module', *state, 'list', module_name)
    rescue
      false
    else
      true
    end
  end

  def set_module(command, module_name)
    dnf('-y', 'module', command, module_name)
  end

  def action
    raise "Resource #{resource[:name]} doesn't exist!" unless get_module(resource[:name])
  end
  def action=(action_name)
    case action_name
    when :enable,:disable
      return if get_module(resource[:name], "--#{action_name}d")
    when :reset
      return unless get_module(resource[:name], "--enabled") or get_module(resource[:name], "--disabled")
    when :install
      return if get_module(resource[:name], "--installed")
    when :remove,:update
      return unless get_module(resource[:name], "--installed")
    end
    set_module(action_name, resource[:name])
  end

end
