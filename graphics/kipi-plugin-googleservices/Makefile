# $FreeBSD$

PORTNAME=	kipi-plugin-${KIPI_PLUGIN}
PORTVERSION=	${DIGIKAM_VER}
CATEGORIES=	graphics kde

MAINTAINER=	kde@FreeBSD.org
COMMENT=	${${KIPI_PLUGIN}_DESC}

LIB_DEPENDS=	libqjson.so:devel/qjson

CONFLICTS_INSTALL=	kipi-plugin-googledrive-* \
			kipi-plugin-picasawebexport-*

KIPI_PLUGIN=	googleservices
.include "${.CURDIR}/../digikam-kde4/Makefile.common"
.include <bsd.port.mk>
