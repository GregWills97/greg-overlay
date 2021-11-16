# Copyright 2020-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit git-r3

DESCRIPTION="Greg's custom fork of Suckless's tiling window manager, DWM"
HOMEPAGE="https://github.com/GregWills97/${PN}"
EGIT_REPO_URI="https://github.com/GregWills97/dwm-greg.git"

KEYWORDS="~amd64"
LICENSE="MIT"
SLOT="0"

RDEPEND="x11-misc/dmenu-greg x11-terms/st-luke"

src_compile() {
	emake || die "emake compile failed"
}

src_install() {
	dodir /etc/dwm-greg
	exeinto /etc/dwm-greg
	doexe scripts/{autostart,dmenu_run}
	emake DESTDIR="${D}" PREFIX="${EPREFIX}/usr" install
}
