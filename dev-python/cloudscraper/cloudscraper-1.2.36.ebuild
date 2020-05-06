# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python2_7 python3_{5,6,7,8} pypy )

inherit distutils-r1

DESCRIPTION=""
HOMEPAGE=""
SRC_URI="https://github.com/VeNoMouS/${PN}/archive/${PV}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="recaptcha"


DEPEND="dev-python/setuptools
        recaptcha? ( dev-python/polling[${PYTHON_USEDEP}] )"

RDEPEND="${DEPEND}
         dev-python/requests
         dev-python/requests-toolbelt"