#!/bin/sh
# Usage: versions.sh [--all] [artifact]
#   artifact selects which pinned dependency to query (default: datastore):
#     datastore                    androidx.datastore:*  (all share one version)
#     kotlinx-serialization-json   org.jetbrains.kotlinx:kotlinx-serialization-json
#     kotlin-serialization-plugin  org.jetbrains.kotlin.plugin.serialization Gradle plugin
#     protobuf                     com.google.protobuf:protobuf-kotlin-lite  (protoc shares this version)
#     protobuf-plugin              com.google.protobuf Gradle plugin
#   --all  print every published version (oldest first); default prints the latest stable
#
# Stable releases never carry a pre-release suffix, so the default case filters
# the <version> list to plain numeric versions rather than trusting <release>/
# <latest>, which for some of these groups point at a pre-release.

artifact=datastore
all=0
for arg in "$@"; do
  case "$arg" in
    --all) all=1 ;;
    -*)    echo "versions.sh: unknown option '$arg'" >&2; exit 2 ;;
    *)     artifact=$arg ;;
  esac
done

case "$artifact" in
  datastore)
    url="https://dl.google.com/dl/android/maven2/androidx/datastore/datastore-preferences/maven-metadata.xml" ;;
  kotlinx-serialization-json)
    url="https://repo1.maven.org/maven2/org/jetbrains/kotlinx/kotlinx-serialization-json/maven-metadata.xml" ;;
  kotlin-serialization-plugin)
    url="https://plugins.gradle.org/m2/org/jetbrains/kotlin/plugin/serialization/org.jetbrains.kotlin.plugin.serialization.gradle.plugin/maven-metadata.xml" ;;
  protobuf)
    url="https://repo1.maven.org/maven2/com/google/protobuf/protobuf-kotlin-lite/maven-metadata.xml" ;;
  protobuf-plugin)
    url="https://plugins.gradle.org/m2/com/google/protobuf/com.google.protobuf.gradle.plugin/maven-metadata.xml" ;;
  *)
    echo "versions.sh: unknown artifact '$artifact'" >&2
    echo "  known: datastore, kotlinx-serialization-json, kotlin-serialization-plugin, protobuf, protobuf-plugin" >&2
    exit 2 ;;
esac

meta=$(curl -fsSL "$url") || {
  echo "versions.sh: failed to fetch $url" >&2
  exit 1
}
# Pull only the entries inside <versions>...</versions>; the Gradle Plugin Portal
# metadata also carries a top-level <version>, which this skips.
versions=$(printf '%s' "$meta" \
  | tr -d '\n' \
  | sed -n 's|.*<versions>\(.*\)</versions>.*|\1|p' \
  | grep -oE "<version>[^<]+</version>" \
  | sed -e "s|<version>||" -e "s|</version>||")
if [ "$all" -eq 1 ]; then
  printf '%s\n' "$versions"
else
  # Stable releases are plain numeric (no -alpha/-beta/-rc/-M suffix).
  printf '%s\n' "$versions" | grep -E '^[0-9]+(\.[0-9]+)*$' | tail -n 1
fi
