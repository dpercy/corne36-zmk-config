#!/usr/bin/env bash
set -exuo pipefail

git push
sleep 3  # wait for action to start

latest_run=$(gh run ls -L 1 --json databaseId --jq '.[].databaseId')
gh run watch $latest_run

rm -rf firmware/
if gh run download $latest_run
then
    echo success
    ./flash.sh
else
    status=$?
    gh run view --log-failed $latest_run > fail
    grep -E '(keymap|error):' fail
    exit $?
fi
