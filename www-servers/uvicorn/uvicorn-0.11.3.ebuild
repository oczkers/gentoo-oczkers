# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=(python3_{6,7,8} pypy3 )
PYTHON_REQ_USE="threads(+)"

inherit distutils-r1

DESCRIPTION="The lightning-fast ASGI server."
HOMEPAGE="https://www.uvicorn.org/"
SRC_URI="mirror://pypi/${P:0:1}/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
# IUSE=""

RDEPEND="
    >=dev-python/click-7[${PYTHON_USEDEP}]
    <dev-python/click-8[${PYTHON_USEDEP}]
    >=dev-python/h11-0.8[${PYTHON_USEDEP}]
    <dev-python/h11-0.10[${PYTHON_USEDEP}]
    >=dev-python/uvloop-0.14.0[${PYTHON_USEDEP}]
    >=dev-python/httptools-0.1.0[${PYTHON_USEDEP}]
    <dev-python/httptools-0.2.0[${PYTHON_USEDEP}]
"

    # >=dev-python/httptools-0.1.0[${PYTHON_USEDEP}]
    # <dev-python/httptools-0.2.0[${PYTHON_USEDEP}]

    # >=dev-python/websockets-8[${PYTHON_USEDEP}]
    # <dev-python/websockets-9[${PYTHON_USEDEP}]

BDEPEND="
	dev-python/setuptools[${PYTHON_USEDEP}]
"

# TODO: licence file (starlette also)
