# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

inherit autotools git-r3

DESCRIPTION="Ncurses based jabber client inspired by irssi"
HOMEPAGE="http://www.profanity.im/"
EGIT_REPO_URI="https://github.com/boothj5/profanity.git git://github.com/boothj5/profanity.git"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS=""
IUSE="libnotify otr pgp plugins +themes xscreensaver"

RDEPEND=">=dev-libs/glib-2.26
		dev-libs/libmesode
		net-misc/curl
		sys-libs/ncurses:0
		sys-libs/readline:0
		pgp? ( app-crypt/gpgme )
		otr? ( net-libs/libotr )
		xscreensaver? ( x11-libs/libXScrnSaver )
		libnotify? ( x11-libs/libnotify )"
DEPEND="${RDEPEND}"

S="${WORKDIR}/${P}"

src_prepare() {
		default
		eautoreconf
}

src_configure() {
		econf \
			$(use_enable plugins c-plugins) \
			$(use_enable libnotify notifications) \
			$(use_enable otr) \
			$(use_enable pgp) \
			$(use_enable plugins python-plugins) \
			$(use_with themes) \
			$(use_with xscreensaver)
}

pkg_postinst() {
		elog
		elog "User guide is available online:"
		elog "  http://www.profanity.im/userguide.html"
		elog
}
