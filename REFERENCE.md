# Reference

## Table of Contents

1. [Custom Facts](#custom-facts)
    1. [`dnf_modules`](#dnf_modules) - DNF modules, their streams and modules

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
