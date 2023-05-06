# Manage DNF modules
#   To manage DNF module streams, use dnf::modules::stream
#
# Usage:
#   dnf::modules::module { '<Title>':
#     module  => '<Module>',
#     action  => '<Action>',
#     profile => '<Profile>',   # Optional
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
  Optional[String] $profile = undef,
) {
  module { $title:
    module  => $module,
    profile => $profile,
    action  => $action,
  }
}
