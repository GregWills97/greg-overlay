# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit git-r3

DESCRIPTION="DT's multicolor sddm theme"
HOMEPAGE="https://gitlab.com/dwt1/multicolor-sddm-theme"
EGIT_REPO_URI="https://gitlab.com/dwt1/multicolor-sddm-theme.git"

LICENSE="GPL-3"
SLOT="0"
IUSE=""

RDEPEND="x11-misc/sddm"

src_install() {
	dodir /usr/share/sddm/themes/multicolor-sddm-theme
	insinto /usr/share/sddm/themes/multicolor-sddm-theme
	doins -r $S/*
}
