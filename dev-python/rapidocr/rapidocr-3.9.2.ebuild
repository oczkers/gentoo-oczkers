# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=standalone
PYTHON_COMPAT=( python3_{11..14} )

inherit distutils-r1 optfeature pypi

DESCRIPTION="Awesome OCR Library"
HOMEPAGE="
	https://github.com/RapidAI/RapidOCR
	https://rapidai.github.io/RapidOCRDocs
	https://pypi.org/project/rapidocr/
"
SRC_URI="$(pypi_wheel_url)"
S="${WORKDIR}"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~arm64 ~x86"
IUSE="+onnx"

RDEPEND="
	>=dev-python/pyclipper-1.2.0[${PYTHON_USEDEP}]
	media-libs/opencv[python,${PYTHON_USEDEP}]
	dev-python/numpy[${PYTHON_USEDEP}]
	>=dev-python/six-1.15.0[${PYTHON_USEDEP}]
	>=dev-python/shapely-1.7.1[${PYTHON_USEDEP}]
	dev-python/pyyaml[${PYTHON_USEDEP}]
	dev-python/pillow[${PYTHON_USEDEP}]
	dev-python/tqdm[${PYTHON_USEDEP}]
	>=dev-python/omegaconf-2.3.0[${PYTHON_USEDEP}]
	dev-python/requests[${PYTHON_USEDEP}]
	dev-python/colorlog[${PYTHON_USEDEP}]
	onnx? ( sci-libs/onnxruntime[python,${PYTHON_USEDEP}] )
"
BDEPEND="
	app-arch/unzip
"

python_compile() {
	distutils_wheel_install "${BUILD_DIR}/install" \
		"${DISTDIR}/$(pypi_wheel_name)"
}

pkg_postinst() {
	optfeature "ONNX Runtime inference engine" "sci-libs/onnxruntime[python]"
	optfeature "OpenVINO inference engine" "sci-libs/openvino[python]"
}
