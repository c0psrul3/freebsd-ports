# Created by: Piotr Kubaj <pkubaj@anongoth.pl>
# $FreeBSD$

PORTNAME=	nss
PORTVERSION=	3.21.3
PORTREVISION=	1
CATEGORIES=	security linux
LIB_DISTFILES=	${DISTNAME}${EXTRACT_SUFX} \
		${PORTNAME}-util-${PORTVERSION}-1.1.el7_3${EXTRACT_SUFX} \
		${PORTNAME}-softokn-3.16.2.3-14.4.el7${EXTRACT_SUFX} \
		${PORTNAME}-softokn-freebl-3.16.2.3-14.4.el7${EXTRACT_SUFX}
SRC_DISTFILES=	${PORTNAME}-${PORTVERSION}-${RPMVERSION}${SRC_SUFX}:SOURCE \
		${PORTNAME}-util-${PORTVERSION}-1.1.el7_3${SRC_SUFX}:SOURCE \
		${PORTNAME}-softokn-3.16.2.3-14.4.el7${SRC_SUFX}:SOURCE

MAINTAINER=	emulation@FreeBSD.org
COMMENT=	Network Security Services (Linux CentOS ${LINUX_DIST_VER})

CONFLICTS=	linux-c6-${PORTNAME}-[0-9]*

RPMVERSION=	2.el7_3
USES=		linux:c7
USE_LDCONFIG=	yes
USE_LINUX=	nspr sqlite3
USE_LINUX_RPM=	yes

DESCR=		${.CURDIR}/../${PORTNAME}/pkg-descr

.include <bsd.port.mk>
