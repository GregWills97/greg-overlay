# Copyright 2020-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit git-r3

DESCRIPTION="Greg's custom fork of Suckless's tiling window manager, DWM"
HOMEPAGE="https://github.com/GregWills97/${PN}"
EGIT_REPO_URI="https://github.com/GregWills97/dmenu-greg.git"

KEYWORDS="~amd64"
LICENSE="MIT"
SLOT="0"
IUSE="xinerama"

RDEPEND="!!x11-misc/dmenu
         media-libs/fontconfig
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

