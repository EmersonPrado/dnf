Puppet::Type.type(:module).provide(:module) do
  desc 'Implements DNF module actions'

  commands dnf: 'dnf'

  def module_has_profile?(module_name, profile_name)
    Facter['dnf_modules'].value[module_name].each_value do |profiles|
      return true if profiles.include?(profile_name)
    end
    false
  end

  def stream_profile_data(value)
    if value.include?(' ')
      [
        value.split[0],
        value.include?('[e]') || value.include?('[i]'),
        value.include?('[d]'),
      ]
    else
      [value, false, false]
    end
  end

  def module_info_2_hash(dnf_output)
    module_hash = { streams: {} }
    dnf_output.lines.each do |line|
      key, value = line.split(' : ')
      next if value.nil?
      value.lstrip!
      case key.rstrip
      when 'Stream'
        @stream_name, enabled, default = stream_profile_data(value)
        module_hash[:streams][@stream_name] = { profiles: [] } unless
          module_hash[:streams].key?(@stream_name)
        module_hash[:enabled_stream] = @stream_name if enabled
        module_hash[:default_stream] = @stream_name if default
      when 'Profiles'
        value.split(', ').each do |item|
          profile_name, installed, default = stream_profile_data(item)
          module_hash[:streams][@stream_name][:profiles].push(profile_name) unless
            module_hash[:streams][@stream_name][:profiles].include?(profile_name)
          module_hash[:streams][@stream_name][:installed_profile] = profile_name if installed
          module_hash[:streams][@stream_name][:default_profile] = profile_name if default
        end
      end
    end
    module_hash
  end

  def profile_installed?(module_name, profile_name)
    module_hash = module_info_2_hash(dnf('-q', 'module', 'info', module_name))
    return false unless module_hash.key?(:enabled_stream)
  end

  def get_module(module_name, profile_name, state)
    dnf('-q', 'module', state, 'list', module_name)
  rescue
    false
  else
    profile_name.nil? || profile_installed?(module_name, profile_name)
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
