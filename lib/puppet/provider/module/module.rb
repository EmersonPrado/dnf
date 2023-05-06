Puppet::Type.type(:module).provide(:module) do
  desc 'Implements DNF module actions'

  commands dnf: 'dnf'

  def module_has_profile?(module_name, profile_name)
    Facter['dnf_modules'].value[module_name].each_value do |profiles|
      return true if profiles.include?(profile_name)
    end
    false
  end

  def get_module(module_name, profile_name, state)
    dnf('-q', 'module', state, 'list', module_name)
  rescue
    false
  else
    true
  end

  def set_module(command, module_name)
    dnf('-y', 'module', command, module_name)
  end

  def action
    raise "Module #{resource[:module]} doesn't have profile #{resource[:profile]}!" unless
    resource[:profile].nil? || module_has_profile?(resource[:module], resource[:profile])
  end

  def action=(action_name)
    raise 'Profile specification only for actions install, remove and update!' unless
    resource[:profile].nil? || [:install, :remove, :update].include?(action_name)
    case action_name
    when :enable, :disable
      return if get_module(resource[:module], resource[:profile], "--#{action_name}d")
    when :reset
      return unless get_module(resource[:module], resource[:profile], '--enabled') ||
                    get_module(resource[:module], resource[:profile], '--disabled')
    when :install
      return if get_module(resource[:module], resource[:profile], '--installed')
    when :remove, :update
      return unless get_module(resource[:module], resource[:profile], '--installed')
    end
    set_module(action_name, resource[:module])
  end
end
