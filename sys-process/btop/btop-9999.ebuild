# Copyright 2020-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit git-r3

DESCRIPTION="Linux/OSX/FreeBSD resource monitor"
HOMEPAGE="https://github.com/aristocratos/btop"
EGIT_REPO_URI="https://github.com/aristocratos/btop.git"

KEYWORDS="~amd64"
LICENSE="Apache-2.0"
SLOT="0"

src_compile() {
	emake || die "emake compile failed"
}

src_install() {
	emake DESTDIR="${D}" PREFIX="${EPREFIX}/usr" install
}
