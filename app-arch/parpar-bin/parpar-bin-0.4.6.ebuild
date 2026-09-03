# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="High performance multi-threaded PAR2 creation tool (pre-built static binary)"
HOMEPAGE="https://github.com/animetosho/ParPar"

SRC_URI="
	amd64? (
		https://github.com/animetosho/ParPar/releases/download/v${PV}/parpar-v${PV}-linux-static-amd64.xz
			-> ${P}-amd64.xz
	)
	arm64? (
		https://github.com/animetosho/ParPar/releases/download/v${PV}/parpar-v${PV}-linux-static-aarch64.xz
			-> ${P}-arm64.xz
	)
"
S="${WORKDIR}"

LICENSE="CC0-1.0"
SLOT="0"
KEYWORDS="~amd64 ~arm64"
RESTRICT="strip test"

RDEPEND="!app-arch/parpar"
BDEPEND="app-arch/xz-utils"

QA_PREBUILT="usr/bin/parpar"

src_compile() {
	:
}

src_install() {
	local bin
	for bin in "${P}"-*; do
		if [[ -f "${bin}" ]]; then
			newbin "${bin}" parpar
			return
		fi
	done
	die "No binary found to install"
}
