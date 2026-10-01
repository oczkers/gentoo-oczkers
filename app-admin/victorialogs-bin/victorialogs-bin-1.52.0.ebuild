# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit pax-utils systemd

DESCRIPTION="High-performance, cost-effective and scalable log management system (pre-built binary)"
HOMEPAGE="https://docs.victoriametrics.com/victorialogs/ https://github.com/VictoriaMetrics/VictoriaLogs"

SRC_URI="
	amd64? (
		https://github.com/VictoriaMetrics/VictoriaLogs/releases/download/v${PV}/victoria-logs-linux-amd64-v${PV}.tar.gz
			-> ${PN}-${PV}-amd64.tar.gz
		tools? (
			https://github.com/VictoriaMetrics/VictoriaLogs/releases/download/v${PV}/vlutils-linux-amd64-v${PV}.tar.gz
				-> ${PN}-utils-${PV}-amd64.tar.gz
		)
	)
	arm64? (
		https://github.com/VictoriaMetrics/VictoriaLogs/releases/download/v${PV}/victoria-logs-linux-arm64-v${PV}.tar.gz
			-> ${PN}-${PV}-arm64.tar.gz
		tools? (
			https://github.com/VictoriaMetrics/VictoriaLogs/releases/download/v${PV}/vlutils-linux-arm64-v${PV}.tar.gz
				-> ${PN}-utils-${PV}-arm64.tar.gz
		)
	)
	arm? (
		https://github.com/VictoriaMetrics/VictoriaLogs/releases/download/v${PV}/victoria-logs-linux-arm-v${PV}.tar.gz
			-> ${PN}-${PV}-arm.tar.gz
		tools? (
			https://github.com/VictoriaMetrics/VictoriaLogs/releases/download/v${PV}/vlutils-linux-arm-v${PV}.tar.gz
				-> ${PN}-utils-${PV}-arm.tar.gz
		)
	)
	x86? (
		https://github.com/VictoriaMetrics/VictoriaLogs/releases/download/v${PV}/victoria-logs-linux-386-v${PV}.tar.gz
			-> ${PN}-${PV}-x86.tar.gz
		tools? (
			https://github.com/VictoriaMetrics/VictoriaLogs/releases/download/v${PV}/vlutils-linux-386-v${PV}.tar.gz
				-> ${PN}-utils-${PV}-x86.tar.gz
		)
	)
"
S="${WORKDIR}"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~x86"
IUSE="+tools"
RESTRICT="strip test"

DEPEND="
	acct-group/victorialogs
	acct-user/victorialogs
"
RDEPEND="
	${DEPEND}
	!app-admin/victorialogs
"
BDEPEND="
	acct-group/victorialogs
	acct-user/victorialogs
"

QA_PREBUILT="
	usr/bin/victorialogs
	usr/bin/victoria-logs
	usr/bin/vlagent
	usr/bin/vlogscli
"

src_compile() {
	:
}

src_install() {
	newbin victoria-logs-prod victorialogs
	dosym victorialogs /usr/bin/victoria-logs
	pax-mark m "${ED}"/usr/bin/victorialogs

	if use tools; then
		if [[ -f "${WORKDIR}/vlagent-prod" ]]; then
			newbin vlagent-prod vlagent
			pax-mark m "${ED}"/usr/bin/vlagent
		fi
		if [[ -f "${WORKDIR}/vlogscli-prod" ]]; then
			newbin vlogscli-prod vlogscli
			pax-mark m "${ED}"/usr/bin/vlogscli
		fi
	fi

	newinitd "${FILESDIR}"/victorialogs.initd victorialogs
	newconfd "${FILESDIR}"/victorialogs.confd victorialogs

	systemd_dounit "${FILESDIR}"/victorialogs.service

	insinto /etc/default
	newins "${FILESDIR}"/victorialogs.default victorialogs

	keepdir /var/lib/victorialogs
	fowners victorialogs:victorialogs /var/lib/victorialogs
	fperms 0750 /var/lib/victorialogs

	keepdir /var/log/victorialogs
	fowners victorialogs:victorialogs /var/log/victorialogs
	fperms 0755 /var/log/victorialogs
}

pkg_postinst() {
	if [[ -z "${REPLACING_VERSIONS}" ]]; then
		elog "VictoriaLogs data directory is located at:"
		elog "  ${EROOT}/var/lib/victorialogs"
		elog "Default listen address is :9428 (http://localhost:9428/)"
		elog "Configuration options can be adjusted in:"
		elog "  ${EROOT}/etc/conf.d/victorialogs (OpenRC)"
		elog "  ${EROOT}/etc/default/victorialogs (systemd)"
	fi
}
