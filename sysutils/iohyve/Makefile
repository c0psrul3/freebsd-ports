# $FreeBSD$

PORTNAME=	iohyve
PORTVERSION=	0.7.7
PORTREVISION=	2
CATEGORIES=	sysutils

MAINTAINER=	lme@FreeBSD.org
COMMENT=	bhyve manager utilizing ZFS and other FreeBSD tools

LICENSE=	BSD2CLAUSE
LICENSE_FILE=	${WRKSRC}/LICENSE

USE_GITHUB=	yes
GH_ACCOUNT=	pr1ntf
USE_OPENRC_SUBR=	iohyve

NO_BUILD=	yes
NO_ARCH=	yes

do-patch:
	${REINPLACE_CMD} 's%\$$(PREFIX)%${STAGEDIR}/$$(PREFIX)%g' ${WRKSRC}/Makefile

.include <bsd.port.mk>
