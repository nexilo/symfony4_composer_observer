#!/bin/bash
until [ -f $COMPOSER_PROJECT_FILE_PATH ]; do
  (>&2 echo "waiting for source...") && ls  -la /source && sleep 2
done

cd $COMPOSER_PROJECT_PATH && composer install --ignore-platform-reqs

while inotifywait -q -e modify $COMPOSER_PROJECT_FILE_PATH >/dev/null; do
    cd $COMPOSER_PROJECT_PATH
    composer install --ignore-platform-reqs
    chmod -R 777 var/cache || true
    chmod -R 777 var/log || true
    chmod -R 777 vendor/openpayu/openpayu/lib/OpenPayU/Oauth/Cache/../../../Cache || true
done
