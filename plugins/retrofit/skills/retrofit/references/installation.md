# Installation

The Retrofit source code, its samples, and this documentation are [available on GitHub](https://github.com/square/retrofit).

> [!IMPORTANT]
> Retrofit requires at minimum Java 8+ or Android API 21+.

## Gradle

```kotlin
implementation("com.squareup.retrofit2:retrofit:3.0.0")
```

## Maven

```xml
<dependency>
  <groupId>com.squareup.retrofit2</groupId>
  <artifactId>retrofit</artifactId>
  <version>3.0.0</version>
</dependency>
```

> [!TIP]
> Run [`scripts/versions.sh`](../scripts/versions.sh) to determine the version to depend on, rather than relying on the pinned `3.0.0` above:
> ```sh
> scripts/versions.sh        # latest stable release
> scripts/versions.sh --all  # every published version, oldest first
> ```
> The script reads Retrofit's [Maven Central metadata](https://repo1.maven.org/maven2/com/squareup/retrofit2/retrofit/maven-metadata.xml).

## R8 / ProGuard

R8 includes the shrinking and obfuscation rules automatically.

ProGuard users must manually add the options from [retrofit2.pro](https://github.com/square/retrofit/blob/master/retrofit/src/main/resources/META-INF/proguard/retrofit2.pro). Rules for [OkHttp](https://square.github.io/okhttp/r8_proguard) and [Okio](https://github.com/square/okio#r8--proguard) may also be required, since both are dependencies of Retrofit.
