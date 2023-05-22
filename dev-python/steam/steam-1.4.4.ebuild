# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python2_7 python3_{5,6,7,8,9,10,11} pypy )

inherit distutils-r1

DESCRIPTION=""
HOMEPAGE=""
if [[ ${PV} == *9999* ]]; then
	# SRC_URI=""
    inherit git-r3
	EGIT_REPO_URI="https://github.com/ValvePython/${PN}"
else
	SRC_URI="https://github.com/ValvePython/${PN}/archive/v${PV}.tar.gz"
fi

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm"
IUSE=""


DEPEND="dev-python/setuptools"  # six

RDEPEND="${DEPEND}
         dev-python/cachetools
         dev-python/vdf
         dev-python/pycryptodome
         dev-python/protobuf-python"
         # dev-python/gevent"  # https://pypi.org/simple/gevent-eventemitter/
