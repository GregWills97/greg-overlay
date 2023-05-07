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
	|| ( pulseaudio )
"

RDEPEND="
	app-admin/pass
	app-arch/p7zip
	app-arch/xarchiver
	app-crypt/gnupg
	app-editors/neovim
	app-misc/lf
	app-misc/neofetch
	app-text/tree
	app-text/zathura
	app-text/zathura-meta
	dev-vcs/git
	gui-libs/display-manager-init
	lxde-base/lxappearance
	media-fonts/corefonts
	media-fonts/courier-prime
	media-fonts/font-bitstream-100dpi
	media-fonts/liberation-fonts
	media-fonts/nerd-fonts[mononoki,ubuntu]
	media-gfx/scrot
	media-gfx/sxiv
	media-gfx/ueberzug
	media-sound/pavucontrol
	media-sound/playerctl
	sys-apps/exa
	sys-apps/lm-sensors
	sys-apps/pciutils
	sys-apps/usbutils
	sys-power/acpilight
	sys-process/btop
	www-client/brave-bin
	x11-apps/mesa-progs
	x11-apps/setxkbmap
	x11-apps/xkill
	x11-apps/xsetroot
	x11-base/xorg-drivers
	x11-base/xorg-server
	>=x11-misc/dmenu-${PV}
	>=x11-misc/dwmblocks-${PV}
	x11-misc/dunst
	x11-misc/nitrogen
	x11-misc/pcmanfm
	x11-misc/picom
	x11-misc/sddm
	>=x11-terms/st-${PV}
	x11-themes/dt-wallpapers
	x11-themes/sddm-theme-sugar-candy
	>=x11-wm/dwm-${PV}
	bluetooth? (
		net-wireless/bluez
		net-wireless/blueman
	)
	elogind? ( sys-auth/elogind )
"
