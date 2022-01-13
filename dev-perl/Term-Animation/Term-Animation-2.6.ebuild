# Copyright 2020-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DIST_AUTHOR=KBAUCOM
DIST_VERSION=2.6
inherit perl-module

DESCRIPTION="Animated ASCII Art support for Perl"

SLOT="0"
KEYWORDS="~amd64"
IUSE="ncurses"

RDEPEND="ncurses? ( dev-perl/Curses )"
DEPEND="${RDEPEND}"
