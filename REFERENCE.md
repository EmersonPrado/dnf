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
