# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit desktop

DESCRIPTION="An open-world game whose gameplay revolves around breaking and placing blocks"
HOMEPAGE="https://www.minecraft.net/"
SRC_URI="https://launcher.mojang.com/download/Minecraft.tar.gz
	     https://launcher.mojang.com/download/minecraft-launcher.svg"

LICENSE="Mojang"
SLOT="0"

RESTRICT="bindist mirror"

RDEPEND="virtual/jre:1.8"

S="${WORKDIR}/${PN}"

src_install() {
	dobin ${PN}

	newicon -s scalable "${DISTDIR}/${PN}.svg" "${PN}.svg"
	make_desktop_entry ${PN} "Minecraft" ${PN} Game
}
