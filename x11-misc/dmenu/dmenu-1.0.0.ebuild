# Copyright 2020-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Greg's fork of Suckless's application launcher, dmenu"
HOMEPAGE="https://github.com/GregWills97/${PN}"
SRC_URI="https://github.com/GregWills97/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="xinerama"

RDEPEND="media-libs/fontconfig
         x11-libs/libX11
         x11-libs/libXft
         xinerama? ( x11-libs/libXinerama )
"
DEPEND="${RDEPEND} x11-base/xorg-proto"
BDEPEND="virtual/pkgconfig"

src_compile() {
	emake || die "emake compile failed"
}

src_install() {
	emake DESTDIR="${D}" PREFIX="${EPREFIX}/usr" install
}
