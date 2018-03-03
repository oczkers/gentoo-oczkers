# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6
PYTHON_COMPAT=( python2_7 python3_{4,5,6} pypy )

inherit distutils-r1

DESCRIPTION=""
HOMEPAGE=""
SRC_URI="https://github.com/amietn/${PN}/archive/v${PV}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND="dev-python/setuptools"
RDEPEND="${DEPEND}
	dev-lang/python
	dev-python/pillow
	dev-python/jinja
	dev-python/texttable
	dev-python/parsedatetime
	dev-python/numpy"  # add enum34 for python <3.4
