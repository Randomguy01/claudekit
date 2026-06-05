#!/bin/sh
url="https://dl.google.com/dl/android/maven2/androidx/room/room-runtime/maven-metadata.xml"
curl -s "$url" | grep -oP '(?<=<latest>).*?(?=</latest>)'
