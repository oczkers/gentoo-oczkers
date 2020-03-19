# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=(python3_{6,7,8} pypy3 )
# PYTHON_REQ_USE="threads(+)"

inherit distutils-r1

DESCRIPTION="Async database support for Python."
HOMEPAGE="https://www.encode.io/databases/"
# SRC_URI="mirror://pypi/${P:0:1}/${PN}/${P}.tar.gz"
SRC_URI="https://github.com/encode/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE="mysql"  # other engines

# TODO: aiocontextvars for python < 3.7
RDEPEND="
    >=dev-python/sqlalchemy-1.3.0[${PYTHON_USEDEP}]
    mysql? (
              dev-python/aiomysql[${PYTHON_USEDEP}]
              dev-python/pymysql[${PYTHON_USEDEP}]
    )
"

BDEPEND="
	dev-python/setuptools[${PYTHON_USEDEP}]
"
