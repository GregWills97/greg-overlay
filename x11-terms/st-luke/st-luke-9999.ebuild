# Copyright 2020-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit git-r3

DESCRIPTION="Luke Smith's configuration of the simple terminal."
HOMEPAGE="https://github.com/LukeSmithxyz/st"
EGIT_REPO_URI="https://github.com/LukeSmithxyz/st.git"

KEYWORDS="~amd64"
LICENSE="MIT"
SLOT="0"

src_compile() {
	emake || die "emake compile failed"
}

src_install() {
	emake DESTDIR="${D}" install
}
