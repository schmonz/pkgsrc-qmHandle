# $NetBSD: Makefile,v 1.30 2020/08/31 18:10:08 wiz Exp $
#

DISTNAME=		qmhandle-1.3.2
PKGNAME=		${DISTNAME:S/h/H/}
PKGREVISION=		8
CATEGORIES=		mail
MASTER_SITES=		${MASTER_SITE_SOURCEFORGE:=qmhandle/}

MAINTAINER=		schmonz@NetBSD.org
HOMEPAGE=		http://qmhandle.sourceforge.net/
COMMENT=		Tool to view and manage the qmail message queue
LICENSE=		gnu-gpl-v2

USE_TOOLS+=		perl:run
REPLACE_PERL=		qmHandle
NO_BUILD=		YES

SUBST_CLASSES+=		config
SUBST_STAGE.config=	do-configure
SUBST_FILES.config=	qmHandle
SUBST_SED.config=	-e 's|/var/qmail/queue/|${QMAIL_QUEUE_DIR}/|g'
SUBST_SED.config+=	-e 's|/etc/init.d/qmail|${RCD_SCRIPTS_DIR}/qmail|g'
.if exists(/usr/bin/pgrep)
SUBST_SED.config+=	-e 's|pidof|/usr/bin/pgrep|g'
.endif

INSTALLATION_DIRS=	bin share/doc/qmHandle
BUILD_DEFS+=		QMAIL_QUEUE_DIR RCD_SCRIPTS_DIR

do-install:
	${INSTALL_SCRIPT} ${WRKSRC}/qmHandle ${DESTDIR}${PREFIX}/bin
	${INSTALL_DATA} ${WRKSRC}/README ${DESTDIR}${PREFIX}/share/doc/qmHandle

.include "../../mk/bsd.pkg.mk"
