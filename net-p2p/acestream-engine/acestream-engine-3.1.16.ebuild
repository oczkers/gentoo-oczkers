# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

PYTHON_COMPAT=( python2_7 )

inherit multilib python-r1 unpacker

DESCRIPTION="ACE Stream Engine"
HOMEPAGE="http://torrentstream.org/"
SRC_URI="http://dl.acestream.org/linux/${PN:0:9}_${PV}_ubuntu_16.04_x86_64.tar.gz"

LICENSE="GPL-2 LGPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE="gtk"

DEPEND="dev-python/m2crypto[${PYTHON_USEDEP}]
		dev-python/apsw[${PYTHON_USEDEP}]
		gtk? ( dev-libs/libappindicator )"
RDEPEND="${DEPEND}"

S="${WORKDIR}"

QA_PRESTRIPPED="usr/bin/acestreamengine
usr/share/acestream/lib/acestreamengine/Core.so
usr/share/acestream/lib/acestreamengine/node.so
usr/share/acestream/lib/acestreamengine/pycompat.so
usr/share/acestream/lib/acestreamengine/Transport.so
usr/share/acestream/lib/acestreamengine/CoreApp.so
usr/share/acestream/lib/acestreamengine/streamer.so"

# TODO: library path

src_install(){
	  dodir /usr/share/acestream
	  insinto /usr/share/acestream
	  cp -R "${S}/${PN:0:9}_${PV}_ubuntu_16.04_x86_64"/* "${D}/usr/share/acestream" || die "Install failed!"
	  dosym /usr/share/acestream/acestreamengine /usr/bin/acestreamengine
}
