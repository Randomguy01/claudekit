# API Reference

> Last updated 2026-06-09 · Retrofit 3.x

# Field

Package `retrofit2.http`

```java
@Documented
@Target(value=PARAMETER)
@Retention(value=RUNTIME)
public @interface Field
```

Named pair for a form-encoded request.

Values are converted to strings using [`Retrofit.stringConverter`](../retrofit2/retrofit.md#stringconverter) (or `Object.toString()`, if no matching string converter is installed) and then form URL encoded. `null` values are ignored. Passing a `List` or array will result in a field pair for each non-`null` item.

```java
@FormUrlEncoded
@POST("/")
Call<ResponseBody> example(
    @Field("name") String name,
    @Field("occupation") String occupation);
```

Calling with `foo.example("Bob Smith", "President")` yields a request body of `name=Bob+Smith&occupation=President`.

Array/varargs:

```java
@FormUrlEncoded
@POST("/list")
Call<ResponseBody> example(@Field("name") String... names);
```

Calling with `foo.example("Bob Smith", "Jane Doe")` yields a request body of `name=Bob+Smith&name=Jane+Doe`.

See also [`@FormUrlEncoded`](form-url-encoded.md), [`@FieldMap`](field-map.md).

## Elements

### value

```java
String value
```

The form field name. (Required.)

### encoded

```java
boolean encoded default false
```

Specifies whether the [name](#value) and value are already URL encoded.
