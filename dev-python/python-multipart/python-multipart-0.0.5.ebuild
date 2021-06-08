# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=(python3_{6,7,8,9} pypy3 )
# PYTHON_REQ_USE="threads(+)"

inherit distutils-r1

DESCRIPTION="A streaming multipart parser for Python."
HOMEPAGE="https://andrew-d.github.io/python-multipart/"
SRC_URI="mirror://pypi/${P:0:1}/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
# IUSE="brotli"

RDEPEND=""

BDEPEND="
	dev-python/setuptools[${PYTHON_USEDEP}]
"
