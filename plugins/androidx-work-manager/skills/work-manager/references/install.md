# Installing WorkManager

## Latest Version

Run [versions.sh](../scripts/versions.sh) to get the latest stable version, or `versions.sh --all` to list every published version.
Default to the latest stable version unless instructed otherwise.

## Dependencies

Required (one of):
- `androidx.work:work-runtime` - Java Only Project
- `androidx.work:work-runtime-ktx` - Kotlin Project

Optional:
- RxJava2 Support: `androidx.work:work-rxjava2`
- RxJava3 Support: `androidx.work:work-rxjava3`
- GCMNetworkManager Support: `androidx.work:work-gcm`
- Test Helpers: `androidx.work:work-testing`
- Multiprocess Suport: `androidx.work:work-multiprocess`
