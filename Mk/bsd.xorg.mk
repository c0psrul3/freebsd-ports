#-*- tab-width: 4; -*-
# ex:ts=4
#
# bsd.xorg.mk - Support for X.Org ports and dependencies
#
# Created by: Florent Thoumie <flz@FreeBSD.org>
#
# !!! Here be dragons !!! (yeah, here as well...)
#
# $FreeBSD$
#

.if !defined(_POSTMKINCLUDED) && !defined(Xorg_Pre_Include)

Xorg_Include_MAINTAINER=	x11@FreeBSD.org
Xorg_Pre_Include=		bsd.xorg.mk

# Some notes:
#
# app - Installs applications, no shared libraries.
# data - Installs only data.
# doc - no particular notes
# driver - input depends on inputproto/randrproto at least
#          video depends on randrproto/renderproto at least
# font - don't install .pc file
# lib - various dependencies, install .pc file, needs pathfix
# proto - install .pc file, needs pathfix, most only needed at build time.
# xserver - there's only one atm, I guess everything can fit into the port itself

.if defined(XORG_CAT)
# Default variables, common to all new modular xorg ports.
.if !defined(USES) || ! ${USES:Mtar*}
USES+=		tar:bzip2
.endif
GNU_CONFIGURE= 	yes
# for some reason this makes mkfontscale and others fail in the install target
#INSTALL_TARGET=	install-strip
DIST_SUBDIR=	xorg/${XORG_CAT}

MASTER_SITES?=	${MASTER_SITE_XORG}
MASTER_SITE_SUBDIR?=	individual/${XORG_CAT}

# All xorg ports needs pkgconfig to build, but some ports look for pkgconfig and
# then continues the build.
USES+=		pkgconfig

# All xorg ports needs xorg-macros.
. if ${PORTNAME} != xorg-macros
USE_XORG+=      xorg-macros
. endif

. if ${XORG_CAT} == "app"
# Nothing at the moment
. endif

. if ${XORG_CAT} == "data"
# Nothing at the moment.
. endif

. if ${XORG_CAT} == "driver"
USE_XORG+=	xorg-server xproto randrproto xi renderproto xextproto \
		inputproto kbproto fontsproto videoproto dri2proto xf86driproto \
		presentproto glproto xineramaproto resourceproto scrnsaverproto
# work around a llvm bug on i386, llvm bug #15806 
# reproduced with clang 3.2 (current release) and 3.1
.  if ${ARCH} == i386
CFLAGS+=	-fno-optimize-sibling-calls
.  endif
CPPFLAGS+=	-Werror=uninitialized
CONFIGURE_ENV+=	DRIVER_MAN_SUFFIX=4x DRIVER_MAN_DIR='$$(mandir)/man4'
USES+=		libtool
. endif

