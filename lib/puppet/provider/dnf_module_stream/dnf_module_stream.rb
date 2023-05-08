Puppet::Type.type(:dnf_module_stream).provide(:dnf_module_stream) do
  desc 'Implements DNF module stream actions'

  commands dnf: 'dnf'

  def get_enabled(module_name)
    lines = dnf('-q', 'module', 'list', '--enabled', module_name).lines
  rescue
    nil
  else
    lines.each do |line|
      items = line.split
      return items[1] if items[0] == module_name
    end
  end

  def set_stream(command, module_name, stream_name)
    dnf('-y', 'module', command, "#{module_name}:#{stream_name}")
  end

  def action
    raise "Module #{resource[:module]} doesn't have stream #{resource[:stream]}!" unless
    Facter['dnf_modules'].value[resource[:module]].key?(resource[:stream])
  end

  def action=(action_name)
    enabled_stream = get_enabled(resource[:module])
    return if enabled_stream == resource[:stream]
    case action_name
    when :enable
      raise <<-EOS unless enabled_stream.nil?
        Can't enable stream #{resource[:stream]} because #{enabled_stream} is enabled
        Reset module resource[:module] before or use 'switch-to' instead
      EOS
    when :switch
      action_name = 'switch-to'
    end
    set_stream(action_name, resource[:module], resource[:stream])
  end
end
