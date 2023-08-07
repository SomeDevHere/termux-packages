TERMUX_PKG_HOMEPAGE=https://www.qt.io/
TERMUX_PKG_DESCRIPTION="A cross-platform application and UI framework"
TERMUX_PKG_LICENSE="LGPL-3.0"
TERMUX_PKG_MAINTAINER="SDH <somedevhere@gmail.com>"
TERMUX_PKG_VERSION=6.5.2
TERMUX_PKG_REVISION=0
TERMUX_PKG_SRCURL="https://download.qt.io/official_releases/qt/6.5/${TERMUX_PKG_VERSION}/submodules/qtbase-everywhere-src-${TERMUX_PKG_VERSION}.tar.xz"
TERMUX_PKG_SHA256=3db4c729b4d80a9d8fda8dd77128406353baff4755ca619177eda4cddae71269
TERMUX_PKG_DEPENDS="dbus, double-conversion, freetype, glib, harfbuzz, krb5, libandroid-execinfo, libandroid-shmem, libandroid-sysv-semaphore, libc++, libice, libicu, libjpeg-turbo, libpng, libsm, libuuid, libx11, libxcb, libxi, libxkbcommon, openssl, pcre2, postgresql, ttf-dejavu, xcb-util-cursor, xcb-util-image, xcb-util-keysyms, xcb-util-renderutil, xcb-util-wm, zlib"
# gtk3 dependency is a run-time dependency only for the gtk platformtheme subpackage
TERMUX_PKG_BUILD_DEPENDS="gtk3"
TERMUX_PKG_NO_STATICSPLIT=true

TERMUX_PKG_HOSTBUILD=true
TERMUX_PKG_FORCE_CMAKE=true

QT_EXTRA_INCLUDEPATHS="${TERMUX_PREFIX}/include
${TERMUX_PREFIX}/include/glib-2.0
${TERMUX_PREFIX}/lib/glib-2.0/include
${TERMUX_PREFIX}/include/gio-unix-2.0
${TERMUX_PREFIX}/include/cairo
${TERMUX_PREFIX}/include/pango-1.0
${TERMUX_PREFIX}/include/fribidi
${TERMUX_PREFIX}/include/harfbuzz
${TERMUX_PREFIX}/include/atk-1.0
${TERMUX_PREFIX}/include/pixman-1
${TERMUX_PREFIX}/include/uuid
${TERMUX_PREFIX}/include/libxml2
${TERMUX_PREFIX}/include/freetype2
${TERMUX_PREFIX}/include/gdk-pixbuf-2.0
${TERMUX_PREFIX}/include/gtk-3.0
"

TERMUX_PKG_EXTRA_CONFIGURE_ARGS="
-DQT_QMAKE_TARGET_MKSPEC=termux
-DINSTALL_ARCHDATADIR=${TERMUX_PREFIX}/lib/qt6
-DINSTALL_BINDIR=${TERMUX_PREFIX}/lib/qt6/bin
-DINSTALL_INCLUDEDIR=include/qt6
-DINSTALL_MKSPECSDIR=${TERMUX_PREFIX}/lib/qt6/mkspecs
-DINSTALL_DOCDIR=${TERMUX_PREFIX}/share/doc/qt6
-DBUILD_SHARED_LIBS=ON
-DCMAKE_SKIP_BUILD_RPATH=ON
-DCMAKE_SKIP_INSTALL_RPATH=ON
-DQT_EXTRA_INCLUDEPATHS=$QT_EXTRA_INCLUDEPATHS
-DQT_EXTRA_LIBDIRS="${TERMUX_PREFIX}/lib"
-DQT_BUILD_TESTS=OFF
-DQT_BUILD_EXAMPLES=OFF
-DBUILD_WITH_PCH=OFF
-DFEATURE_accessibility=OFF
-DFEATURE_glib=ON
-DFEATURE_gtk3=ON
-DFEATURE_icu=ON
-DFEATURE_doubleconversion=ON
-DFEATURE_system_doubleconversion=ON
-DFEATURE_pcre2=ON
-DFEATURE_system_pcre2=ON
-DFEATURE_system_zlib=ON
-DFEATURE_freetype=ON
-DFEATURE_ssl=ON
-DINPUT_openssl=linked
-DFEATURE_system_proxies=OFF
-DFEATURE_cups=OFF
-DFEATURE_harfbuzz=ON
-DFEATURE_system_harfbuzz=ON
-DINPUT_opengl=no
-DQT_QPA_DEFAULT_PLATFORM=xcb
-DFEATURE_eglfs=OFF
-DFEATURE_gbm=OFF
-DFEATURE_kms=OFF
-DFEATURE_linuxfb=OFF
-DFEATURE_libudev=OFF
-DFEATURE_evdev=OFF
-DFEATURE_libinput=OFF
-DFEATURE_mtdev=OFF
-DFEATURE_tslib=OFF
-DFEATURE_xcb=ON
-DFEATURE_gif=ON
-DFEATURE_libpng=ON
-DFEATURE_libjpeg=ON
-DFEATURE_sql_=ON
-DFEATURE_system_sqlite=ON
-DQT_HOST_PATH=${TERMUX_PREFIX}/opt/qt/cross
-DQT_FORCE_BUILD_TOOLS=TRUE
-DCMAKE_SYSTEM_NAME=Linux
"

termux_step_host_build() {
    termux_setup_cmake
    termux_setup_ninja
    mkdir -p ${TERMUX_PREFIX}/opt/qt/cross
    cmake -G Ninja -DCMAKE_BUILD_TYPE=Release \
            -DCMAKE_INSTALL_PREFIX=${TERMUX_PREFIX}/opt/qt/cross \
	    -DBUILD_SHARED_LIBS=ON \
    ${TERMUX_PKG_SRCDIR}

    ninja
    ninja install
}

termux_step_pre_configure () {
    #if the host artifacts are not found other packages depending on host binaries will fail
    termux_setup_ninja
    cd ${TERMUX_PKG_HOSTBUILD_DIR}
    ninja install
    if [ "${TERMUX_ARCH}" = "arm" ]; then
        ## -mfpu=neon causes build failure on ARM.
        CFLAGS="${CFLAGS/-mfpu=neon/} -mfpu=vfp"
        CXXFLAGS="${CXXFLAGS/-mfpu=neon/} -mfpu=vfp"
    fi
    LDFLAGS+=" -landroid-shmem" 
}

termux_step_post_make_install() {
    # remove hard links
    cd ${TERMUX_PREFIX}/opt/qt/cross/bin
    rm androiddeployqt qmake qtpaths
    ln -s androiddeployqt6 androiddeployqt
    ln -s qmake6 qmake
    ln -s qtpaths6 qtpaths
}
