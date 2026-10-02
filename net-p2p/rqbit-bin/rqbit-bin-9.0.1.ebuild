# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit pax-utils shell-completion systemd toolchain-funcs

DESCRIPTION="Bittorrent client in Rust with Web UI and HTTP API (pre-built binary)"
HOMEPAGE="https://github.com/ikatson/rqbit"

SRC_URI="
	amd64? (
		https://github.com/ikatson/rqbit/releases/download/v${PV}/rqbit-linux-amd64
			-> ${PN}-${PV}-amd64
	)
	arm64? (
		https://github.com/ikatson/rqbit/releases/download/v${PV}/rqbit-linux-arm64
			-> ${PN}-${PV}-arm64
	)
	arm? (
		https://github.com/ikatson/rqbit/releases/download/v${PV}/rqbit-linux-arm-v7
			-> ${PN}-${PV}-armv7
	)
"
S="${WORKDIR}"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64"
RESTRICT="strip test"

RDEPEND="!net-p2p/rqbit"

QA_PREBUILT="usr/bin/rqbit"

src_unpack() {
	local bin
	if use amd64; then
		bin="${PN}-${PV}-amd64"
	elif use arm64; then
		bin="${PN}-${PV}-arm64"
	elif use arm; then
		bin="${PN}-${PV}-armv7"
	else
		die "Unsupported architecture"
	fi

	cp "${DISTDIR}/${bin}" "${WORKDIR}/rqbit" || die "Failed to copy binary"
	chmod 0755 "${WORKDIR}/rqbit" || die "Failed to make binary executable"
}

src_compile() {
	if ! tc-is-cross-compiler; then
		./rqbit completions bash > rqbit.bash || die
		./rqbit completions zsh > _rqbit || die
		./rqbit completions fish > rqbit.fish || die
	fi
}

src_install() {
	dobin rqbit
	pax-mark m "${ED}"/usr/bin/rqbit

	if ! tc-is-cross-compiler; then
		newbashcomp rqbit.bash rqbit
		newzshcomp _rqbit _rqbit
		dofishcomp rqbit.fish
	fi

	systemd_douserunit "${FILESDIR}"/rqbit.service
	systemd_douserunit "${FILESDIR}"/rqbit.socket

	insinto /usr/share/rqbit
	doins "${FILESDIR}"/rqbit.conf
}

pkg_postinst() {
	if [[ -z "${REPLACING_VERSIONS}" ]]; then
		elog "rqbit can be run as a systemd user service:"
		elog "  systemctl --user enable --now rqbit.socket"
		elog ""
		elog "Web UI is available at http://localhost:3030/web/"
		elog ""
		elog "A configuration template has been installed to:"
		elog "  ${EROOT}/usr/share/rqbit/rqbit.conf"
		elog "Copy it to ~/.config/rqbit/rqbit.conf to customize settings."
	fi
}
