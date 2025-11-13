# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..14} )

inherit distutils-r1 pypi

DESCRIPTION="Scrapling is an undetectable, powerful, flexible, high-performance Python library that makes Web Scraping easy and effortless as it should be!"
HOMEPAGE="
	https://github.com/D4Vinci/Scrapling/
	https://pypi.org/project/scrapling/
"

LICENSE="|| ( MIT )"
SLOT="0"
KEYWORDS="amd64 ~arm64 x86"
# tests need root access
RESTRICT="test"

BDEPEND="
	dev-python/cssselect[${PYTHON_USEDEP}]
	dev-python/orjson[${PYTHON_USEDEP}]
	dev-python/lxml[${PYTHON_USEDEP}]
	dev-python/tldextract[${PYTHON_USEDEP}]
	dev-python/click[${PYTHON_USEDEP}]
	dev-python/curl-cffi[${PYTHON_USEDEP}]
	dev-python/msgspec[${PYTHON_USEDEP}]
"
