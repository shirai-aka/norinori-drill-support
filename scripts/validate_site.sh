#!/bin/sh
set -eu

expected_name='ノリノリドリル'
expected_bundle='com.shirai.abcfever'
forbidden_names='論理の塔 ドーパミン ABCフィーバー LOGIC AdMob'

files='index.html support/index.html privacy-policy/index.html index.en.html support/index.en.html privacy-policy/index.en.html'

for file in $files; do
  test -f "$file"
  grep -Fq "$expected_name" "$file"
  for forbidden in $forbidden_names; do
    if grep -Fq "$forbidden" "$file"; then
      echo "ERROR: 別アプリ名・対象外の語が含まれています: $file ($forbidden)" >&2
      exit 1
    fi
  done
done

grep -Fq "$expected_name" site-identity.json
grep -Fq "$expected_bundle" site-identity.json
grep -Fq '広告は表示しません' privacy-policy/index.html
grep -Fq '通信を行いません' privacy-policy/index.html
grep -Fq '保護者ゲート' privacy-policy/index.html
grep -Fq 'App Tracking Transparency' privacy-policy/index.html
grep -Fq 'shirai.apps@ymail.ne.jp' privacy-policy/index.html
grep -Fq 'shirai.apps@ymail.ne.jp' support/index.html

echo 'SITE_VALIDATION_PASS / NORINORI DRILL / 6 PAGES'
