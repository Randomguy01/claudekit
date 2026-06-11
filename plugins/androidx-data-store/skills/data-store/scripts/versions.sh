#!/bin/sh
# Usage: versions.sh [--all]
#   (default) print the latest stable release version
#   --all     print every published version (oldest first)
#
# All androidx.datastore:* artifacts share a version, so query one of them.
# Note: this group's maven <release> field tracks pre-releases (e.g. an -alpha),
# so the default case filters the <version> list to stable releases instead of
# trusting <release>.
url="https://dl.google.com/dl/android/maven2/androidx/datastore/datastore-preferences/maven-metadata.xml"
meta=$(curl -fsSL "$url") || {
  echo "versions.sh: failed to fetch $url" >&2
  exit 1
}
versions=$(printf '%s\n' "$meta" \
  | grep -oE "<version>[^<]+</version>" \
  | sed -e "s|<version>||" -e "s|</version>||")
case "$1" in
  --all) printf '%s\n' "$versions" ;;
  # Stable releases have no pre-release suffix (no '-alpha', '-beta', '-rc').
  *)     printf '%s\n' "$versions" | grep -v -- '-' | tail -n 1 ;;
esac
