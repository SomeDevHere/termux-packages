TERMUX_PKG_HOMEPAGE=https://www.qt.io/
TERMUX_PKG_DESCRIPTION="The Qt Positioning API provides positioning information via QML and C++ interfaces"
TERMUX_PKG_LICENSE="LGPL-3.0"
TERMUX_PKG_MAINTAINER="Simeon Huang <symeon@librehat.com>"
TERMUX_PKG_VERSION=6.5.2
TERMUX_PKG_SRCURL="https://download.qt.io/official_releases/qt/6.5/${TERMUX_PKG_VERSION}/submodules/qtpositioning-everywhere-src-${TERMUX_PKG_VERSION}.tar.xz"
TERMUX_PKG_SHA256=70493f03748d1c5b1577e4c011c0af9bcaffcdc6c5e519362605b01f917614fa
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
