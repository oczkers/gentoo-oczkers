# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Flexible command-line usenet binary poster (pre-built static binary)"
HOMEPAGE="https://github.com/animetosho/Nyuu"

SRC_URI="
	amd64? ( https://github.com/animetosho/Nyuu/releases/download/v${PV}/nyuu-v${PV}-linux-amd64.tar.xz )
	arm64? ( https://github.com/animetosho/Nyuu/releases/download/v${PV}/nyuu-v${PV}-linux-aarch64.tar.xz )
"
S="${WORKDIR}"

LICENSE="CC0-1.0 MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm64"
RESTRICT="strip test"

RDEPEND="!net-nntp/nyuu"
BDEPEND="
	app-arch/tar
	app-arch/xz-utils
"

QA_PREBUILT="usr/bin/nyuu"

src_compile() {
	:
}

src_install() {
	dobin nyuu
	dodoc config-sample.json
}
