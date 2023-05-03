# Manage DNF module streams
#   To manage DNF modules or its profiles, use dnf::modules::(module|profile)
#
# Usage:
#   dnf::modules::stream { '<Title>':
#     module => '<Module>',
#     stream => '<Stream>',
#     action => 'enable' or 'switch-to',
#   }
#
# DNF module actions:
#   https://dnf.readthedocs.io/en/latest/command_ref.html#module-command-label
#
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
