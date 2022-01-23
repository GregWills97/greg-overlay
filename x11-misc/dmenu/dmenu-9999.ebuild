# Copyright 2020-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit toolchain-funcs

DESCRIPTION="Greg's fork of Suckless's application launcher, dmenu"
HOMEPAGE="https://github.com/GregWills97/${PN}"

if [[ ${PV} == "9999" ]] ; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/GregWills97/${PN}.git"
else
	SRC_URI="https://github.com/GregWills97/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
fi

LICENSE="MIT"
SLOT="0"
IUSE="xinerama"

RDEPEND="media-libs/fontconfig
         x11-libs/libX11
         x11-libs/libXft
         xinerama? ( x11-libs/libXinerama )
"
DEPEND="${RDEPEND} x11-base/xorg-proto"
BDEPEND="virtual/pkgconfig"

src_prepare() {
	default
    # We need to remove optimization, change = to += for flags
    # and set appropriate lib and include path
    sed -i \
        -e "s/ -Os / /" \
        -e "/^\(LDFLAGS\|CFLAGS\|CPPFLAGS\)/{s| = | += |g;s|-s ||g}" \
        -e '/^INCS/{s:-I$(X11INC) -I$(FREETYPEINC):$(X11INC) $(FREETYPEINC):}' \
        -e '/^LIBS/{s:-L$(X11LIB) -lX11 $(XINERAMALIBS) $(FREETYPELIBS):$(X11LIB) $(XINERAMALIBS) $(FREETYPELIBS):}' \
		-e "/^X11LIB/{s:/usr/X11R6/lib:/usr/$(get_libdir)/X11:}" \
        -e '/^X11INC/{s:/usr/X11R6/include:/usr/include/X11:}' \
        config.mk || die

	sed -i \
		-e 's|^	@|	|g' \
		-e '/^	echo/d' \
		Makefile || die
}

src_compile() {
	#Set CC variable, disable xinerama if needed
	emake CC=$(tc-getCC) \
		"FREETYPEINC=$( $(tc-getPKG_CONFIG) --cflags x11 fontconfig xft 2>/dev/null )" \
		"FREETYPELIBS=$( $(tc-getPKG_CONFIG) --libs x11 fontconfig xft 2>/dev/null )" \
		"X11INC=$( $(tc-getPKG_CONFIG) --cflags x11 2>/dev/null )" \
		"X11LIB=$( $(tc-getPKG_CONFIG) --libs x11 2>/dev/null )" \

		"XINERAMAFLAGS=$(
			usex xinerama "-DXINERAMA $(
				$(tc-getPKG_CONFIG) --cflags xinerama 2>/dev/null
			)" ''
		)" \
		"XINERAMALIBS=$(
			usex xinerama "$( $(tc-getPKG_CONFIG) --libs xinerama 2>/dev/null)" ''
		)"
}

src_install() {
	emake DESTDIR="${D}" PREFIX="${EPREFIX}/usr" install
}
