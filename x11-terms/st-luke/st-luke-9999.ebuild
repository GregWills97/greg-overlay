# Copyright 2020-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Luke Smith's configuration of the simple terminal."
HOMEPAGE="https://github.com/LukeSmithxyz/st"

if [[ ${PV} == *9999* ]] ; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/LukeSmithxyz/st.git"
else
	SRC_URI="https://github.com/LukeSmithxyz/st/archive/${PV}.tar.gz -> ${P}.tar.gz"
	KEY_WORDS="amd64"
fi

LICENSE="MIT"
SLOT="0"

RDEPEND="x11-misc/dmenu-greg"
DEPEND="${RDEPEND}"

src_compile() {
	emake || die "emake compile failed"
}

src_install() {
	emake DESTDIR="${D}" install
}
