# Created by: Christian Brueffer <chris@unixpages.org>
# $FreeBSD: head/editors/edith/Makefile 357277 2014-06-10 07:39:01Z olgeni $

PORTNAME=	edith
PORTVERSION=	1.58
PORTREVISION=	2
CATEGORIES=	editors linux
MASTER_SITES=	http://www.groenink.com/pub/edith/
DISTFILES=	edith1.55.common.tar.gz \
		edith1.58.linux-glibc.tar.gz

MAINTAINER=	ports@FreeBSD.org
COMMENT=	X11 GUI editor for binary and plain text files

ONLY_FOR_ARCHS=	i386 amd64
USES=		linux
USE_LINUX=	xorglibs

RESTRICTED=	Redistribution not allowed
NO_BUILD=	yes

WRKSRC=		${WRKDIR}/edith
EDITHDIR=	${PREFIX}/lib/edith

do-install:
	${INSTALL_PROGRAM} ${WRKSRC}/bin/linux/edith ${STAGEDIR}${PREFIX}/bin
	@${MKDIR} ${STAGEDIR}${EDITHDIR}/bin
	${INSTALL_SCRIPT} ${WRKSRC}/bin/edi* ${STAGEDIR}${EDITHDIR}/bin
.for i in defaults help
	@${MKDIR} ${STAGEDIR}${EDITHDIR}/${i}
	${INSTALL_DATA} ${WRKSRC}/${i}/* ${STAGEDIR}${EDITHDIR}/${i}
.endfor
	${INSTALL_MAN} ${WRKSRC}/edith.1 ${STAGEDIR}${MANPREFIX}/man/man1

.include <bsd.port.mk>
