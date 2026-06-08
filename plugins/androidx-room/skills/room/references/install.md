# Installing Room

## Latest Version

Run [versions.sh](../scripts/versions.sh) to get the latest stable version, or `versions.sh --all` to list every published version.
Default to the latest stable version unless instructed otherwise.

## Dependencies (app-level)

Required:
- `androidx.room:room-runtime`
- Kotlin Symbol Processing (KSP): `ksp("androidx.room:room-compiler")` — for projects with Kotlin source
- Java annotation processor: `annotationProcessor("androidx.room:room-compiler")` — for Java-only projects

> [!NOTE]
> Choose only one of `ksp` or `annotationProcessor` — don't include both.

Optional:
- Kotlin Extensions & Coroutine Support: `androidx.room:room-ktx`
- RxJava2 Support: `androidx.room:room-rxjava2`
- RxJava3 Support: `androidx.room:room-rxjava3`
- Guava Support (including Optional and ListenableFuture): `androidx.room:room-guava`
- Test Helpers: `androidx.room:room-testing`
- Paging 3 Integration: `androidx.room:room-paging`

## Plugins (app-level)

Optional:
- `androidx.room`


## Instructions

Install all required dependencies and plugins, then determine whether any optional dependencies or plugins are necessary.
