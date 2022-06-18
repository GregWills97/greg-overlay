# Copyright 2019-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit font check-reqs

FONTS=(
	3270
	Agave
	AnonymousPro
	Arimo
	AurulentSansMono
	BigBlueTerminal
	BitstreamVeraSansMono
	CascadiaCode
	CodeNewRoman
	Cousine
	DaddyTimeMono
	DejaVuSansMono
	DroidSansMono
	FantasqueSansMono
	FiraCode
	FiraMono
	Go-Mono
	Gohu
	Hack
	Hasklig
	HeavyData
	Hermit
	iA-Writer
	Inconsolata
	InconsolataGo
	InconsolataLGC
	Iosevka
	JetBrainsMono
	Lekton
	LiberationMono
	Meslo
	Monofur
	Monoid
	Mononoki
	MPlus
	Noto
	OpenDyslexic
	Overpass
	ProFont
	ProggyClean
	RobotoMono
	ShareTechMono
	SourceCodePro
	SpaceMono
	Terminus
	Tinos
	Ubuntu
	UbuntuMono
	VictorMono
)

DESCRIPTION="Collection of fonts that are patched to include a high number of glyphs (icons)."
HOMEPAGE="https://nerdfonts.com"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64"

IUSE_FONTS=(${FONTS[*],,})
IUSE="${IUSE_FONTS[*]}"
REQUIRED_USE="|| ( ${IUSE_FONTS[*]} )"

RDEPEND="media-libs/fontconfig"

CHECKREQS_DISK_BUILD="3G"
CHECKREQS_DISK_USR="4G"

#Source is dependent on what fonts user wants represented by local use flags
SRC_URI=""
for i in "${!IUSE_FONTS[@]}"
do
	SRC_URI+="${IUSE_FONTS[${i}]}? ( https://github.com/ryanoasis/${PN}/releases/download/v${PV}/${FONTS[${i}]}.zip ) "
done


S="${WORKDIR}"

FONT_CONF=(
	${FILESDIR}/10-nerd-font-symbols.conf
)

pkg_pretend() {
	check-reqs_pkg_setup
}

src_unpack() {
	for i in "${!IUSE_FONTS[@]}"
	do
		use ${IUSE_FONTS[${i}]} && unpack ${FONTS[${i}]}.zip
	done

	#Remove all Windows fonts
	find ${S}/ -name "*Windows Compatible*" -exec rm -f {} +
}

src_install() {
	declare -A font_filetypes
	local num_ttf, num_otf

	num_ttf=$(ls ${S} | grep -i ttf | wc -l)
	num_otf=$(ls ${S} | grep -i otf | wc -l)

	if [[ ${num_otf} != 0 ]]; then
		font_filetypes[otf]=
	fi
	if [[ ${num_ttf} != 0 ]]; then
		font_filetypes[ttf]=
	fi

	#Install both ttf and otf fonts
	FONT_SUFFIX="${!font_filetypes[@]}"
	font_src_install
}
