# Copyright 2020-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit savedconfig

DESCRIPTION="Greg's custom fork of Suckless's tiling window manager, DWM"
HOMEPAGE="https://github.com/GregWills97/${PN}"

if [[ ${PV} == "9999" ]] ; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/GregWills97/${PN}.git"
else
	SRC_URI="https://github.com/GregWills97/${PN}/archive/refs/tags/${PV}.tar.gz"
	KEYWORDS="~amd64"
fi

LICENSE="MIT"
SLOT="0"
IUSE="xinerama"

RDEPEND="
        media-libs/fontconfig
        x11-libs/libX11
        x11-libs/libXft
        x11-misc/dmenu
        x11-terms/st-luke
"
DEPEND="
        ${RDEPEND}
        xinerama? ( x11-base/xorg-proto )
"

src_prepare() {
	default
	restore_config config.h
}

src_install() {
	emake DESTDIR="${D}" PREFIX="${EPREFIX}/usr" install

	#install scripts
	dodir /etc/dwm-greg
	exeinto /etc/dwm-greg
	doexe scripts/{autostart,dmenu_run}

	#Added Xsession desktop file
	insinto /usr/share/xsessions
	doins "${FILESDIR}"/dwm.desktop

	#Save user config
	save_config config.h
}
