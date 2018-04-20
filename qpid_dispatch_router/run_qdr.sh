#!/bin/sh

export HOSTNAME_IP_ADDRESS=$(hostname -i)

DOLLAR='$' envsubst < /etc/qpid-dispatch/qdrouterd.conf.template > /tmp/qdrouterd.conf
if [ -z "$DISABLE_AUTO_APPEND_CONNECTORS" ]; then
    INDEX=$(echo "$HOSTNAME" | rev | cut -f1 -d-)
    PREFIX=$(echo "$HOSTNAME" | rev | cut -f2- -d- | rev)
    COUNT=0
    while [ $COUNT -lt $INDEX ]; do
        cat <<EOF >> /tmp/qdrouterd.conf
connector {
    name: $PREFIX-$COUNT
    host: $PREFIX-$COUNT.$(hostname -d)
    port: 55672
    role: inter-router
    sslProfile: inter_router_tls
}
EOF
        let COUNT=COUNT+1
    done
fi

exec /sbin/qdrouterd --conf /tmp/qdrouterd.conf
