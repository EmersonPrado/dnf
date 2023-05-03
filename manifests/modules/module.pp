# Manage DNF modules
#   To manage DNF module streams or profiles, use dnf::modules::(stream|profile)
#
# Usage:
#   dnf::modules::module { '<Title>':
#     module => '<Module>',
#     action => '<Action>',
#   }
# Or
#   dnf::modules::module { '<Title>':
#     module => ['<Module 1>', '<Module 2>', ...],
#     action => '<Action>',
#   }
#
# DNF module actions:
#   https://dnf.readthedocs.io/en/latest/command_ref.html#module-command-label
#
define dnf::modules::module (
  Variant[String, Array] $module,
  Enum[disable, enable, install, remove, reset, update] $action,
) {
  module { $title:
    module => $module,
    action => $action,
  }
}
