#!/usr/bin/env bash
set -e
export IDF_CCACHE_ENABLE=1

. $IDF_PATH/export.sh
. /opt/esp/esp-matter/export.sh

exec "$@"
