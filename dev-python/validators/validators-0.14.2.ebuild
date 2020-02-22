# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=(python3_{6,7,8} pypy3 )
PYTHON_REQ_USE="threads(+)"

inherit distutils-r1

DESCRIPTION=" Python Data Validation for Humans™."
HOMEPAGE="https://github.com/kvesteri/validators"
SRC_URI="mirror://pypi/${P:0:1}/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE="brotli"

RDEPEND="
    >=dev-python/six-1.4.0[${PYTHON_USEDEP}]
    >=dev-python/decorator-3.4.0[${PYTHON_USEDEP}]
"

BDEPEND="
	dev-python/setuptools[${PYTHON_USEDEP}]
"
