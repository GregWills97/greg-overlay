EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..13} )

inherit distutils-r1 systemd

DESCRIPTION="Python daemon for controlling fans on AMDGPU cards"
HOMEPAGE="https://github.com/chestm007/amdgpu-fan"
SRC_URI="https://github.com/chestm007/amdgpu-fan/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND="
    dev-python/pyyaml[${PYTHON_USEDEP}]
	dev-python/numpy[${PYTHON_USEDEP}]
"

DEPEND="${RDEPEND}"

src_install() {
    distutils-r1_src_install

	newinitd "${FILESDIR}/amdgpu-fan.initd" ${PN}
	systemd_dounit "${S}/amdgpu-fan.service"
}

