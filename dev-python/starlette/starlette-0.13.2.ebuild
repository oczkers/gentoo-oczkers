# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=(python3_{6,7,8} pypy3 )

inherit distutils-r1

DESCRIPTION="The little ASGI framework that shines."
HOMEPAGE="https://www.starlette.io/"
SRC_URI="mirror://pypi/${P:0:1}/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE="+jinja +multipart sse"  # TODO: more

RDEPEND="
	jinja? ( dev-python/jinja[${PYTHON_USEDEP}] )
	multipart? ( dev-python/python-multipart[${PYTHON_USEDEP}] )
	sse? ( dev-python/sse-starlette[${PYTHON_USEDEP}] )
"

BDEPEND="
	dev-python/setuptools[${PYTHON_USEDEP}]
"