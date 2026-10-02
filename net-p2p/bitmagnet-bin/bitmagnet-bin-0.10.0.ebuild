# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit pax-utils systemd

DESCRIPTION="Self-hosted BitTorrent indexer, DHT crawler and torrent search engine (pre-built binary)"
HOMEPAGE="https://bitmagnet.io https://github.com/bitmagnet-io/bitmagnet"

SRC_URI="
	amd64? (
		https://github.com/bitmagnet-io/bitmagnet/releases/download/v${PV}/bitmagnet_${PV}_linux_x86_64.tar.gz
			-> ${PN}-${PV}-amd64.tar.gz
	)
	arm64? (
		https://github.com/bitmagnet-io/bitmagnet/releases/download/v${PV}/bitmagnet_${PV}_linux_arm64.tar.gz
			-> ${PN}-${PV}-arm64.tar.gz
	)
	arm? (
		https://github.com/bitmagnet-io/bitmagnet/releases/download/v${PV}/bitmagnet_${PV}_linux_arm.tar.gz
			-> ${PN}-${PV}-arm.tar.gz
	)
"
S="${WORKDIR}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64"
RESTRICT="strip test"

DEPEND="
	acct-group/bitmagnet
	acct-user/bitmagnet
"
RDEPEND="
	${DEPEND}
	!net-p2p/bitmagnet
"
BDEPEND="
	acct-group/bitmagnet
	acct-user/bitmagnet
"

QA_PREBUILT="usr/bin/bitmagnet"

src_compile() {
	:
}

src_install() {
	dobin bitmagnet
	pax-mark m "${ED}"/usr/bin/bitmagnet

	newinitd "${FILESDIR}"/bitmagnet.initd bitmagnet
	newconfd "${FILESDIR}"/bitmagnet.confd bitmagnet

	systemd_dounit "${FILESDIR}"/bitmagnet.service

	insinto /etc/default
	newins "${FILESDIR}"/bitmagnet.default bitmagnet

	insinto /etc/bitmagnet
	newins "${FILESDIR}"/config.example.yaml config.example.yaml

	keepdir /var/lib/bitmagnet
	fowners bitmagnet:bitmagnet /var/lib/bitmagnet
	fperms 0750 /var/lib/bitmagnet

	keepdir /var/log/bitmagnet
	fowners bitmagnet:bitmagnet /var/log/bitmagnet
	fperms 0755 /var/log/bitmagnet

	dodoc README.md
	if [[ -d licenses ]]; then
		dodoc -r licenses
	fi
}

pkg_postinst() {
	if [[ -z "${REPLACING_VERSIONS}" ]]; then
		elog "bitmagnet requires a PostgreSQL database to run."
		elog "Configure database credentials and options in:"
		elog "  ${EROOT}/etc/conf.d/bitmagnet (OpenRC)"
		elog "  ${EROOT}/etc/default/bitmagnet (systemd)"
		elog "  ${EROOT}/etc/bitmagnet/config.example.yaml (YAML template)"
		elog ""
		elog "Default Web UI is available at http://localhost:3333/"
	fi
}
