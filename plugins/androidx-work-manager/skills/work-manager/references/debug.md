# Debugging WorkManager

If your workers run too often or not at all, these steps help you discover what's happening.

## Enable Logging

To find out why workers aren't running properly, look at *verbose* WorkManager logs. Enable logging with [custom initialization](custom-configuration.md).

First, disable the default `WorkManagerInitializer` in `AndroidManifest.xml` by declaring a WorkManager provider with the manifest-merge rule `remove`:

```xml
<provider
    android:name="androidx.work.impl.WorkManagerInitializer"
    android:authorities="${applicationId}.workmanager-init"
    tools:node="remove"/>
```

With the default initializer disabled, use [on-demand initialization](custom-configuration.md#on-demand-initialization): have your `Application` class implement `Configuration.Provider`:

```kotlin
class MyApplication() : Application(), Configuration.Provider {
    override fun getWorkManagerConfiguration() =
        Configuration.Builder()
            .setMinimumLoggingLevel(android.util.Log.DEBUG)
            .build()
}
```

With a custom configuration, WorkManager initializes when you call [`WorkManager.getInstance(Context)`](../api/androidx.work/work-manager.md) rather than automatically at startup. See [Customizing WorkManager configuration and initialization](custom-configuration.md), including support for versions before 2.1.0.

With `DEBUG` logging enabled, you see many more logs with the log-tag prefix `WM-`.

## Inspect Scheduled Jobs with dumpsys

**Requires Android 6.0 (API level 23)+** — use `adb` to inspect job scheduling. (New to `adb`? See [Command-line tools](https://developer.android.com/studio/command-line).)

List the jobs attributed to your package:

```shell
adb shell dumpsys jobscheduler
```

The output looks something like this:

```
JOB #u0a172/4: 6412553 com.google.android.youtube/androidx.work.impl.background.systemjob.SystemJobService
  u0a172 tag=*job*/com.google.android.youtube/androidx.work.impl.background.systemjob.SystemJobService
  Source: uid=u0a172 user=0 pkg=com.google.android.youtube
  JobInfo:
    Service: com.google.android.youtube/androidx.work.impl.background.systemjob.SystemJobService
    Requires: charging=false batteryNotLow=false deviceIdle=false
    Network type: NetworkRequest [ NONE id=0, [ Capabilities: NOT_METERED&INTERNET&NOT_RESTRICTED&TRUSTED&VALIDATED Uid: 10172] ]
    Minimum latency: +1h29m59s687ms
    Backoff: policy=1 initial=+30s0ms
  Required constraints: TIMING_DELAY CONNECTIVITY [0x90000000]
  Satisfied constraints: DEVICE_NOT_DOZING BACKGROUND_NOT_RESTRICTED WITHIN_QUOTA [0x3400000]
  Unsatisfied constraints: TIMING_DELAY CONNECTIVITY [0x90000000]
  Standby bucket: RARE
  Enqueue time: -51m29s853ms
  Run time: earliest=+38m29s834ms, latest=none, original latest=none
  Ready: false (job=false user=true !pending=true !active=true !backingup=true comp=true)
```

On API level 23 and higher, WorkManager's worker-execution component is `SystemJobService`. Look for jobs attributed to your package name and `androidx.work.impl.background.systemjob.SystemJobService`. For each job, the output lists **required**, **satisfied**, and **unsatisfied** constraints — check whether your worker's constraints are fully satisfied.

The output also includes job history for recently executed jobs, so you can check whether `SystemJobService` was invoked recently:

```
Job history:
     -1h35m26s440ms   START: #u0a107/9008 com.google.android.youtube/androidx.work.impl.background.systemjob.SystemJobService
     -1h35m26s362ms  STOP-P: #u0a107/9008 com.google.android.youtube/androidx.work.impl.background.systemjob.SystemJobService app called jobFinished
```

## Request Diagnostic Information

**Requires WorkManager 2.4.0+** — on debug builds of your app, request diagnostic information:

```shell
adb shell am broadcast -a "androidx.work.diagnostics.REQUEST_DIAGNOSTICS" -p "<your_app_package_name>"
```

This reports:

- Work requests that completed in the last 24 hours.
- Work requests that are currently running.
- Work requests that are scheduled.

The output is visible through `logcat`:

```
adb logcat
...
I/WM-DiagnosticsWrkr: Recently completed work:
I/WM-DiagnosticsWrkr: Id  Class Name   State  Unique Name Tags
    08be261c-2def-4bd6-a716-1e4410968dc4  androidx.work.impl.workers.DiagnosticsWorker   SUCCEEDED  null  androidx.work.impl.workers.DiagnosticsWorker
    23136bcd-01dd-46eb-b910-0fe8a140c2a4  androidx.work.integration.testapp.ToastWorker  SUCCEEDED  null  androidx.work.integration.testapp.ToastWorker
I/WM-DiagnosticsWrkr: Running work:
    b87c8a4f-4ac6-4e25-ba3e-4cea53ce468a  androidx.work.impl.workers.DiagnosticsWorker   RUNNING    null  androidx.work.impl.workers.DiagnosticsWorker
...
```
