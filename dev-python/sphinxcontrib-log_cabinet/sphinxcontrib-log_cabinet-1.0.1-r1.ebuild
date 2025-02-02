# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{8..10} pypy3 )

inherit distutils-r1

DESCRIPTION="Organize changelog directives in Sphinx docs"
HOMEPAGE="
	https://github.com/davidism/sphinxcontrib-log-cabinet/
	https://pypi.org/project/sphinxcontrib-log-cabinet/
"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P/_/-}.tar.gz"
S="${WORKDIR}/${P/_/-}"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~alpha amd64 arm arm64 hppa ~ia64 ~m68k ppc ppc64 ~riscv ~s390 sparc x86"

python_compile() {
	distutils-r1_python_compile
	find "${BUILD_DIR}" -name '*.pth' -delete || die
}
