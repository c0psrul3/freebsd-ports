# Created by: Johannes Meixner <johannes@perceivon.net>
# $FreeBSD$

PORTNAME=	iocage
PORTVERSION=	20160819
CATEGORIES=	sysutils
PKGNAMESUFFIX=	-devel

MAINTAINER=	kmoore@FreeBSD.org
COMMENT=	Full featured, no dependency Jail container manager - devel build

DEPRECATED=	Outdated version. Please use sysutils/py-iocage instead
EXPIRATION_DATE=	2017-04-01

LICENSE=	BSD2CLAUSE
LICENSE_FILE=	${WRKSRC}/LICENSE

RUN_DEPENDS=	uclcmd:devel/uclcmd

USE_GITHUB=	yes
GH_ACCOUNT=	iocage
GH_TAGNAME=	218c3be
USE_OPENRC_SUBR=	iocage

NO_BUILD=	yes
NO_ARCH=	yes

post-patch:
	@${REINPLACE_CMD} -e "s|/usr/local/lib/iocage|${PREFIX}/lib/iocage|g" ${WRKSRC}/iocage

pre-install:
	@${MKDIR} ${STAGEDIR}${PREFIX}/lib/iocage

do-install:
	${INSTALL_SCRIPT} ${WRKSRC}/iocage ${STAGEDIR}${PREFIX}/sbin
	(cd ${WRKSRC}/lib/ && ${COPYTREE_SHARE} . ${STAGEDIR}${PREFIX}/lib/iocage)
	${INSTALL_MAN} ${WRKSRC}/iocage.8 ${STAGEDIR}${PREFIX}/man/man8

.include <bsd.port.mk>
