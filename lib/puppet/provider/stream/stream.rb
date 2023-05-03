Puppet::Type.type(:stream).provide(:stream) do
  desc "Implements DNF module stream actions"

  commands :dnf => 'dnf'

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

  def action
    exists?(resource[:module], resource[:stream])
  end
  def action=(action_name)
    true
  end

end
