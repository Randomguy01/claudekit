# API Reference

> Last updated 2026-06-09 · Retrofit 3.x

# Retrofit

Package `retrofit2`

```java
public final class Retrofit
```

Retrofit adapts a Java interface to HTTP calls by using annotations on the declared methods to define how requests are made. Create instances using [the builder](retrofit-builder.md) and pass your interface to [`create`](#create) to generate an implementation.

```java
Retrofit retrofit = new Retrofit.Builder()
    .baseUrl("https://api.example.com/")
    .addConverterFactory(GsonConverterFactory.create())
    .build();

MyApi api = retrofit.create(MyApi.class);
Response<User> user = api.getUser().execute();
```

## Nested Types

| Type | Description |
|------|-------------|
| [`Retrofit.Builder`](retrofit-builder.md) | Build a new `Retrofit`. |

## Public Methods

### create

```java
<T> T create(java.lang.Class<T> service)
```

Create an implementation of the API endpoints defined by the `service` interface.

The relative path for a given method is obtained from an annotation on the method describing the request type. The built-in methods are [`@GET`](../retrofit2.http/get.md), [`@PUT`](../retrofit2.http/put.md), [`@POST`](../retrofit2.http/post.md), [`@PATCH`](../retrofit2.http/patch.md), [`@HEAD`](../retrofit2.http/head.md), [`@DELETE`](../retrofit2.http/delete.md), and [`@OPTIONS`](../retrofit2.http/options.md). Use a custom HTTP method with [`@HTTP`](../retrofit2.http/http.md). For a dynamic URL, omit the path on the annotation and annotate the first parameter with [`@Url`](../retrofit2.http/url.md).

Method parameters can replace parts of the URL by annotating them with [`@Path`](../retrofit2.http/path.md). Replacement sections are denoted by an identifier surrounded by curly braces (e.g., `{foo}`). Add items to the query string with [`@Query`](../retrofit2.http/query.md).

The body of a request is denoted by [`@Body`](../retrofit2.http/body.md); the object is converted by one of the [`Converter.Factory`](converter-factory.md) instances. A `RequestBody` can be used for a raw representation. Alternative request body formats:

- [`@FormUrlEncoded`](../retrofit2.http/form-url-encoded.md) — form-encoded key-value pairs specified by [`@Field`](../retrofit2.http/field.md).
- [`@Multipart`](../retrofit2.http/multipart.md) — RFC 2388 multipart data with parts specified by [`@Part`](../retrofit2.http/part.md).

Static headers can be added with the [`@Headers`](../retrofit2.http/headers.md) method annotation; per-request headers with the [`@Header`](../retrofit2.http/header.md) parameter annotation.

By default, methods return a [`Call`](call.md) representing the HTTP request, whose generic parameter is the response body type. `ResponseBody` can be used for a raw representation and `Void` if the body is not needed.

```java
public interface CategoryService {
  @POST("category/{cat}/")
  Call<List<Item>> categoryList(@Path("cat") String a, @Query("page") int b);
}
```

### callFactory

```java
okhttp3.Call.Factory callFactory()
```

The factory used to create OkHttp calls for sending HTTP requests. Typically an instance of `OkHttpClient`.

### baseUrl

```java
okhttp3.HttpUrl baseUrl()
```

The API base URL.

### callAdapterFactories

```java
java.util.List<CallAdapter.Factory> callAdapterFactories()
```

Returns a list of the factories tried when creating a [`callAdapter`](#calladapter) call adapter.

### callAdapter

```java
CallAdapter<?, ?> callAdapter(java.lang.reflect.Type returnType,
                              java.lang.annotation.Annotation[] annotations)
```

Returns the [`CallAdapter`](call-adapter.md) for `returnType` from the available [factories](#calladapterfactories). Throws `java.lang.IllegalArgumentException` if no call adapter is available for the type.

### nextCallAdapter

```java
CallAdapter<?, ?> nextCallAdapter(@Nullable CallAdapter.Factory skipPast,
                                  java.lang.reflect.Type returnType,
                                  java.lang.annotation.Annotation[] annotations)
```

Returns the [`CallAdapter`](call-adapter.md) for `returnType` from the available [factories](#calladapterfactories) except `skipPast`. Throws `java.lang.IllegalArgumentException` if no call adapter is available for the type.

### converterFactories

```java
java.util.List<Converter.Factory> converterFactories()
```

Returns an unmodifiable list of the factories tried when creating a [`requestBodyConverter`](#requestbodyconverter), a [`responseBodyConverter`](#responsebodyconverter), or a [`stringConverter`](#stringconverter).

### requestBodyConverter

```java
<T> Converter<T, okhttp3.RequestBody> requestBodyConverter(
    java.lang.reflect.Type type,
    java.lang.annotation.Annotation[] parameterAnnotations,
    java.lang.annotation.Annotation[] methodAnnotations)
```

Returns a [`Converter`](converter.md) for `type` to `RequestBody` from the available [factories](#converterfactories). Throws `java.lang.IllegalArgumentException` if no converter is available for the type.

### nextRequestBodyConverter

```java
<T> Converter<T, okhttp3.RequestBody> nextRequestBodyConverter(
    @Nullable Converter.Factory skipPast,
    java.lang.reflect.Type type,
    java.lang.annotation.Annotation[] parameterAnnotations,
    java.lang.annotation.Annotation[] methodAnnotations)
```

Returns a [`Converter`](converter.md) for `type` to `RequestBody` from the available [factories](#converterfactories) except `skipPast`. Throws `java.lang.IllegalArgumentException` if no converter is available for the type.

### responseBodyConverter

```java
<T> Converter<okhttp3.ResponseBody, T> responseBodyConverter(
    java.lang.reflect.Type type,
    java.lang.annotation.Annotation[] annotations)
```

Returns a [`Converter`](converter.md) for `ResponseBody` to `type` from the available [factories](#converterfactories). Throws `java.lang.IllegalArgumentException` if no converter is available for the type.

### nextResponseBodyConverter

```java
<T> Converter<okhttp3.ResponseBody, T> nextResponseBodyConverter(
    @Nullable Converter.Factory skipPast,
    java.lang.reflect.Type type,
    java.lang.annotation.Annotation[] annotations)
```

Returns a [`Converter`](converter.md) for `ResponseBody` to `type` from the available [factories](#converterfactories) except `skipPast`. Throws `java.lang.IllegalArgumentException` if no converter is available for the type.

### stringConverter

```java
<T> Converter<T, java.lang.String> stringConverter(
    java.lang.reflect.Type type,
    java.lang.annotation.Annotation[] annotations)
```

Returns a [`Converter`](converter.md) for `type` to `String` from the available [factories](#converterfactories).

### callbackExecutor

```java
@Nullable
java.util.concurrent.Executor callbackExecutor()
```

The executor used for [`Callback`](callback.md) methods on a [`Call`](call.md). May be `null`, in which case callbacks should be made synchronously on the background thread.

### newBuilder

```java
Retrofit.Builder newBuilder()
```

Returns a new [`Retrofit.Builder`](retrofit-builder.md) seeded with the configuration of this instance.
