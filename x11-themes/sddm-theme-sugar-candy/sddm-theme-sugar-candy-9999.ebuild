# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Some nice eucalyptus-y eye-candy for SDDM!"
HOMEPAGE="https://gitlab.com/Matt.Jolly/sddm-eucalyptus-drop/"
SRC_URI="https://gitlab.com/Matt.Jolly/sddm-eucalyptus-drop/-/archive/master/sddm-eucalyptus-drop-master.tar.gz"

MY_PN=${PN/-theme-sugar-candy/-eucalyptus-drop}-master

LICENSE="GPL-3"
SLOT="0"
IUSE=""

RDEPEND="x11-misc/sddm
		 dev-qt/qt5compat[qml]
		 dev-qt/qtgraphicaleffects
		 dev-qt/qtquickcontrols2
		 dev-qt/qtgraphicaleffects
		 dev-qt/qtsvg"

S=${WORKDIR}/${MY_PN}

src_install() {
	dodir /usr/share/sddm/themes/sugar-candy
	insinto /usr/share/sddm/themes/sugar-candy
	doins -r $S/*
}
