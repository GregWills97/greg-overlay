# Copyright 2020-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

#Replace dash with underscore for correct src_uri
MY_P=${P/-/_}

DESCRIPTION="Displays ascii art aquarium"
HOMEPAGE="https://robobunny.com/projects/asciiquarium/html"
SRC_URI="https://robobunny.com/projects/asciiquarium/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND="dev-lang/perl
         dev-perl/Term-Animation[ncurses]"

BDEPEND="${RDEPEND}"

#Change source to reflect correct program name/version
S=${WORKDIR}/${MY_P}

src_install() {
	dodoc README CHANGES
	dobin asciiquarium
}
