# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: 

inherit eutils

DESCRIPTION="Script that launches netscape, mozilla or firefox"
HOMEPAGE="http://dev.gentoo.org/~agriffis/dist/"
SRC_URI="mirror://gentoo/${PN}-1.56.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 sparc x86 ~x86-fbsd"
IUSE=""

DEPEND=""
RDEPEND="x11-apps/xdpyinfo"

S=${WORKDIR}

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/netscape.patch
}

src_install() {
	exeinto /usr/libexec
	newexe ${PN}-1.56 mozilla-launcher || die
}

pkg_postinst() {
	local f

	find ${ROOT}/usr/bin -maxdepth 1 -type l | \
	while read f; do
		[[ $(readlink ${f}) == mozilla-launcher ]] || continue
		einfo "Updating ${f} symlink to /usr/libexec/mozilla-launcher"
		ln -sfn /usr/libexec/mozilla-launcher ${f}
	done
}

pkg_postinst(){
	ewarn "This is a gentoo-netscape patched release from"
	ewarn "http://gentoo-netscape.googlecode.com/"
	ewarn ""
	ewarn "If there are any bugs to report from this package, please"
	ewarn "visit our site and log a bug there.  Please don't submit"
	ewarn "any bugs to Gentoo Bugzilla, as we need to firstly ensure"
	ewarn "the bug isn't a problem with our patch."
}
