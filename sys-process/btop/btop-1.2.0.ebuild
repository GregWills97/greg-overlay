# Copyright 2020-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Linux/OSX/FreeBSD resource monitor"
HOMEPAGE="https://github.com/aristocratos/btop"

if [[ ${PV} == "9999" ]] ; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/aristocratos/btop.git"
else
	SRC_URI="https://github.com/aristocratos/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
fi

LICENSE="Apache-2.0"
SLOT="0"

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND="
	>=sys-devel/gcc-10
"

src_prepare() {
	default
	# btop installs README.md to /usr/share/btop by default
	sed -i 's^.*cp -p README.md. *$//' Makefile
}

src_compile() {
	#Disable btop optimization flags
	emake OPTFLAGS=""
}

src_install() {
	emake DESTDIR="${D}" PREFIX="${EPREFIX}/usr" install
    dodoc README.md CHANGELOG.md
}
