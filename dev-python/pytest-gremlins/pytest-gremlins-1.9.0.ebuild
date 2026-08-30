# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=hatchling
PYTHON_COMPAT=( python3_{11..14} )

inherit distutils-r1 pypi

DESCRIPTION="Fast-first mutation testing for pytest"
HOMEPAGE="
	https://github.com/mikelane/pytest-gremlins
	https://pypi.org/project/pytest-gremlins/
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm64 ~x86"

RDEPEND="
	>=dev-python/coverage-7.12.0[${PYTHON_USEDEP}]
	>=dev-python/pytest-7.0.0[${PYTHON_USEDEP}]
"
BDEPEND="
	test? (
		dev-python/pytest-xdist[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests pytest
