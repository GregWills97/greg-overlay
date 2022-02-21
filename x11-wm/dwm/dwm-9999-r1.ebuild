# Copyright 2020-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit savedconfig toolchain-funcs

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
        x11-terms/st
"
DEPEND="
        ${RDEPEND}
        xinerama? ( x11-base/xorg-proto )
"

src_prepare() {
	default
	# We need to remove optimization, change = to += for flags
	# and set appropriate lib and include path
	sed -i \
		-e "s/ -Os / /" \
		-e "/^\(LDFLAGS\|CFLAGS\|CPPFLAGS\)/s| = | += |g" \
		-e "/^X11LIB/{s:/usr/X11R6/lib:/usr/$(get_libdir)/X11:}" \
		-e '/^X11INC/{s:/usr/X11R6/include:/usr/include/X11:}' \
		config.mk || die

	restore_config config.h
}

src_compile() {
	#Set CC variable, disable xinerama if needed
	if use xinerama; then
		emake CC=$(tc-getCC) dwm
	else
		emake CC=$(tc-getCC) XINERAMAFLAGS="" XINERAMALIBS="" dwm
	fi
}

src_install() {
	emake DESTDIR="${D}" PREFIX="${EPREFIX}/usr" install

	#install scripts
	dodir /etc/dwm-greg
	exeinto /etc/dwm-greg
	doexe scripts/{autostart,dmenu_run,session-manager}

	#Added Xsession desktop file
	insinto /usr/share/xsessions
	doins "${FILESDIR}"/dwm.desktop

	#Install documentaton
	dodoc README

	#Save user config
	save_config config.h
}