. if ${XORG_CAT} == "font"
FONTNAME?=	${PORTNAME:C/.*-//g:S/type/Type/:S/ttf/TTF/:S/speedo/Speedo/}
CONFIGURE_ARGS+=	--with-fontrootdir=${PREFIX}/share/fonts
CONFIGURE_ENV+=	FONTROOTDIR=${PREFIX}/share/fonts
.    if !defined(NOFONT)
USES+=	fonts
BUILD_DEPENDS+=	mkfontdir:x11-fonts/mkfontdir \
				bdftopcf:x11-fonts/bdftopcf
PLIST_FILES+=	"@comment ${FONTSDIR}/fonts.dir" \
				"@comment ${FONTSDIR}/fonts.scale"
.    endif
.  endif

. if ${XORG_CAT} == "lib"
USES+=		pathfix libtool
USE_LDCONFIG=	yes
CONFIGURE_ARGS+=--enable-malloc0returnsnull
. endif

. if ${XORG_CAT} == "proto"
USES+=	pathfix
. endif

. if ${XORG_CAT} == "xserver"
DISTFILES?=	xorg-server-${PORTVERSION}.tar.bz2
WRKSRC=		${WRKDIR}/xorg-server-${PORTVERSION}
USES+=	pathfix
CPPFLAGS+=	-Werror=uninitialized
CONFIGURE_ARGS+=	--with-xkb-path=${LOCALBASE}/share/X11/xkb \
					--with-fontrootdir=${LOCALBASE}/share/fonts

LIB_PC_DEPENDS+=	${LOCALBASE}/libdata/pkgconfig/dri.pc:graphics/dri
USE_XORG+=	pciaccess xextproto videoproto fontsproto dri2proto fontutil:build
. endif

.endif

.endif

.if defined(_POSTMKINCLUDED) && !defined(Xorg_Post_Include)

Xorg_Post_Include=		bsd.xorg.mk

# Register all xorg .pc files here.
# foo_LIB_PC_DEPENDS means it should go to BUILD_DEPENDS *and* RUN_DEPENDS.

XORG_MODULES=	bigreqsproto \
				compositeproto \
				damageproto \
				dmx \
				dmxproto \
				dri2proto \
				dri3proto \
				evieproto \
				fixesproto \
				fontcacheproto \
				fontenc \
				fontsproto \
				fontutil \
				glproto \
				ice \
				inputproto \
				kbproto \
				libfs \
				oldx \
				pciaccess \
				pixman \
				presentproto \
				printproto \
				randrproto \
				recordproto \
				renderproto \
				resourceproto \
				scrnsaverproto \
				sm \
				trapproto \
				videoproto \
				x11 \
				xau \
				xaw \
				xaw6 \
				xaw7 \
				xbitmaps \
				xcb \
				xcmiscproto \
				xcomposite \
				xcursor \
				xdamage \
				xdmcp \
				xevie \
				xext \
				xextproto \
				xf86bigfontproto \
				xf86dgaproto \
				xf86driproto \
				xf86miscproto \
				xf86rushproto \
				xf86vidmodeproto \
				xfixes \
				xfont \
				xfont2 \
				xfontcache \
				xft \
				xi \
				xinerama \
				xineramaproto \
				xkbfile \
				xkbui \
				xmu \
				xmuu \
				xorg-macros \
				xorg-server \
				xp \
				xpm \
				xprintapputil \
				xprintutil \
				xproto \
				xproxymngproto \
				xrandr \
				xrender \
				xres \
				xscrnsaver \
				xshmfence \
				xt \
				xtrans \
				xtrap \
				xtst \
				xv \
				xvmc \
				xxf86dga \
				xxf86misc \
				xxf86vm

bigreqsproto_BUILD_DEPENDS=	${LOCALBASE}/libdata/pkgconfig/bigreqsproto.pc:x11/bigreqsproto
compositeproto_BUILD_DEPENDS=	${LOCALBASE}/libdata/pkgconfig/compositeproto.pc:x11/compositeproto
damageproto_BUILD_DEPENDS=	${LOCALBASE}/libdata/pkgconfig/damageproto.pc:x11/damageproto
dmx_LIB_PC_DEPENDS=		${LOCALBASE}/libdata/pkgconfig/dmx.pc:x11/libdmx
dmxproto_BUILD_DEPENDS=		${LOCALBASE}/libdata/pkgconfig/dmxproto.pc:x11/dmxproto
dri2proto_BUILD_DEPENDS=	${LOCALBASE}/libdata/pkgconfig/dri2proto.pc:x11/dri2proto
dri3proto_BUILD_DEPENDS=	${LOCALBASE}/libdata/pkgconfig/dri3proto.pc:x11/dri3proto
evieproto_BUILD_DEPENDS=	${LOCALBASE}/libdata/pkgconfig/evieproto.pc:x11/evieext
fixesproto_BUILD_DEPENDS=	${LOCALBASE}/libdata/pkgconfig/fixesproto.pc:x11/fixesproto
fontcacheproto_BUILD_DEPENDS=	${LOCALBASE}/libdata/pkgconfig/fontcacheproto.pc:x11-fonts/fontcacheproto
fontenc_LIB_PC_DEPENDS=		${LOCALBASE}/libdata/pkgconfig/fontenc.pc:x11-fonts/libfontenc
fontsproto_BUILD_DEPENDS=	${LOCALBASE}/libdata/pkgconfig/fontsproto.pc:x11-fonts/fontsproto
fontutil_LIB_PC_DEPENDS=	${LOCALBASE}/libdata/pkgconfig/fontutil.pc:x11-fonts/font-util
glproto_BUILD_DEPENDS=		${LOCALBASE}/libdata/pkgconfig/glproto.pc:x11/glproto
ice_LIB_PC_DEPENDS=		${LOCALBASE}/libdata/pkgconfig/ice.pc:x11/libICE
inputproto_BUILD_DEPENDS=	${LOCALBASE}/libdata/pkgconfig/inputproto.pc:x11/inputproto
kbproto_BUILD_DEPENDS=		${LOCALBASE}/libdata/pkgconfig/kbproto.pc:x11/kbproto
libfs_LIB_PC_DEPENDS=		${LOCALBASE}/libdata/pkgconfig/libfs.pc:x11-fonts/libFS
oldx_LIB_PC_DEPENDS=		${LOCALBASE}/libdata/pkgconfig/oldx.pc:x11/liboldX
pciaccess_LIB_PC_DEPENDS=	${LOCALBASE}/libdata/pkgconfig/pciaccess.pc:devel/libpciaccess
pixman_LIB_PC_DEPENDS=		${LOCALBASE}/libdata/pkgconfig/pixman-1.pc:x11/pixman
presentproto_BUILD_DEPENDS=	${LOCALBASE}/libdata/pkgconfig/presentproto.pc:x11/presentproto
printproto_BUILD_DEPENDS=	${LOCALBASE}/libdata/pkgconfig/printproto.pc:x11/printproto
randrproto_BUILD_DEPENDS=	${LOCALBASE}/libdata/pkgconfig/randrproto.pc:x11/randrproto
recordproto_BUILD_DEPENDS=	${LOCALBASE}/libdata/pkgconfig/recordproto.pc:x11/recordproto
renderproto_BUILD_DEPENDS=	${LOCALBASE}/libdata/pkgconfig/renderproto.pc:x11/renderproto
resourceproto_BUILD_DEPENDS=	${LOCALBASE}/libdata/pkgconfig/resourceproto.pc:x11/resourceproto
scrnsaverproto_BUILD_DEPENDS=	${LOCALBASE}/libdata/pkgconfig/scrnsaverproto.pc:x11/scrnsaverproto
sm_LIB_PC_DEPENDS=		${LOCALBASE}/libdata/pkgconfig/sm.pc:x11/libSM
trapproto_BUILD_DEPENDS=	${LOCALBASE}/libdata/pkgconfig/trapproto.pc:x11/trapproto
videoproto_BUILD_DEPENDS=	${LOCALBASE}/libdata/pkgconfig/videoproto.pc:x11/videoproto
x11_LIB_PC_DEPENDS=		${LOCALBASE}/libdata/pkgconfig/x11.pc:x11/libX11
xau_LIB_PC_DEPENDS=		${LOCALBASE}/libdata/pkgconfig/xau.pc:x11/libXau
xaw_LIB_PC_DEPENDS=		${xaw7_LIB_PC_DEPENDS}
xaw6_LIB_PC_DEPENDS=		${LOCALBASE}/libdata/pkgconfig/xaw6.pc:x11-toolkits/libXaw
xaw7_LIB_PC_DEPENDS=		${LOCALBASE}/libdata/pkgconfig/xaw7.pc:x11-toolkits/libXaw
xbitmaps_LIB_PC_DEPENDS=	${LOCALBASE}/libdata/pkgconfig/xbitmaps.pc:x11/xbitmaps
xcb_LIB_PC_DEPENDS=			${LOCALBASE}/libdata/pkgconfig/xcb.pc:x11/libxcb
xcmiscproto_BUILD_DEPENDS=	${LOCALBASE}/libdata/pkgconfig/xcmiscproto.pc:x11/xcmiscproto
xcomposite_LIB_PC_DEPENDS=	${LOCALBASE}/libdata/pkgconfig/xcomposite.pc:x11/libXcomposite
xcursor_LIB_PC_DEPENDS=		${LOCALBASE}/libdata/pkgconfig/xcursor.pc:x11/libXcursor
xdamage_LIB_PC_DEPENDS=		${LOCALBASE}/libdata/pkgconfig/xdamage.pc:x11/libXdamage
xdmcp_LIB_PC_DEPENDS=		${LOCALBASE}/libdata/pkgconfig/xdmcp.pc:x11/libXdmcp
xevie_LIB_PC_DEPENDS=		${LOCALBASE}/libdata/pkgconfig/xevie.pc:x11/libXevie
xext_LIB_PC_DEPENDS=		${LOCALBASE}/libdata/pkgconfig/xext.pc:x11/libXext
xextproto_BUILD_DEPENDS=	${LOCALBASE}/libdata/pkgconfig/xextproto.pc:x11/xextproto
xf86bigfontproto_BUILD_DEPENDS=	${LOCALBASE}/libdata/pkgconfig/xf86bigfontproto.pc:x11-fonts/xf86bigfontproto
xf86dgaproto_BUILD_DEPENDS=	${LOCALBASE}/libdata/pkgconfig/xf86dgaproto.pc:x11/xf86dgaproto
xf86driproto_BUILD_DEPENDS=	${LOCALBASE}/libdata/pkgconfig/xf86driproto.pc:x11/xf86driproto
xf86miscproto_BUILD_DEPENDS=	${LOCALBASE}/libdata/pkgconfig/xf86miscproto.pc:x11/xf86miscproto
xf86rushproto_BUILD_DEPENDS=	${LOCALBASE}/libdata/pkgconfig/xf86rushproto.pc:x11/xf86rushproto
xf86vidmodeproto_BUILD_DEPENDS=	${LOCALBASE}/libdata/pkgconfig/xf86vidmodeproto.pc:x11/xf86vidmodeproto
xfixes_LIB_PC_DEPENDS=		${LOCALBASE}/libdata/pkgconfig/xfixes.pc:x11/libXfixes
xfont_LIB_PC_DEPENDS=		${LOCALBASE}/libdata/pkgconfig/xfont.pc:x11-fonts/libXfont
xfont2_LIB_PC_DEPENDS=		${LOCALBASE}/libdata/pkgconfig/xfont2.pc:x11-fonts/libXfont2
xfontcache_LIB_PC_DEPENDS=	${LOCALBASE}/libdata/pkgconfig/xfontcache.pc:x11-fonts/libXfontcache
xft_LIB_PC_DEPENDS=		${LOCALBASE}/libdata/pkgconfig/xft.pc:x11-fonts/libXft
xi_LIB_PC_DEPENDS=		${LOCALBASE}/libdata/pkgconfig/xi.pc:x11/libXi
xinerama_LIB_PC_DEPENDS=	${LOCALBASE}/libdata/pkgconfig/xinerama.pc:x11/libXinerama
xineramaproto_BUILD_DEPENDS=	${LOCALBASE}/libdata/pkgconfig/xineramaproto.pc:x11/xineramaproto
xkbfile_LIB_PC_DEPENDS=		${LOCALBASE}/libdata/pkgconfig/xkbfile.pc:x11/libxkbfile
xkbui_LIB_PC_DEPENDS=		${LOCALBASE}/libdata/pkgconfig/xkbui.pc:x11/libxkbui
xmu_LIB_PC_DEPENDS=		${LOCALBASE}/libdata/pkgconfig/xmu.pc:x11-toolkits/libXmu
xmuu_LIB_PC_DEPENDS=		${LOCALBASE}/libdata/pkgconfig/xmuu.pc:x11-toolkits/libXmu
xorg-macros_BUILD_DEPENDS=	${LOCALBASE}/libdata/pkgconfig/xorg-macros.pc:devel/xorg-macros
xorg-server_LIB_PC_DEPENDS=	${LOCALBASE}/libdata/pkgconfig/xorg-server.pc:x11-servers/xorg-server
xp_LIB_PC_DEPENDS=		${LOCALBASE}/libdata/pkgconfig/xp.pc:x11/libXp
xpm_LIB_PC_DEPENDS=		${LOCALBASE}/libdata/pkgconfig/xpm.pc:x11/libXpm
xprintapputil_LIB_PC_DEPENDS=	${LOCALBASE}/libdata/pkgconfig/xprintapputil.pc:x11/libXprintAppUtil
xprintutil_LIB_PC_DEPENDS=	${LOCALBASE}/libdata/pkgconfig/xprintutil.pc:x11/libXprintUtil
xproto_LIB_PC_DEPENDS=		${LOCALBASE}/libdata/pkgconfig/xproto.pc:x11/xproto
xproxymngproto_BUILD_DEPENDS=	${LOCALBASE}/libdata/pkgconfig/xproxymngproto.pc:x11/xproxymanagementprotocol
xrandr_LIB_PC_DEPENDS=		${LOCALBASE}/libdata/pkgconfig/xrandr.pc:x11/libXrandr
xrender_LIB_PC_DEPENDS=		${LOCALBASE}/libdata/pkgconfig/xrender.pc:x11/libXrender
xres_LIB_PC_DEPENDS=		${LOCALBASE}/libdata/pkgconfig/xres.pc:x11/libXres
xscrnsaver_LIB_PC_DEPENDS=	${LOCALBASE}/libdata/pkgconfig/xscrnsaver.pc:x11/libXScrnSaver
xt_LIB_PC_DEPENDS=		${LOCALBASE}/libdata/pkgconfig/xt.pc:x11-toolkits/libXt
xshmfence_LIB_PC_DEPENDS=	${LOCALBASE}/libdata/pkgconfig/xshmfence.pc:x11/libxshmfence
xtrans_BUILD_DEPENDS=		${LOCALBASE}/libdata/pkgconfig/xtrans.pc:x11/xtrans
xtrap_LIB_PC_DEPENDS=		${LOCALBASE}/libdata/pkgconfig/xtrap.pc:x11/libXTrap
xtst_LIB_PC_DEPENDS=		${LOCALBASE}/libdata/pkgconfig/xtst.pc:x11/libXtst
xv_LIB_PC_DEPENDS=		${LOCALBASE}/libdata/pkgconfig/xv.pc:x11/libXv
xvmc_LIB_PC_DEPENDS=		${LOCALBASE}/libdata/pkgconfig/xvmc.pc:x11/libXvMC
xxf86dga_LIB_PC_DEPENDS=	${LOCALBASE}/libdata/pkgconfig/xxf86dga.pc:x11/libXxf86dga
xxf86misc_LIB_PC_DEPENDS=	${LOCALBASE}/libdata/pkgconfig/xxf86misc.pc:x11/libXxf86misc
xxf86vm_LIB_PC_DEPENDS=		${LOCALBASE}/libdata/pkgconfig/xxf86vm.pc:x11/libXxf86vm

.for _module in ${USE_XORG:M*\:both:C/\:.*//g}
. if ${XORG_MODULES:M${_module}} == ""
IGNORE=				requires unknown xorg module (${_module})
. endif
RUN_DEPENDS+=			${${_module}_BUILD_DEPENDS}
.endfor

.for _module in ${USE_XORG:C/\:.*//g}
. if ${XORG_MODULES:M${_module}} == ""
IGNORE=				requires unknown xorg module (${_module})
. endif
LIB_PC_DEPENDS+=		${${_module}_LIB_PC_DEPENDS}
BUILD_DEPENDS+=			${${_module}_BUILD_DEPENDS}
.endfor

RUN_DEPENDS+=			${LIB_PC_DEPENDS}
BUILD_DEPENDS+=			${LIB_PC_DEPENDS}

.endif
