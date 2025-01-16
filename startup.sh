#!/bin/bash
export CALIBRE_CONFIG_DIRECTORY=/config/.config
export CALIBRE_CACHE_DIRECTORY=/config/.cache

CALIBRE_BIN=/opt/calibre/calibre-server
USER_DB=$CALIBRE_CONFIG_DIRECTORY/users.sqlite
USER_INIT=$CALIBRE_CONFIG_DIRECTORY/.user-init

ls -la /config

if [ ! -z "${ENABLE_AUTH}" ]; then
	echo "=====Auth Enabled====="
	# Check to see if userdb exists, if not create it
	if [ ! -f $USER_INIT ]; then
		echo "=====Creating User db====="
		$CALIBRE_BIN --manage-users -- add ${USERNAME:-user} ${PASSWORD:-password}
		touch $USER_INIT
	fi
	# start calibre-server
	/opt/calibre/calibre-server --port ${PORT:-8080} --enable-auth /data
		
else
	echo "=====Auth Disabled====="
	# start calibre-server without auth
	/opt/calibre/calibre-server --port ${PORT:-8080} /data
fi
