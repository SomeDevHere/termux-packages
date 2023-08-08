TERMUX_PKG_HOMEPAGE=https://www.qt.io/
TERMUX_PKG_DESCRIPTION="Qt 6 WebChannel Library"
TERMUX_PKG_LICENSE="LGPL-3.0"
TERMUX_PKG_MAINTAINER="Simeon Huang <symeon@librehat.com>"
TERMUX_PKG_VERSION=6.5.2
TERMUX_PKG_SRCURL="https://download.qt.io/official_releases/qt/6.5/${TERMUX_PKG_VERSION}/submodules/qtwebchannel-everywhere-src-${TERMUX_PKG_VERSION}.tar.xz"
TERMUX_PKG_SHA256=c188d9fa6e535b850b574fa9e47c6089555b8df1fe041dcb13aeeca336b78e63
TERMUX_PKG_DEPENDS="libc++, qt6-qtbase, qt6-qtdeclarative, qt6-qtwebsockets"
TERMUX_PKG_BUILD_DEPENDS="qt6-qtbase-cross-tools"
TERMUX_PKG_FORCE_CMAKE=true
TERMUX_PKG_EXTRA_CONFIGURE_ARGS="
-DCMAKE_TOOLCHAIN_FILE="${TERMUX_PREFIX}/lib/cmake/Qt6/qt.toolchain.cmake"
-DCMAKE_SYSTEM_NAME=Linux
"
