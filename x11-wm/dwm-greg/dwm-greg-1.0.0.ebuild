# Copyright 2020-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Greg's custom configuration of Suckless's tiling window manager, DWM"
HOMEPAGE="https://github.com/GregWills97/${PN}"
SRC_URI="https://github.com/GregWills97/${PN}/archive/refs/tags/${PV}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="x11-misc/dmenu-greg x11-terms/st-luke"
DEPEND="${RDEPEND}"

src_prepare() {
	default
	restore_config config.h
}

src_compile() {
	emake || die "emake compile failed"
}

src_install() {
	emake DESTDIR="${D}" PREFIX="${EPREFIX}/usr" install

	#install scripts
	dodir /etc/dwm-greg
	exeinto /etc/dwm-greg
	doexe scripts/{autostart,dmenu_run}

	save_config config.h
}
