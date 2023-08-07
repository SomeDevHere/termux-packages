TERMUX_PKG_HOMEPAGE=https://www.qt.io/
TERMUX_PKG_DESCRIPTION="The Qt Shader Tools module builds on the SPIR-V Open Source Ecosystem as described at the Khronos SPIR-V web site"
TERMUX_PKG_LICENSE="LGPL-3.0"
TERMUX_PKG_MAINTAINER="Simeon Huang <symeon@librehat.com>"
TERMUX_PKG_VERSION=6.5.2
TERMUX_PKG_SRCURL="https://download.qt.io/official_releases/qt/6.5/${TERMUX_PKG_VERSION}/submodules/qtshadertools-everywhere-src-${TERMUX_PKG_VERSION}.tar.xz"
TERMUX_PKG_SHA256=ca3fb0db8576c59b9c38bb4b271cc6e10aebeb54e2121f429f4ee80671fc0a3d
TERMUX_PKG_DEPENDS="libc++, qt6-qtbase"
TERMUX_PKG_BUILD_DEPENDS="qt6-qtbase-cross-tools"

TERMUX_PKG_HOSTBUILD=true
TERMUX_PKG_FORCE_CMAKE=true
TERMUX_PKG_EXTRA_CONFIGURE_ARGS="
-DCMAKE_TOOLCHAIN_FILE="${TERMUX_PREFIX}/lib/cmake/Qt6/qt.toolchain.cmake"
-DCMAKE_SYSTEM_NAME=Linux
"

termux_step_host_build() {
    termux_setup_cmake
    termux_setup_ninja
    ${TERMUX_PREFIX}/opt/qt/cross/bin/qt-configure-module ${TERMUX_PKG_SRCDIR}
    cmake --build .
    cmake --install .
}

termux_step_pre_configure() {
    #if the hostfiles are not found other packages depending on host binaries will fail silently
    termux_setup_ninja
    cd ${TERMUX_PKG_HOSTBUILD_DIR}
    ninja install
}
