# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Sugar Candy SDDM Theme"
HOMEPAGE="https://www.opencode.net/marianarlt/sddm-sugar-candy"
SRC_URI="https://www.opencode.net/marianarlt/sddm-sugar-candy/-/archive/master/sddm-sugar-candy-master.tar.gz"

MY_PN=${PN/-theme/}-master

LICENSE="GPL-3"
SLOT="0"
IUSE=""

RDEPEND="x11-misc/sddm
		 dev-qt/qtquickcontrols2
		 dev-qt/qtgraphicaleffects
		 dev-qt/qtsvg"

S=${WORKDIR}/${MY_PN}

src_install() {
	dodir /usr/share/sddm/themes/sugar-candy
	insinto /usr/share/sddm/themes/sugar-candy
	doins -r $S/*
}
