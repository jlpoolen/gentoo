# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{8,9,10} )
DISTUTILS_OPTIONAL="1"

inherit distutils-r1 flag-o-matic toolchain-funcs

DESCRIPTION="I2C tools for bus probing, chip dumping, EEPROM decoding, and more"
HOMEPAGE="https://www.kernel.org/pub/software/utils/i2c-tools"
SRC_URI="https://www.kernel.org/pub/software/utils/${PN}/${P}.tar.xz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm arm64 ~mips ppc ppc64 ~riscv ~sparc x86"
IUSE="perl python"
REQUIRED_USE="python? ( ${PYTHON_REQUIRED_USE} )"

RDEPEND="
	python? ( ${PYTHON_DEPS} )"
DEPEND="${RDEPEND}"
RDEPEND+="
	perl? ( dev-lang/perl )"

src_prepare() {
	default
	use python && distutils-r1_src_prepare

	# Cut out the eeprom/ & stub/ dirs as only perl scripts live there.
	if ! use perl ; then
		sed -i '/^SRCDIRS/s: eeprom stub : :g' Makefile || die
	fi
}

src_configure() {
	use python && distutils-r1_src_configure

	export BUILD_DYNAMIC_LIB=1
	export USE_STATIC_LIB=0
	export BUILD_STATIC_LIB=0
}

src_compile() {
	emake AR="$(tc-getAR)" CC="$(tc-getCC)" all-lib # parallel make
	emake CC="$(tc-getCC)"
	emake -C eepromer CC="$(tc-getCC)" CFLAGS="${CFLAGS}"

	if use python ; then
		cd py-smbus || die
		append-cppflags -I../include
		distutils-r1_src_compile
	fi
}

src_install() {
	emake DESTDIR="${D}" libdir="/usr/$(get_libdir)" PREFIX="/usr" install-lib install
	dosbin eepromer/eeprom{,er}
	dodoc CHANGES README
	local d
	for d in $(usex perl eeprom '') eepromer ; do
		docinto "${d}"
		dodoc "${d}"/README*
	done

	if use python ; then
		cd py-smbus || die
		docinto py-smbus
		dodoc README*
		distutils-r1_src_install
	fi
}
