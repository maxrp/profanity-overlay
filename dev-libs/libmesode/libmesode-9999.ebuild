# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

inherit autotools git-r3

DESCRIPTION="A simple, lightweight C library for writing XMPP clients"
HOMEPAGE="https://github.com/boothj5/libmesode"
EGIT_REPO_URI="https://github.com/boothj5/libmesode.git git://github.com/boothj5/libmesode.git"

LICENSE="MIT GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc"

RDEPEND="dev-libs/expat
		 dev-libs/openssl:0"
DEPEND="${RDEPEND}
		doc? ( app-doc/doxygen )"

S="${WORKDIR}/${P}"

src_prepare() {
		default
		eautoreconf
}

src_compile() {
		emake
		use doc && doxygen
}

src_install() {
		emake DESTDIR="${D}" install
		dodoc LICENSE.txt README.markdown
		use doc && dodoc -r docs/html
}
