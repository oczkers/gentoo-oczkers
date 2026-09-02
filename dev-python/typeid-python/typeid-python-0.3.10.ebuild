# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_EXT=1
DISTUTILS_USE_PEP517=maturin
PYTHON_COMPAT=( python3_{11..14} )

CRATES="
	autocfg@1.5.0
	heck@0.5.0
	indoc@2.0.7
	libc@0.2.178
	memoffset@0.9.1
	once_cell@1.21.3
	portable-atomic@1.13.0
	proc-macro2@1.0.104
	pyo3-build-config@0.27.2
	pyo3-ffi@0.27.2
	pyo3-macros-backend@0.27.2
	pyo3-macros@0.27.2
	pyo3@0.27.2
	quote@1.0.42
	rustversion@1.0.22
	syn@2.0.112
	target-lexicon@0.13.4
	unicode-ident@1.0.22
	unindent@0.2.4
"

inherit cargo distutils-r1 pypi

DESCRIPTION="Python implementation of TypeIDs: type-safe, K-sortable, globally unique identifiers"
HOMEPAGE="
	https://github.com/akhundMurad/typeid-python/
	https://pypi.org/project/typeid-python/
"
SRC_URI+="
	${CARGO_CRATE_URIS}
"

LICENSE="MIT"
# Dependent crate licenses
LICENSE+=" Apache-2.0-with-LLVM-exceptions Unicode-3.0"
SLOT="0"
KEYWORDS="~amd64 ~arm64 ~x86"
IUSE="cli yaml"

RDEPEND="
	>=dev-python/uuid-utils-0.12.0[${PYTHON_USEDEP}]
	cli? ( dev-python/click[${PYTHON_USEDEP}] )
	yaml? ( dev-python/pyyaml[${PYTHON_USEDEP}] )
"

QA_FLAGS_IGNORED="usr/lib.*/py.*/site-packages/typeid/_base32.*.so"

src_prepare() {
	distutils-r1_src_prepare

	# Prevent stray LICENSE and README.md from being installed into site-packages
	sed -i -e '/include = /d' pyproject.toml || die
}
