# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="The gde desktop environment meta package"
HOMEPAGE="https://github.com/GregWills97/dwm"
SRC_URI=""

LICENSE="metapackage"
SLOT="0"
KEYWORDS="amd64"
IUSE="bluetooth elogind pulseaudio systemd"

REQUIRED_USE="
	^^ ( elogind systemd )
"

RDEPEND="
	app-admin/pass
	app-arch/p7zip
	app-arch/xarchiver
	app-crypt/gnupg
	app-editors/neovim
	app-misc/lf
	app-text/tree
	app-text/zathura
	app-text/zathura-meta
	dev-util/geany
	dev-vcs/git
	lxde-base/lxappearance
	media-fonts/cantarell
	media-fonts/corefonts
	media-fonts/courier-prime
	media-fonts/font-bitstream-100dpi
	media-fonts/liberation-fonts
	media-fonts/nerd-fonts[mononoki,noto,ubuntu,ubuntumono]
	media-gfx/scrot
	media-gfx/sxiv
	media-gfx/ueberzug
	sys-apps/exa
	sys-apps/lm-sensors
	sys-apps/pciutils
	sys-apps/usbutils
	sys-process/btop
	www-client/brave-bin
	x11-apps/mesa-progs
	x11-apps/setxkbmap
	x11-apps/xev
	x11-apps/xkill
	x11-apps/xsetroot
	x11-base/xorg-server
	=x11-misc/dmenu-${PV}
	x11-misc/dunst
	x11-misc/nitrogen
	x11-misc/pcmanfm
	x11-misc/picom
	x11-misc/sddm
	=x11-terms/st-${PV}
	x11-themes/dt-wallpapers
	=x11-wm/dwm-${PV}
	bluetooth? (
		net-wireless/bluez
		net-wireles/blueman
	)
	elogind? ( sys-auth/elogind )
	pulseaudio? ( media-sound/pavucontrol )
"
