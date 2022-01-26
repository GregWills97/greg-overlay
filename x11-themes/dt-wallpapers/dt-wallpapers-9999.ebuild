# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit git-r3

MY_PN=${PN/dt-//}

DESCRIPTION="Repository of wallpapers maintained by distrotube"
HOMEPAGE="https://gitlab.com/dwt1/wallpapers"
EGIT_REPO_URI="https://gitlab.com/dwt1/${MY_PN}.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

src_install() {
	insinto /usr/share/backgrounds/${PN}/

	doins *.jpg

	dodoc README.md
}
