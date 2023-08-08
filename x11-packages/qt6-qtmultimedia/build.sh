TERMUX_PKG_HOMEPAGE=https://www.qt.io/
TERMUX_PKG_DESCRIPTION="Qt 6 Multimedia Library"
TERMUX_PKG_LICENSE="LGPL-3.0"
TERMUX_PKG_MAINTAINER="Simeon Huang <symeon@librehat.com>"
TERMUX_PKG_VERSION=6.5.2
TERMUX_PKG_SRCURL="https://download.qt.io/official_releases/qt/6.5/${TERMUX_PKG_VERSION}/submodules/qtmultimedia-everywhere-src-${TERMUX_PKG_VERSION}.tar.xz"
TERMUX_PKG_SHA256=948f00aa679e92839a2a71bd07245a92cc849af486607417ee4c334b2b998975
TERMUX_PKG_DEPENDS="libc++, qt6-qtbase, qt6-qtshadertools, pulseaudio, openal-soft, gstreamer, gst-plugins-base, gst-plugins-bad"
TERMUX_PKG_BUILD_DEPENDS="qt6-qtbase-cross-tools"
TERMUX_PKG_FORCE_CMAKE=true
TERMUX_PKG_EXTRA_CONFIGURE_ARGS="
-DCMAKE_TOOLCHAIN_FILE="${TERMUX_PREFIX}/lib/cmake/Qt6/qt.toolchain.cmake"
-DCMAKE_SYSTEM_NAME=Linux
"
