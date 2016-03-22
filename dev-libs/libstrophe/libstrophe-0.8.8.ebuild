# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

inherit autotools

DESCRIPTION="A simple, lightweight C library for writing XMPP clients"
HOMEPAGE="http://strophe.im/libstrophe/"
SRC_URI="https://github.com/strophe/${PN}/archive/${PV}.tar.gz"

LICENSE="MIT GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc xml"

RDEPEND="xml? ( dev-libs/libxml2 )
		!xml? ( dev-libs/expat )
		dev-libs/openssl:0"
DEPEND="${RDEPEND}
		doc? ( app-doc/doxygen )"

src_prepare() {
		default
		eautoreconf
}

src_configure() {
		if use xml; then
			# defaults to expat otherwise
			econf $(use_with xml libxml2)
		else
			econf
		fi
}
src_compile() {
		emake
		use doc && doxygen
}

src_install() {
		emake DESTDIR="${D}" install
		use doc && dodoc -r docs/html
}
