# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..13} )

inherit distutils-r1 pypi

DESCRIPTION="A rough port of Node.js's EventEmitter to Python with a few tricks of its own"
HOMEPAGE="
	https://github.com/jfhbrook/pyee
	https://pypi.org/project/pyee/
"

LICENSE="|| ( MIT )"
SLOT="0"
KEYWORDS="amd64 ~arm64 x86"
# tests need root access
RESTRICT="test"

BDEPEND="
	dev-python/typing-extensions[${PYTHON_USEDEP}]
"
