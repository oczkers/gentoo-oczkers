# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..14} )

inherit distutils-r1 pypi

DESCRIPTION="A flexible configuration library"
HOMEPAGE="
	https://github.com/omry/omegaconf
	https://pypi.org/project/omegaconf/
"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~arm64 ~x86"

RDEPEND="
	>=dev-python/pyyaml-5.1.0[${PYTHON_USEDEP}]
"

distutils_enable_tests pytest

src_prepare() {
	distutils-r1_src_prepare

	# Do not delete pre-generated grammar parsers and do not invoke java antlr
	sed -i -e '/"build_py": BuildPyCommand,/d' -e '/"clean": CleanCommand,/d' setup.py || die
}
