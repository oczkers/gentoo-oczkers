# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{6,7} )

inherit distutils-r1

DESCRIPTION="AsyncSSH is a Python package which provides an asynchronous client and server implementation of the SSHv2 protocol on top of the Python asyncio framework. "
HOMEPAGE="
	https://github.com/ronf/asyncssh
	https://pypi.org/project/asyncssh/
"
SRC_URI="https://github.com/ronf/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="EPL"
KEYWORDS="~amd64 ~x86"
SLOT="0"

RDEPEND=">=dev-python/cryptography-2.8[${PYTHON_USEDEP}]"

    #   extras_require = {
    #       'bcrypt':     ['bcrypt >= 3.1.3'],
    #       'fido2':      ['fido2 >= 0.8.1'],
    #       'gssapi':     ['gssapi >= 1.2.0'],
    #       'libnacl':    ['libnacl >= 1.4.2'],
    #       'pyOpenSSL':  ['pyOpenSSL >= 17.0.0'],
    #       'pywin32':    ['pywin32 >= 227']
