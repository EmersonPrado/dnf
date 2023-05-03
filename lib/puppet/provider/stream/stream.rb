Puppet::Type.type(:stream).provide(:stream) do
  desc 'Implements DNF module stream actions'

  commands dnf: 'dnf'

  def get(item, *state)
    dnf('-q', 'module', 'list', *state, item)
  end

  def exists?(module_name, stream_name)
    begin
      get(module_name)
    rescue
      raise "Module #{module_name} doesn't exist!"
    end
    begin
      get("#{module_name}:#{stream_name}")
    rescue
      raise "Stream #{stream_name} from #{module_name} doesn't exist!"
    end
    true
  end

  def get_enabled(module_name)
    lines = get(module_name, '--enabled').lines
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
    exists?(resource[:module], resource[:stream])
  end

  def action=(action_name)
    enabled_stream = get_enabled(resource[:module])
    return if enabled_stream == resource[:stream]
    case action_name
    when :enable
      raise <<-EOS unless enabled_stream == nil
        Can't enable stream #{resource[:stream]} because #{enabled_stream} is enabled
        Reset module resource[:module] before or use 'switch-to' instead
      EOS
    when :switch
      action_name = 'switch-to'
    end
    set_stream(action_name, resource[:module], resource[:stream])
  end
end
