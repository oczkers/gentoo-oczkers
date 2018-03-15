# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6
PYTHON_COMPAT=( python2_7 python3_{4,5,6} pypy )

inherit distutils-r1

DESCRIPTION=""
HOMEPAGE=""
SRC_URI="https://github.com/simon-weber/${PN}/archive/${PV}.tar.gz"

LICENSE="BSD 3-Clause"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

# DEPEND="dev-python/setuptools
# 				dev-python/appdirs
# 				dev-python/future"
# RDEPEND="${DEPEND}
# 				 dev-lang/python
# 				 dev-python/pyasn1
# 				 dev-python/pyasn1-modules"

DEPEND="dev-python/setuptools"

RDEPEND="${DEPEND}
         dev-python/decorator
         dev-python/gpsoauth
         dev-python/proboscis
         media-libs/mutagen
         dev-python/MechanicalSoup
         dev-python/oauth2client
         dev-python/six
         dev-python/mock
         dev-python/decorator
         dev-python/requests
         dev-python/python-dateutil"
         # dev-python/protobuf  # need fix
         # dev-python/validictory  # todo



#         validictory
#dev-python/protobuf  # dev-libs
#dev-python/validictory  # todo
