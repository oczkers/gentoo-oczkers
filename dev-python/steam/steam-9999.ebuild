# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python2_7 python3_{5,6,7,8} pypy )

inherit git-r3 distutils-r1

DESCRIPTION=""
HOMEPAGE=""
if [ "${PV#9999}" != "${PV}" ] ; then
	# SRC_URI=""
	KEYWORDS=""
	EGIT_REPO_URI="https://github.com/ValvePython/${PN}"
else
	SRC_URI="https://github.com/ValvePython/${PN}/archive/${PV}.tar.gz"
	KEYWORDS="~amd64 ~arm"
fi

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""


DEPEND="dev-python/setuptools"  # six

RDEPEND="${DEPEND}
         dev-python/cachetools
         dev-python/vdf
         dev-python/pycryptodomex
         dev-python/protobuf-python
         dev-python/gevent"  # https://pypi.org/simple/gevent-eventemitter/
