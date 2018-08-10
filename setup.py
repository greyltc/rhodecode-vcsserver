# -*- coding: utf-8 -*-
# RhodeCode VCSServer provides access to different vcs backends via network.
# Copyright (C) 2014-2017 RodeCode GmbH
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software Foundation,
# Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301  USA

# Import early to make sure things are patched up properly
from setuptools import setup, find_packages

import os
import sys
import pkgutil
import platform
import codecs

try:  # for pip >= 10
    from pip._internal.req import parse_requirements
except ImportError:  # for pip <= 9.0.3
    from pip.req import parse_requirements

try:  # for pip >= 10
    from pip._internal.download import PipSession
except ImportError:  # for pip <= 9.0.3
    from pip.download import PipSession



if sys.version_info < (2, 7):
    raise Exception('VCSServer requires Python 2.7 or later')

here = os.path.abspath(os.path.dirname(__file__))

# defines current platform
__platform__ = platform.system()
__license__ = 'GPL V3'
__author__ = 'RhodeCode GmbH'
__url__ = 'https://code.rhodecode.com'
is_windows = __platform__ in ('Windows',)


def _get_requirements(req_filename, exclude=None, extras=None):
    extras = extras or []
    exclude = exclude or []

    try:
        parsed = parse_requirements(
            os.path.join(here, req_filename), session=PipSession())
    except TypeError:
        # try pip < 6.0.0, that doesn't support session
        parsed = parse_requirements(os.path.join(here, req_filename))

    requirements = []
    for ir in parsed:
        if ir.req and ir.name not in exclude:
            requirements.append(str(ir.req))
    return requirements + extras


# requirements extract
setup_requirements = ['pytest-runner']
install_requirements = _get_requirements(
    'requirements.txt', exclude=['setuptools'])
test_requirements = _get_requirements(
    'requirements_test.txt', extras=['configobj'])


def get_version():
    version = pkgutil.get_data('vcsserver', 'VERSION')
    return version.strip()


# additional files that goes into package itself
package_data = {
    '': ['*.txt', '*.rst'],
    'configs': ['*.ini'],
    'vcsserver': ['VERSION'],
}

description = 'Version Control System Server'
keywords = ' '.join([
    'CLI', 'RhodeCode', 'RhodeCode Enterprise', 'RhodeCode Tools'])

# README/DESCRIPTION generation
readme_file = 'README.rst'
changelog_file = 'CHANGES.rst'
try:
    long_description = codecs.open(readme_file).read() + '\n\n' + \
                       codecs.open(changelog_file).read()
except IOError as err:
    sys.stderr.write(
        "[WARNING] Cannot find file specified as long_description (%s)\n "
        "or changelog (%s) skipping that file" % (readme_file, changelog_file))
    long_description = description


setup(
    name='rhodecode-vcsserver',
    version=get_version(),
    description=description,
    long_description=long_description,
    keywords=keywords,
    license=__license__,
    author=__author__,
    author_email='admin@rhodecode.com',
    url=__url__,
    setup_requires=setup_requirements,
    install_requires=install_requirements,
    tests_require=test_requirements,
    zip_safe=False,
    packages=find_packages(exclude=["docs", "tests*"]),
    package_data=package_data,
    include_package_data=True,
    classifiers=[
        'Development Status :: 6 - Mature',
        'Intended Audience :: Developers',
        'Operating System :: OS Independent',
        'Topic :: Software Development :: Version Control',
        'License :: OSI Approved :: GNU General Public License v3 or later (GPLv3+)',
        'Programming Language :: Python :: 2.7',
    ],
    entry_points={
        'console_scripts': [
            'vcsserver=vcsserver.main:main',
        ],
        'paste.app_factory': ['main=vcsserver.http_main:main']
    },
)
