Puppet::Type.type(:module).provide(:module) do
  desc 'Implements DNF module actions'

  commands dnf: 'dnf'

  def get_module(module_name, *state)
    dnf('-q', 'module', *state, 'list', module_name)
  rescue
    false
  else
    true
  end

  def set_module(command, module_name)
    dnf('-y', 'module', command, module_name)
  end

  def action
    raise "Module #{resource[:module]} doesn't exist!" unless get_module(resource[:module])
  end

  def action=(action_name)
    case action_name
    when :enable, :disable
      return if get_module(resource[:module], "--#{action_name}d")
    when :reset
      return unless get_module(resource[:module], '--enabled') or get_module(resource[:module], '--disabled')
    when :install
      return if get_module(resource[:module], '--installed')
    when :remove, :update
      return unless get_module(resource[:module], '--installed')
    end
    set_module(action_name, resource[:module])
  end
end
