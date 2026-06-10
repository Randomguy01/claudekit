# API Reference

> Last updated 2026-06-09 · Retrofit 3.x

# Header

Package `retrofit2.http`

```java
@Documented
@Retention(value=RUNTIME)
@Target(value=PARAMETER)
public @interface Header
```

Replaces the header with the value of its target.

```java
@GET("/")
Call<ResponseBody> foo(@Header("Accept-Language") String lang);
```

Header parameters may be `null`, which will omit them from the request. Passing a `List` or array will result in a header for each non-`null` item.

Parameter keys and values only allow ascii values by default. Specify [`allowUnsafeNonAsciiValues=true`](#allowunsafenonasciivalues) to change this behavior.

```java
@GET("/")
Call<ResponseBody> foo(@Header(value = "Accept-Language", allowUnsafeNonAsciiValues = true) String lang);
```

**Note:** headers do not overwrite each other. All headers with the same name will be included in the request.

See also [`@Headers`](headers.md), [`@HeaderMap`](header-map.md).

## Elements

### value

```java
String value
```

The header name. (Required.)

### allowUnsafeNonAsciiValues

```java
boolean allowUnsafeNonAsciiValues default false
```

Specifies whether the parameter value is allowed to contain unsafe non-ascii values.
