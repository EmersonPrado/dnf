#!/usr/bin/env python3

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


def list_modules(module_objs):

    """Get names, streams and profiles for all DNF modules
    """

    modules = {}
    for module_obj in module_objs:
        module_name = module_obj.getName()
        if module_name not in modules:
            modules[module_name] = {'streams': {}}
        modules[module_name]['streams'][module_obj.getStream()] = {}

    return modules


dnf_module_objs = list_module_objs()
modules = list_modules(dnf_module_objs)
