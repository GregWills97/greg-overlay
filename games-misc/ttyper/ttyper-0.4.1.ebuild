# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CRATES="
	ansi_term-0.12.1
	atty-0.2.14
	bitflags-1.3.2
	block-buffer-0.9.0
	cassowary-0.3.0
	cfg-if-1.0.0
	clap-2.34.0
	cpufeatures-0.2.1
	crossterm-0.20.0
	crossterm-0.22.1
	crossterm_winapi-0.8.0
	crossterm_winapi-0.9.0
	digest-0.9.0
	dirs-4.0.0
	dirs-sys-0.3.6
	generic-array-0.14.5
	getrandom-0.2.4
	heck-0.3.3
	hermit-abi-0.1.19
	instant-0.1.12
	lazy_static-1.4.0
	libc-0.2.113
	lock_api-0.4.5
	log-0.4.14
	mio-0.7.14
	miow-0.3.7
	ntapi-0.3.6
	opaque-debug-0.3.0
	parking_lot-0.11.2
	parking_lot_core-0.8.5
	ppv-lite86-0.2.16
	proc-macro-error-1.0.4
	proc-macro-error-attr-1.0.4
	proc-macro2-1.0.36
	quote-1.0.14
	rand-0.8.4
	rand_chacha-0.3.1
	rand_core-0.6.3
	rand_hc-0.3.1
	redox_syscall-0.2.10
	redox_users-0.4.0
	rust-embed-6.3.0
	rust-embed-impl-6.2.0
	rust-embed-utils-7.1.0
	same-file-1.0.6
	scopeguard-1.1.0
	sha2-0.9.9
	signal-hook-0.3.13
	signal-hook-mio-0.2.1
	signal-hook-registry-1.4.0
	smallvec-1.8.0
	strsim-0.8.0
	structopt-0.3.26
	structopt-derive-0.4.18
	syn-1.0.86
	textwrap-0.11.0
	tui-0.16.0
	typenum-1.15.0
	unicode-segmentation-1.8.0
	unicode-width-0.1.9
	unicode-xid-0.2.2
	vec_map-0.8.2
	version_check-0.9.4
	walkdir-2.3.2
	wasi-0.10.2+wasi-snapshot-preview1
	winapi-0.3.9
	winapi-i686-pc-windows-gnu-0.4.0
	winapi-util-0.1.5
	winapi-x86_64-pc-windows-gnu-0.4.0
"

inherit cargo

DESCRIPTION="Terminal-based typing test."
HOMEPAGE="https://github.com/max-niederman/ttyper.git"

if [[ ${PV} == "9999" ]] ; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/max-niederman/ttyper.git"
else
	SRC_URI="https://github.com/max-niederman/ttyper/archive/v${PV}.tar.gz -> ${P}.tar.gz
	        $(cargo_crate_uris)"
	KEYWORDS="amd64"
fi

LICENSE="Apache-2.0 Apache-2.0-with-LLVM-exceptions BSD MIT Unlicense"
SLOT="0"
IUSE=""

src_unpack() {
	if [[ ${PV} == "9999" ]] ; then
		git-r3_src_unpack
		cargo_live_src_unpack
	else
		cargo_src_unpack
	fi
}

src_install() {
	cargo_src_install

	dodoc README.md
}
