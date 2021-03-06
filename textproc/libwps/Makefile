# Created by: Michael Johnson <ahze@FreeBSD.org>
# $FreeBSD$

PORTNAME=	libwps
PORTVERSION=	0.4.5
CATEGORIES=	textproc
MASTER_SITES=	SF/${PORTNAME}/${PORTNAME}/${PORTNAME}-${PORTVERSION}

MAINTAINER=	office@FreeBSD.org
COMMENT=	Microsoft file word processor format import filter library

LICENSE=	LGPL21 MPL
LICENSE_COMB=	dual

LIB_DEPENDS=	librevenge-0.0.so:textproc/librevenge

CONFIGURE_ARGS=	--disable-werror --without-docs
CPPFLAGS+=	-I${LOCALBASE}/include
GNU_CONFIGURE=	yes
USES=		compiler:features libtool pathfix pkgconfig tar:bz2
USE_LDCONFIG=	yes
INSTALL_TARGET=	install-strip

.include <bsd.port.pre.mk>

.if ${COMPILER_FEATURES:Mlibc++}
CONFIGURE_ARGS+=	--with-sharedptr=c++11
.else
BUILD_DEPENDS+=	${LOCALBASE}/include/boost/shared_ptr.hpp:devel/boost-libs
CONFIGURE_ARGS+=	--with-sharedptr=boost
.endif

.include <bsd.port.post.mk>
