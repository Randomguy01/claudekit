# API Reference

> Last updated 2026-06-09 · Retrofit 3.x

# Headers

Package `retrofit2.http`

```java
@Documented
@Target(value=METHOD)
@Retention(value=RUNTIME)
public @interface Headers
```

Adds headers literally supplied in the `value`.

```java
@Headers("Cache-Control: max-age=640000")
@GET("/")
// ...

@Headers({
  "X-Foo: Bar",
  "X-Ping: Pong"
})
@GET("/")
// ...
```

Parameter keys and values only allow ascii values by default. Specify [`allowUnsafeNonAsciiValues=true`](#allowunsafenonasciivalues) to change this behavior.

```java
@Headers(value = { "X-Foo: Bar", "X-Ping: Pong" }, allowUnsafeNonAsciiValues = true)
@GET("/")
// ...
```

**Note:** headers do not overwrite each other. All headers with the same name will be included in the request.

See also [`@Header`](header.md), [`@HeaderMap`](header-map.md).

## Elements

### value

```java
String[] value
```

The header lines, each formatted as `Name: Value`. (Required.)

### allowUnsafeNonAsciiValues

```java
boolean allowUnsafeNonAsciiValues default false
```

Specifies whether the header values are allowed to contain unsafe non-ascii values.
