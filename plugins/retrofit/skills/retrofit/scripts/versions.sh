#!/bin/sh
# Usage: versions.sh [--all]
#   (default) print the latest stable release version
#   --all     print every published version (oldest first)
url="https://repo1.maven.org/maven2/com/squareup/retrofit2/retrofit/maven-metadata.xml"
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
