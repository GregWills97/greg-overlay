# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Various helper scripts for GDE Gentoo desktop"
HOMEPAGE="https://github.com/GregWills97/gde-scripts"

if [[ ${PV} == "9999" ]] ; then
    inherit git-r3
    EGIT_REPO_URI="https://github.com/GregWills97/${PN}.git"
else
    SRC_URI="https://github.com/GregWills97/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"
    KEYWORDS="amd64"
fi

LICENSE="GPL-3"
SLOT="0"

S=${WORKDIR}/${P}

src_install() {
    #Install scripts
    dobin gde-*

    #Install documentaton
    dodoc README.md
}
