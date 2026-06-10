#!/bin/sh
# Usage: versions.sh [--all]
#   (default) print the latest stable release version
#   --all     print every published version (oldest first)
url="https://dl.google.com/dl/android/maven2/androidx/work/work-runtime/maven-metadata.xml"
meta=$(curl -fsSL "$url") || {
  echo "versions.sh: failed to fetch $url" >&2
  exit 1
}
case "$1" in
  --all) tag=version ;;
  *)     tag=release ;;
esac
printf '%s\n' "$meta" \
  | grep -oE "<$tag>[^<]+</$tag>" \
  | sed -e "s|<$tag>||" -e "s|</$tag>||"
