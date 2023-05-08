# dnf

Manages DNF package manager features not included in previous tool YUM

## Table of Contents

1. [Description](#description)
1. [Setup - The basics of getting started with dnf](#setup)
    1. [Setup requirements](#setup-requirements)
    1. [Beginning with dnf](#beginning-with-dnf)
1. [Usage - Configuration options and additional functionality](#usage)
    1. [DNF module actions](#dnf-module-actions)
        1. [Default stream and profile](#default-stream-and-profile)
        1. [Stream actions](#stream-actions)
        1. [Specific profile](#specific-profile)
1. [Limitations - OS compatibility, etc.](#limitations)
1. [Development - Guide for contributing to the module](#development)
1. [References](#references)

## Description

This module allows dealing with special DNF features, like selection of modules streams and/or profiles.

For features common with Yum and general configuration, consider using [yum](https://forge.puppet.com/modules/puppet/yum/) module.

## Setup

### Setup Requirements

- OS - Must have dnf
    - RedHat family >= 8.0
    - Fedora >= 22
- Packages
    - python3
    - pyyaml

### Beginning with dnf

The very basic steps needed for a user to get the module up and running. This
can include setup steps, if necessary, or it can be an example of the most basic
use of the module.

## Usage

### DNF module actions

#### Default stream and profile

```Puppet
dnf_module { 'enable_nginx_module_default_stream':
  module  => 'nginx',
  action  => 'enable',
}
```

```Puppet
dnf_module { 'disable_nginx_module_current_streams':
  module  => 'nginx',
  action  => 'disable',
}
```

```Puppet
dnf_module { 'reset_nginx_module_all_streams':
  module  => 'nginx',
  action  => 'reset',
}
```

```Puppet
dnf_module { 'install_nginx_module_default_stream_and_profile':
  module  => 'nginx',
  action  => 'install',
}
```

```Puppet
dnf_module { 'update_nginx_module_current_stream_and_profile':
  module  => 'nginx',
  action  => 'update',
}
```

```Puppet
dnf_module { 'remove_nginx_module_default_stream_and_profile':
  module  => 'nginx',
  action  => 'remove',
}
```

#### Stream actions

```Puppet
# Only works if no other stream is enabled
dnf_module_stream { 'nginx_enable_stream_1.20':
  module => 'nginx',
  stream => '1.20',
  action => 'enable',
}
```

```Puppet
# Migrate everything if other stream is enabled
dnf_module_stream { 'nginx_switch_stream_1.20':
  module => 'nginx',
  stream => '1.20',
  action => 'switch-to',
}
```

#### Specific profile

```Puppet
dnf_module { 'install_mariadb_module_galera_profile':
  module  => 'mariadb',
  profile => 'galera',
  action  => 'install',
}
```

```Puppet
dnf_module { 'update_mariadb_module_galera_profile':
  module  => 'mariadb',
  profile => 'galera',
  action  => 'update',
}
```

```Puppet
dnf_module { 'remove_mariadb_module_server_profile':
  module  => 'mariadb',
  profile => 'server',
  action  => 'remove',
}
```

## Limitations

- So far, only implements `dnf module` configuration actions
- No unit tests yet
- Only tested in Rocky Linux 8

## Development

To help make this module better, pls follow [Contributing to Supported Modules](https://puppetlabs.github.io/iac/docs/contributing_to_a_module.html) article, from Puppetlabs [Infrastructure and Automation Content (IAC) Team](https://puppetlabs.github.io/iac/).

## References

- DNF - Read The Docs
    - [Home](https://dnf.readthedocs.io/en/latest/)
    - [Modularity Interface](https://dnf.readthedocs.io/en/latest/api_module.html)
- [DNF Source code](https://github.com/rpm-software-management/dnf/)
