# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python3_{8..10} pypy3 )

inherit distutils-r1

DESCRIPTION="A set of mixin classes and other helpers for unittest test case classes"
HOMEPAGE="https://github.com/nedbat/unittest-mixins https://pypi.org/project/unittest-mixins/"
SRC_URI="https://github.com/nedbat/unittest-mixins/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~alpha amd64 arm arm64 hppa ~ia64 ~mips ppc ppc64 ~riscv ~s390 sparc x86"

RDEPEND=">=dev-python/six-1.10.0[${PYTHON_USEDEP}]"

distutils_enable_tests pytest
