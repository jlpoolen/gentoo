# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit bash-completion-r1 llvm.org

DESCRIPTION="Common files shared between multiple slots of clang"
HOMEPAGE="https://llvm.org/"
S=${WORKDIR}/clang/utils

LICENSE="Apache-2.0-with-LLVM-exceptions UoI-NCSA"
SLOT="0"
KEYWORDS=""

PDEPEND="
	sys-devel/clang:*
"

LLVM_COMPONENTS=( clang/utils/bash-autocomplete.sh )
llvm.org_set_globals

src_install() {
	newbashcomp bash-autocomplete.sh clang
}
