# API Reference

> Last updated 2026-06-09 · Retrofit 3.x

# HeaderMap

Package `retrofit2.http`

```java
@Documented
@Target(value=PARAMETER)
@Retention(value=RUNTIME)
public @interface HeaderMap
```

Adds headers specified in the `Map` or `Headers`.

Values in the map are converted to strings using [`Retrofit.stringConverter`](../retrofit2/retrofit.md#stringconverter) (or `Object.toString()`, if no matching string converter is installed).

```java
@GET("/search")
void list(@HeaderMap Map<String, String> headers);

// The following call yields /search with headers
// Accept: text/plain and Accept-Charset: utf-8
foo.list(ImmutableMap.of("Accept", "text/plain", "Accept-Charset", "utf-8"));
```

Map keys and values allow only ascii values by default. Specify [`allowUnsafeNonAsciiValues=true`](#allowunsafenonasciivalues) to change this behavior.

```java
@GET("/search")
void list(@HeaderMap(allowUnsafeNonAsciiValues = true) Map<String, String> headers);
```

See also [`@Header`](header.md), [`@Headers`](headers.md).

## Elements

### allowUnsafeNonAsciiValues

```java
boolean allowUnsafeNonAsciiValues default false
```

Specifies whether the parameter values are allowed to contain unsafe non-ascii values.
