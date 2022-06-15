# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit go-module bash-completion-r1

EGO_SUM=(
	"github.com/gdamore/encoding v1.0.0"
	"github.com/gdamore/encoding v1.0.0/go.mod"
	"github.com/gdamore/tcell/v2 v2.3.1"
	"github.com/gdamore/tcell/v2 v2.3.1/go.mod"
	"github.com/lucasb-eyer/go-colorful v1.0.3"
	"github.com/lucasb-eyer/go-colorful v1.0.3/go.mod"
	"github.com/mattn/go-runewidth v0.0.10"
	"github.com/mattn/go-runewidth v0.0.10/go.mod"
	"github.com/rivo/uniseg v0.1.0"
	"github.com/rivo/uniseg v0.1.0/go.mod"
	"golang.org/x/sys v0.0.0-20201119102817-f84b799fce68/go.mod"
	"golang.org/x/sys v0.0.0-20220209214540-3681064d5158"
	"golang.org/x/sys v0.0.0-20220209214540-3681064d5158/go.mod"
	"golang.org/x/term v0.0.0-20201210144234-2321bbc49cbf/go.mod"
	"golang.org/x/term v0.0.0-20210220032956-6a3ed077a48d"
	"golang.org/x/term v0.0.0-20210220032956-6a3ed077a48d/go.mod"
	"golang.org/x/text v0.3.0"
	"golang.org/x/text v0.3.0/go.mod"
	"gopkg.in/djherbis/times.v1 v1.2.0"
	"gopkg.in/djherbis/times.v1 v1.2.0/go.mod"
)

go-module_set_globals
SRC_URI="https://github.com/gokcehan/lf/archive/r${PV}.tar.gz -> ${P}.tar.gz
	${EGO_SUM_SRC_URI}"

DESCRIPTION="Terminal file manager"
HOMEPAGE="https://github.com/gokcehan/lf"
IUSE="+static X"

KEYWORDS="~amd64"
LICENSE="MIT"
SLOT="0"

S="${WORKDIR}/${PN}-r${PV}"

src_compile() {
	local ldflags="-s -w -X main.gVersion=r${PV}"

	if use static; then
		export CGO_ENABLED=0
		ldflags+=' -extldflags "-static"'
	fi

	ego build -ldflags="${ldflags}" || die 'go build failed'
}

src_install() {

	#Install Binary and Man Page
	dobin "${PN}"
	doman "${PN}.1"

	# bash-completion
	newbashcomp "etc/${PN}.bash" "${PN}"

	if use X; then
		insinto /usr/share/applications
		doins "${PN}.desktop"
	fi
}
