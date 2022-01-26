# Copyright 2020-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit savedconfig toolchain-funcs

DESCRIPTION="Greg's fork of the simple terminal."
HOMEPAGE="https://github.com/GregWills97/st"

if [[ ${PV} == "9999" ]] ; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/GregWills97/st.git"
else
	SRC_URI="https://github.com/GregWills97/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
fi

LICENSE="MIT"
SLOT="0"

RDEPEND="
        >=sys-libs/ncurses-6.0:0=
        media-libs/fontconfig
        x11-libs/libX11
        x11-libs/libXft
"
DEPEND="
        ${RDEPEND}
        x11-base/xorg-proto
"
BDEPEND="virtual/pkgconfig"

src_prepare() {
	default

	# Create directory for terminfo
	mkdir -v terminfo || die "Failed to create terminfo"

	# Set appropriate lib/include paths
	sed -i \
		-e "/^X11LIB/{s:/usr/X11R6/lib:/usr/$(get_libdir)/X11:}" \
		-e '/^X11INC/{s:/usr/X11R6/include:/usr/include/X11:}' \
		config.mk || die

	# Remove terminfo from Makefile install
	sed -i \
		-e '/tic/d' \
		Makefile || die

	restore_config config.h
}

src_configure() {
	# Replace with appropriate pkg-config
	sed -i \
		-e "s|pkg-config|$(tc-getPKG_CONFIG)|g" \
		config.mk || die
}

src_compile() {
	emake CC=$(tc-getCC) st
	tic -sxo terminfo st.info || die "Failed to translate terminfo"
}

src_install() {
	emake DESTDIR="${D}" PREFIX="${EPREFIX}/usr" install

	#Install docs
	dodoc README.md

	# Install terminfo
	insinto /usr/share/${PN}
	doins -r terminfo

	newenvd - "51${PN}" <<-_EOF_
		TERMINFO_DIRS="/usr/share/${PN}/terminfo"
		COLON_SEPARATED="TERMINFO_DIRS"
	_EOF_

	save_config config.h
}
