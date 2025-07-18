EAPI=8

inherit git-r3

EGIT_REPO_URI="https://github.com/rust-lang/rust.git"
EGIT_BRANCH="stable"
EGIT_SUBMODULES=(library/stdarch)

SLOT="0"
S="${WORKDIR}/core-1.88.0/library/core"
IUSE=""

src_compile() {
	export RUSTC_BOOTSTRAP=1
	rustc \
		-Cprefer-dynamic \
		$RUSTFLAGS \
		-Csplit-debuginfo=packed \
		--edition=2024 \
		--crate-name=core \
		--crate-type=dylib \
		--emit=link \
		--cfg="target_has_atomic_load_store" \
		src/lib.rs
}

src_install() {
	insinto /usr/lib
	doins libcore*
}
