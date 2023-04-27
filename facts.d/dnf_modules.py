#!/usr/bin/env python3

"""
Structured fact with all DNF modules and its streams and profiles

Desired output format: YAML hash
dnf_modules:
    <Module>:
        <Stream>: [<Profiles>]
        <Stream>: [<Profiles>]
            ...
    <Module>:
        ...
"""

from dnf.base import Base
from dnf.module.module_base import ModuleBase
from yaml import dump

def list_module_objs():

    """List dnf modules as libdnf.module.ModulePackage objects
    """

    base = Base()           # Empty
    base.read_all_repos()   # Read main conf file and .repo files
    try:
        base.fill_sack()    # Prepare the Sack and the Goal objects
    except dnf.exceptions.RepoError:
        pass

    mod_base = ModuleBase(base)
    return mod_base.get_modules('*')[0]


def list_modules(module_objs):

    """Get names, streams and profiles for all DNF modules
    """

    modules = {}
    for module_obj in module_objs:
        module_name = module_obj.getName()
        if module_name not in modules:
            modules[module_name] = {}
        modules[module_name][module_obj.getStream()] = [
            profile_obj.getName() for profile_obj in module_obj.getProfiles()
        ]

    return modules


dnf_module_objs = list_module_objs()
print(dump({'dnf_modules': list_modules(dnf_module_objs)}))
