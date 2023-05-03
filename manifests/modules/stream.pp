define dnf::modules::stream (
  String $module,
  String $stream,
  Enum[enable, switch-to] $action,
) {
  $_action = $action ? {
    'enable'    => 'enable',
    'switch-to' => 'switch',
  }
  stream { $title:
    module => $module,
    stream => $stream,
    action => $_action,
  }
}
