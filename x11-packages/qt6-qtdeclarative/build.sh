TERMUX_PKG_HOMEPAGE=https://www.qt.io/
TERMUX_PKG_DESCRIPTION="The Qt Declarative module provides classes for using GUIs created using QML"
TERMUX_PKG_LICENSE="LGPL-3.0"
TERMUX_PKG_MAINTAINER="Simeon Huang <symeon@librehat.com>"
TERMUX_PKG_VERSION=6.5.2
TERMUX_PKG_SRCURL="https://download.qt.io/official_releases/qt/6.5/${TERMUX_PKG_VERSION}/submodules/qtdeclarative-everywhere-src-${TERMUX_PKG_VERSION}.tar.xz"
TERMUX_PKG_SHA256=f3a11fe54e9fac77c649e46e39f1cbe161e9efe89bad205115ba2861b1eb8719
TERMUX_PKG_DEPENDS="libc++, qt6-qtbase, qt6-qtshadertools"
TERMUX_PKG_BUILD_DEPENDS="qt6-qtbase-cross-tools, qt6-qtshadertools-cross-tools"

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
