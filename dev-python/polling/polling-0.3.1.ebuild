# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python2_7 python3_{5,6,7,8} pypy )

inherit distutils-r1

DESCRIPTION="Powerful polling utility in Python"
HOMEPAGE="https://github.com/justiniso/polling"
SRC_URI="mirror://pypi/${P:0:1}/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""


DEPEND="dev-python/setuptools"

RDEPEND="${DEPEND}"
