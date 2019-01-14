#!/bin/bash
until [ -f $COMPOSER_PROJECT_FILE_PATH ]; do
  (>&2 echo "waiting for source...") && ls  -la /source && sleep 2
done

cd $COMPOSER_PROJECT_PATH && composer install --ignore-platform-reqs && tail -f /dev/null

while inotifywait -q -e modify $COMPOSER_PROJECT_FILE_PATH >/dev/null; do
    cd $COMPOSER_PROJECT_PATH && composer install --ignore-platform-reqs
done
