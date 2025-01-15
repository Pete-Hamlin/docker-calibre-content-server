#!/bin/bash

# start calibre-server
/opt/calibre/calibre-server --port ${PORT:-8080} /data/library
