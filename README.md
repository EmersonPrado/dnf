# dnf

Manages DNF package manager features not included in previous tool YUM

## Table of Contents

1. [Description](#description)
1. [Setup - The basics of getting started with dnf](#setup)
    1. [Setup requirements](#setup-requirements)
    1. [Beginning with dnf](#beginning-with-dnf)
1. [Usage - Configuration options and additional functionality](#usage)
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

Include usage examples for common use cases in the **Usage** section. Show your
users how to use your module to solve problems, and be sure to include code
examples. Include three to five examples of the most important or common tasks a
user can accomplish with your module. Show users how to accomplish more complex
tasks that involve different types, classes, and functions working in tandem.

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
