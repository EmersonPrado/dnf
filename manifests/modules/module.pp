define dnf::modules::module (
  Variant[String, Array] $module,
  Enum[disable, enable, install, remove, reset, update] $action,
) {
  module { $title:
    module => $module,
    action => $action,
  }
}
