#!/bin/sh
set -eu

NAMED_USER=named
NAMED_CONF=/etc/named.conf

cp -f ${NAMED_CONF}.tmpl ${NAMED_CONF}
chown root:named ${NAMED_CONF}
chmod 640 ${NAMED_CONF}

named-checkconf "${NAMED_CONF}"
exec /usr/sbin/named -4 -c ${NAMED_CONF} -u ${NAMED_USER} -f
