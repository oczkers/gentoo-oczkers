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

DEPEND="
	acct-group/rqbit
	acct-user/rqbit
"
RDEPEND="
	${DEPEND}
	!net-p2p/rqbit
"
BDEPEND="
	acct-group/rqbit
	acct-user/rqbit
"

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

	# OpenRC service and configuration
	newinitd "${FILESDIR}"/rqbit.initd rqbit
	newconfd "${FILESDIR}"/rqbit.confd rqbit

	# Configuration file in /etc/rqbit/
	insinto /etc/rqbit
	newins "${FILESDIR}"/rqbit.conf rqbit.conf

	# systemd system service and default env
	systemd_newunit "${FILESDIR}"/rqbit.system.service rqbit.service
	insinto /etc/default
	newins "${FILESDIR}"/rqbit.default rqbit

	# systemd user units
	systemd_douserunit "${FILESDIR}"/rqbit.service
	systemd_douserunit "${FILESDIR}"/rqbit.socket

	# State and log directories
	keepdir /var/lib/rqbit
	keepdir /var/lib/rqbit/downloads
	fowners rqbit:rqbit /var/lib/rqbit
	fowners rqbit:rqbit /var/lib/rqbit/downloads
	fperms 0750 /var/lib/rqbit
	fperms 0755 /var/lib/rqbit/downloads

	keepdir /var/log/rqbit
	fowners rqbit:rqbit /var/log/rqbit
	fperms 0755 /var/log/rqbit
}

pkg_postinst() {
	if [[ -z "${REPLACING_VERSIONS}" ]]; then
		elog "rqbit can be run as an OpenRC system service:"
		elog "  rc-service rqbit start"
		elog "  rc-update add rqbit default"
		elog ""
		elog "Or as a systemd system service:"
		elog "  systemctl enable --now rqbit.service"
		elog ""
		elog "Or as a systemd user service:"
		elog "  systemctl --user enable --now rqbit.socket"
		elog ""
		elog "Configuration files are located at:"
		elog "  ${EROOT}/etc/rqbit/rqbit.conf"
		elog "  ${EROOT}/etc/conf.d/rqbit (OpenRC)"
		elog "  ${EROOT}/etc/default/rqbit (systemd)"
		elog ""
		elog "Default Web UI is available at http://localhost:3030/web/"
	fi
}
