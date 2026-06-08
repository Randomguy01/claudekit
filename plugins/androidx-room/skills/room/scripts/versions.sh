#!/bin/sh
# Usage: versions.sh [--all]
#   (default) print the latest stable release version
#   --all     print every published version (oldest first)
url="https://dl.google.com/dl/android/maven2/androidx/room/room-runtime/maven-metadata.xml"
meta=$(curl -s "$url")
case "$1" in
  --all) printf '%s\n' "$meta" | grep -oP '(?<=<version>).*?(?=</version>)' ;;
  *)     printf '%s\n' "$meta" | grep -oP '(?<=<release>).*?(?=</release>)' ;;
esac
