# Created by: Piotr Kubaj <pkubaj@anongoth.pl>
# $FreeBSD$

PORTNAME=	glx-utils
PORTVERSION=	8.2.0
PORTREVISION=	3
CATEGORIES=	graphics linux

MAINTAINER=	emulation@FreeBSD.org
COMMENT=	RPM of the GLX utils (Linux CentOS ${LINUX_DIST_VER})

CONFLICTS=	linux-c6-${PORTNAME}-[0-9]*

RPMVERSION=	3.el7
USES=		linux:c7
USE_LDCONFIG=	yes
USE_LINUX=	dri xorglibs
USE_LINUX_RPM=	nolib

SRC_DISTFILES=	mesa-11.2.2-2.20160614.el7${SRC_SUFX}:SOURCE

.include <bsd.port.mk>
