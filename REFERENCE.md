# Reference

## Table of Contents

1. [Custom Facts](#custom-facts)
    1. [`dnf_modules`](#dnf_modules) - DNF modules, their streams and modules
1. [Custom resources](#custom-resources)
    1. [`dnf_module`](#dnf_module) - Manages DNF modules and their profiles

## Custom Facts

### `dnf_modules`

DNF modules, their streams and modules

- Output format: YAML hash

```Yaml
dnf_modules:
    <Module>:
        <Stream>: [<Profiles>]
        <Stream>: [<Profiles>]
        ...
    <Module>:
    ...
```

- Usage

    - OS command `facter`

    ```Shell
    # All modules
    facter --external-dir <Modules dir>/dnf/facts.d dnf_modules
    # Specific module
    facter --external-dir <Modules dir>/dnf/facts.d dnf_modules.<Module name>
    ```

    - Inside manifest

    ```Ruby
    # All modules
    $::facts['dnf_modules']
    # Specific module
    $::facts['dnf_modules']['<Module name>']
    ```

    - In custom resources

    ```Ruby
    # All modules
    Facter['dnf_modules'].value
    # Specific module
    Facter['dnf_modules'].value['<Module name>']
    ```

## Custom resources

### `dnf_module`

Manages DNF modules and their profiles

Usage:

```Puppet
dnf_module { '<Title>':
  module  => '<Module>',
  profile => '<Profile>',
  action  => '<Action>',
}
```

- `Module` - DNF module name
- `Profile` - DNF module profile name
    - Optional - When absent, runs actions in module's default profile
    - Only compatible to actions 'install', 'remove' and 'update'
- `Action` - Change to be done in module
    - Accepted values: 'disable', 'enable', 'install', 'remove', 'reset' and 'update'

> You can query available modules and their profiles with [dnf_modules custom fact](#dnf_modules), `dnf -q module list` or `dnf -q module list <Module>`
