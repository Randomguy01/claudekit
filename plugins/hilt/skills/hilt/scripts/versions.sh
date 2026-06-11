#!/bin/sh
# Usage: versions.sh [--all] [artifact]
#   artifact selects which pinned dependency to query (default: hilt):
#     hilt         com.google.dagger:hilt-android, hilt-android-compiler, hilt-compiler,
#                  hilt-android-testing (all Hilt/Dagger artifacts share one version)
#     hilt-plugin  com.google.dagger.hilt.android Gradle plugin
#     androidx-hilt androidx.hilt:* Jetpack extensions (hilt-navigation-compose,
#                  hilt-navigation-fragment, hilt-work, hilt-compiler — versioned
#                  independently of the Dagger artifacts above; all share one version)
#     ksp          com.google.devtools.ksp Gradle plugin (version tracks the Kotlin version)
#   --all  print every published version (oldest first); default prints the latest stable
#
# Stable releases never carry a pre-release suffix, so the default case filters
# the <version> list to plain numeric versions rather than trusting <release>/
# <latest>, which for some groups can point at a pre-release.

artifact=hilt
all=0
for arg in "$@"; do
  case "$arg" in
    --all) all=1 ;;
    -*)    echo "versions.sh: unknown option '$arg'" >&2; exit 2 ;;
    *)     artifact=$arg ;;
  esac
done

case "$artifact" in
  hilt)
    url="https://repo1.maven.org/maven2/com/google/dagger/hilt-android/maven-metadata.xml" ;;
  hilt-plugin)
    url="https://plugins.gradle.org/m2/com/google/dagger/hilt/android/com.google.dagger.hilt.android.gradle.plugin/maven-metadata.xml" ;;
  androidx-hilt)
    url="https://dl.google.com/android/maven2/androidx/hilt/hilt-navigation-compose/maven-metadata.xml" ;;
  ksp)
    url="https://plugins.gradle.org/m2/com/google/devtools/ksp/com.google.devtools.ksp.gradle.plugin/maven-metadata.xml" ;;
  *)
    echo "versions.sh: unknown artifact '$artifact'" >&2
    echo "  known: hilt, hilt-plugin, androidx-hilt, ksp" >&2
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
