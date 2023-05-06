# Copyright 2020-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit savedconfig toolchain-funcs

MY_PN=${PN/gde-/}
MY_P=${MY_PN}-${PV}

DESCRIPTION="Greg's custom fork of Suckless's tiling window manager, DWM"
HOMEPAGE="https://github.com/GregWills97/${MY_PN}"

if [[ ${PV} == "9999" ]] ; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/GregWills97/${MY_PN}.git"
else
	SRC_URI="https://github.com/GregWills97/${MY_PN}/archive/${PV}.tar.gz -> ${MY_P}.tar.gz"
	KEYWORDS="amd64"
fi


LICENSE="MIT"
SLOT="0"
IUSE="xinerama"

RDEPEND="
        media-fonts/fontawesome
        media-fonts/joypixels
        media-libs/fontconfig
        x11-libs/libX11
        x11-libs/libxcb
        x11-libs/libXft
        x11-libs/libXpm
        x11-libs/libXrender
"
DEPEND="
        ${RDEPEND}
        xinerama? ( x11-base/xorg-proto )
"

S=${WORKDIR}/${MY_P}

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

	#install icons
	dodir /usr/share/icons/gde
	insinto /usr/share/icons/gde
	doins icons/*

	#Added Xsession desktop file
	insinto /usr/share/xsessions
	doins "${FILESDIR}"/${PN}.desktop

	#Install documentaton
	dodoc README.md
	doman ${MY_PN}.1

	#Save user config
	save_config config.h
}
