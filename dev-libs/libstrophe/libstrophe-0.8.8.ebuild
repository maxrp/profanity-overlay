# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit autotools eutils

DESCRIPTION="A simple, lightweight C library for writing XMPP clients"
HOMEPAGE="http://strophe.im/libstrophe/"
SRC_URI="https://github.com/strophe/${PN}/archive/${PV}.tar.gz"

LICENSE="MIT GPL-3"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="doc xml"

RDEPEND="xml? ( dev-libs/libxml2 )
		!xml? ( dev-libs/expat )
		dev-libs/openssl:0"
DEPEND="${RDEPEND}
		doc? ( app-doc/doxygen )"

src_prepare() {
		eautoreconf
}

src_configure() {
		use xml && econf $(use_with xml libxml2)
		# workaround for building with expat support
		use xml || econf
}

src_install() {
		emake DESTDIR="${D}" install
		if use doc; then
			doxygen || die
		fi
		use doc && dohtml -r docs/html/*
}
