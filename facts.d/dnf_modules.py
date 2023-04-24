#!/usr/bin/env python3

"""
Structured fact with all DNF modules and its streams and profiles

Desired output format: YAML hash
dnf_modules:
    <Module>:
        default_stream: <Stream> or None
        enabled_stream: <Stream> or None
        streams:
            <Stream>:
                default_profile: <Profile> or None
                enabled_profile: <Profile> or None
                profiles: [<Profiles>]
            <Stream>:
                ...
    <Module>:
        ...
"""

from dnf.base import Base
from dnf.module.module_base import ModuleBase

def list_module_objs():

    """List dnf modules as libdnf.module.ModulePackage objects
    """

    base = Base()           # Empty
    base.read_all_repos()   # Read main conf file and .repo files
    base.fill_sack()        # Prepare the Sack and the Goal objects

    mod_base = ModuleBase(base)
    return mod_base.get_modules('*')[0]


def default_profile(module_obj):

    """Get module's default profile
    """

    try:
        return module_obj.getDefaultProfile().getName()
    except RuntimeError:
        return None


def list_modules(module_objs):

    """Get names, streams and profiles for all DNF modules
    """

    modules = {}
    for module_obj in module_objs:
        module_name = module_obj.getName()
        if module_name not in modules:
            modules[module_name] = {'streams': {}}
        modules[module_name]['streams'][module_obj.getStream()] = {
            'default_profile': default_profile(module_obj),
            'profiles': [profile_obj.getName() for profile_obj in module_obj.getProfiles()]
        }

    return modules


dnf_module_objs = list_module_objs()
modules = list_modules(dnf_module_objs)
