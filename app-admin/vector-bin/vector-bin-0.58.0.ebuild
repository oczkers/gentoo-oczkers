# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit pax-utils systemd

MY_PN="vector"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="High-performance observability data pipeline (pre-built binary)"
HOMEPAGE="https://vector.dev https://github.com/vectordotdev/vector"
SRC_URI="
	amd64? (
		https://github.com/vectordotdev/vector/releases/download/v${PV}/${MY_P}-x86_64-unknown-linux-musl.tar.gz
	)
	arm64? (
		https://github.com/vectordotdev/vector/releases/download/v${PV}/${MY_P}-aarch64-unknown-linux-musl.tar.gz
	)
"
S="${WORKDIR}/${MY_P}"

LICENSE="MPL-2.0"
SLOT="0"
KEYWORDS="~amd64 ~arm64"
RESTRICT="strip test"

DEPEND="
	acct-group/vector
	acct-user/vector
"
RDEPEND="
	${DEPEND}
	!app-admin/vector
"
BDEPEND="
	acct-group/vector
	acct-user/vector
"

QA_PREBUILT="usr/bin/vector"

src_unpack() {
	default
	local dir=( "${WORKDIR}"/vector-*-unknown-linux-musl )
	if [[ -d "${dir[0]}" ]]; then
		mv "${dir[0]}" "${S}" || die
	fi
}

src_compile() {
	:
}

src_install() {
	dobin bin/vector
	pax-mark m "${ED}"/usr/bin/vector

	insinto /etc/vector
	doins config/vector.yaml

	insinto /usr/share/vector/examples
	doins -r config/examples/.

	systemd_dounit etc/systemd/vector.service

	insinto /etc/default
	newins etc/systemd/vector.default vector

	newinitd "${FILESDIR}"/vector.initd vector
	newconfd "${FILESDIR}"/vector.confd vector

	keepdir /var/lib/vector
	fowners vector:vector /var/lib/vector
	fperms 0750 /var/lib/vector

	keepdir /var/log/vector
	fowners vector:vector /var/log/vector
	fperms 0755 /var/log/vector

	dodoc README.md NOTICE
}

pkg_postinst() {
	if [[ -z "${REPLACING_VERSIONS}" ]]; then
		elog "A default configuration file has been installed to:"
		elog "  ${EROOT}/etc/vector/vector.yaml"
		elog "Data directory is located at:"
		elog "  ${EROOT}/var/lib/vector"
		elog "Example configurations are in:"
		elog "  ${EROOT}/usr/share/vector/examples"
	fi
}
