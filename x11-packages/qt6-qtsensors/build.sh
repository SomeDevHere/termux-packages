TERMUX_PKG_HOMEPAGE=https://www.qt.io/
TERMUX_PKG_DESCRIPTION="Qt 6 Sensors Library"
TERMUX_PKG_LICENSE="LGPL-3.0"
TERMUX_PKG_MAINTAINER="Simeon Huang <symeon@librehat.com>"
TERMUX_PKG_VERSION=6.5.2
TERMUX_PKG_SRCURL="https://download.qt.io/official_releases/qt/6.5/${TERMUX_PKG_VERSION}/submodules/qtsensors-everywhere-src-${TERMUX_PKG_VERSION}.tar.xz"
TERMUX_PKG_SHA256=4006bd7cfbb4302a887bda82b7fe3c31633626363a5e6ba9730bdb4fa8ab2aa6
TERMUX_PKG_DEPENDS="libc++, qt6-qtbase, qt6-qtdeclarative"
TERMUX_PKG_BUILD_DEPENDS="qt6-qtbase-cross-tools"
TERMUX_PKG_FORCE_CMAKE=true
TERMUX_PKG_EXTRA_CONFIGURE_ARGS="
-DCMAKE_TOOLCHAIN_FILE="${TERMUX_PREFIX}/lib/cmake/Qt6/qt.toolchain.cmake"
-DCMAKE_SYSTEM_NAME=Linux
"
