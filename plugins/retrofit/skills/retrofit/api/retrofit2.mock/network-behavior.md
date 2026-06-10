# API Reference

> Last updated 2026-06-09 · Retrofit 3.x

# NetworkBehavior

Package `retrofit2.mock` · Artifact `com.squareup.retrofit2:retrofit-mock`

```java
public final class NetworkBehavior
```

A simple emulation of the behavior of network calls. Models three properties of a network:

- **Delay** — the time before a response is received (successful or otherwise).
- **Variance** — the amount of fluctuation of the delay, faster or slower.
- **Failure** — the percentage of operations which fail (e.g. `IOException`).

Apply behavior to a Retrofit interface with [`MockRetrofit`](mock-retrofit.md), or use [`calculateDelay`](#calculatedelay) and [`calculateIsFailure`](#calculateisfailure) directly elsewhere.

By default, instances use a 2 second delay with 40% variance. Failures occur 3% of the time; HTTP errors occur 0% of the time.

## Public Methods

### create

```java
static NetworkBehavior create()
static NetworkBehavior create(java.util.Random random)
```

Create an instance with default behavior. The overload uses `random` to control variance and failure calculation.

### delay / setDelay

```java
long delay(java.util.concurrent.TimeUnit unit)
void setDelay(long amount, java.util.concurrent.TimeUnit unit)
```

Get or set the network round-trip delay.

### variancePercent / setVariancePercent

```java
int variancePercent()
void setVariancePercent(int variancePercent)
```

Get or set the plus-or-minus variance percentage of the round-trip delay.

### failurePercent / setFailurePercent

```java
int failurePercent()
void setFailurePercent(int failurePercent)
```

Get or set the percentage of calls to [`calculateIsFailure`](#calculateisfailure) that return `true`.

### failureException / setFailureException

```java
java.lang.Throwable failureException()
void setFailureException(java.lang.Throwable exception)
```

Get or set the exception to be used when a failure is triggered. It is best practice to remove the stack trace from `exception` since it can misleadingly point to unrelated code.

### errorPercent / setErrorPercent

```java
int errorPercent()
void setErrorPercent(int errorPercent)
```

Get or set the percentage of calls to [`calculateIsError`](#calculateiserror) that return `true`.

### setErrorFactory

```java
void setErrorFactory(java.util.concurrent.Callable<retrofit2.Response<?>> errorFactory)
```

Set the error response factory used when an error is triggered. This factory may only return responses for which `Response.isSuccessful()` returns false.

### createErrorResponse

```java
retrofit2.Response<?> createErrorResponse()
```

The HTTP error [`Response`](../retrofit2/response.md) to be used when an error is triggered.

### calculateIsFailure

```java
boolean calculateIsFailure()
```

Randomly determine whether this call should result in a network failure. When true, [`failureException`](#failureexception--setfailureexception) should be thrown.

### calculateIsError

```java
boolean calculateIsError()
```

Randomly determine whether this call should result in an HTTP error. When true, [`createErrorResponse`](#createerrorresponse) should be returned.

### calculateDelay

```java
long calculateDelay(java.util.concurrent.TimeUnit unit)
```

Get the delay that should be used for delaying a response in accordance with the configured behavior.
