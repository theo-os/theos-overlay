EAPI=8

SLOT="0"

inherit git-r3 cmake

EGIT_REPO_URI="https://github.com/llvm/llvm-project"
IUSE="libcxx lto"
S="${WORKDIR}/llvm-project-9999/llvm"

src_configure() {
	local mycmakeargs=(
		-DBUILD_SHARED_LIBS=ON
		-DLLVM_ENABLE_ASSERTIONS=OFF
		-DLLVM_USE_SPLIT_DWARF=ON
		-DLLVM_ENABLE_ZSTD=ON
		-DLLVM_ENABLE_MODULES=$(use libcxx)
		-DLLVM_ENABLE_LIBCXX=$(use libcxx)
		-DLLVM_ENABLE_LTO=$(use lto Thin OFF)
		-DLLVM_CCACHE_BUILD=ON
		-DLLVM_EXPERIMENTAL_TARGETS_TO_BUILD=all
		-DLLVM_INSTALL_UTILS=ON
		-DLLVM_TARGETS_TO_BUILD=all
		-DLLVM_OPTIMIZED_TABLEGEN=ON
		-DLLVM_INCLUDE_BENCHMARKS=OFF
		-DLLVM_INCLUDE_TESTS=OFF
		-DCLANG_DEFAULT_RTLIB=compiler-rt
		-DCLANG_DEFAULT_CXX_STDLIB=libc++
		-DCLANG_DEFAULT_LINKER=lld
		-DLLVM_ENABLE_PROJECTS="clang;lld;lldb;clang-tools-extra;bolt;polly;mlir"
		-DLLVM_ENABLE_RUNTIMES="compiler-rt;libc;libcxx;libcxxabi;libunwind;openmp"
		-DCLANG_ENABLE_CIR=ON
		-DCLANG_ENABLE_HLSL=ON
		-DLLVM_PARALLEL_LINK_JOBS=1
	)
	cmake_src_configure
}
