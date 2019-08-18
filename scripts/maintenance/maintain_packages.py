#!/bin/python

import sys
import datetime
import os

common_packages_path = '~/dotfiles/common_packages.txt'
unique_packages_path = '~/unique_packages.txt'

mode = 'N/A'
for arg in sys.argv[1:]:
    if arg == '--push':
        mode = 'push'
    elif arg == '--pull':
        mode = 'pull'

if mode == 'N/A':
    print("Maintains packages between several systems. Must be run in either push or pull mode, as shown below.")
    print("Usage: {} [--push] [--pull]".format(sys.argv[0]))
    print("\t--push : Runs the script in push mode. The file {} will be updated to contain exactly the packages installed on this system (minus the system unique packages, described below)".format(common_packages_path))
    print("\t\ti.e. common_packages = installed_packages - unique_packages")
    print("\t--pull : Runs the script in pull mode. Any packages on this system not in {} or the system unique package list will be removed, while any new packages in {} or the unique package list will be installed".format(common_packages_path, common_packages_path))
    print("\t\ti.e. installed_packages = common_packages + unique_packages")
    print("Common packages are stored in {}".format(common_packages_path))
    print("System unique packages, or packages that should be installed on the local system but not synced with other systems, are stored in {}".format(unique_packages_path))
    exit()

if mode == 'push':
    now = datetime.datetime.now()
    installed_packages_tmp_path = '/tmp/installed_packages_{}.txt'.format(now.strftime('%Y-%m-%d_%H%M'))
    unique_packages_sorted_tmp_path = '/tmp/unique_packages_sorted_{}.txt'.format(now.strftime('%Y-%m-%d_%H%M'))
    os.system('pacman -Q | sed "s/ [0-9]*.*//g" | sort > {}'.format(installed_packages_tmp_path))
    os.system('cat {} | sort > {}'.format(unique_packages_path, unique_packages_sorted_tmp_path))
    package_list = os.popen('comm -23 {} {}'.format(installed_packages_tmp_path, unique_packages_sorted_tmp_path)).read().splitlines()

    common_packages_file = open(os.path.expanduser(common_packages_path), 'w+')
    common_packages_file.write('\n'.join(package_list))
    common_packages_file.close()
elif mode == 'pull':
    print("pull")
else:
    print("An error occured: mode must be either push or pull")
