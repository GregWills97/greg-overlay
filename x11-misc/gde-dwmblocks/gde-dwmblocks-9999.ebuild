# Copyright 2020-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit savedconfig toolchain-funcs

MY_PN=${PN/gde-/}
MY_P=${MY_PN}-${PV}

DESCRIPTION="Custom fork of dwmblocks, a status text setter program"
HOMEPAGE="https://github.com/GregWills97/${MY_PN}"

if [[ ${PV} == "9999" ]] ; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/GregWills97/${MY_PN}.git"
else
	SRC_URI="https://github.com/GregWills97/${MY_PN}/archive/${PV}.tar.gz -> ${MY_P}.tar.gz"
	KEYWORDS="amd64"
fi


LICENSE="ISC"
SLOT="0"

RDEPEND="
        media-fonts/fontawesome
        media-fonts/joypixels
        x11-libs/libX11
"
DEPEND="${RDEPEND}"

S=${WORKDIR}/${MY_P}

src_prepare() {
	default
	# We need to remove optimization, change = to += for flags
	sed -i \
		-e "s/ -Os / /" \
		-e "/^\(LDFLAGS\|CFLAGS\|CPPFLAGS\)/s| = | += |g" \
		Makefile || die

	restore_config blocks.h
}

src_compile() {
	#Set CC variable
	emake CC=$(tc-getCC) dwmblocks
}

src_install() {
	emake DESTDIR="${D}" PREFIX="${EPREFIX}/usr" install

	#Install modules
	dobin modules/*

	#Install documentaton
	dodoc README.md

	#Save user config
	save_config blocks.h
}
