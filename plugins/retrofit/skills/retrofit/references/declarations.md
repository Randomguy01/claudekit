# Declaring HTTP Requests

Annotations on the interface methods and their parameters indicate how a request is handled.

## Request Method

Every method must have an HTTP annotation that provides the request method and relative URL. There are eight built-in annotations: [`HTTP`](../api/retrofit2.http/http.md), [`GET`](../api/retrofit2.http/get.md), [`POST`](../api/retrofit2.http/post.md), [`PUT`](../api/retrofit2.http/put.md), [`PATCH`](../api/retrofit2.http/patch.md), [`DELETE`](../api/retrofit2.http/delete.md), [`OPTIONS`](../api/retrofit2.http/options.md), and [`HEAD`](../api/retrofit2.http/head.md). The relative URL of the resource is specified in the annotation.

```java
@GET("users/list")
```

Specify static query parameters directly on the relative URL.

```java
@GET("users/list?sort=desc")
```

## URL Manipulation

Update a request URL dynamically using replacement blocks and parameters on the method. A replacement block is an alphanumeric string surrounded by `{` and `}`. A corresponding parameter must be annotated with [`@Path`](../api/retrofit2.http/path.md) using the same string.

```java
@GET("group/{id}/users")
Call<List<User>> groupList(@Path("id") int groupId);
```

Add query parameters with [`@Query`](../api/retrofit2.http/query.md).

```java
@GET("group/{id}/users")
Call<List<User>> groupList(@Path("id") int groupId, @Query("sort") String sort);
```

For complex query parameter combinations, use a `Map` with [`@QueryMap`](../api/retrofit2.http/query-map.md).

```java
@GET("group/{id}/users")
Call<List<User>> groupList(@Path("id") int groupId, @QueryMap Map<String, String> options);
```

## Request Body

Specify an object as the HTTP request body with the [`@Body`](../api/retrofit2.http/body.md) annotation.

```java
@POST("users/new")
Call<User> createUser(@Body User user);
```

Retrofit converts the object using a converter configured on the `Retrofit` instance. Without a converter, only `RequestBody` can be used.

> [!NOTE]
> See [`configuration.md`](configuration.md) for adding converters such as Gson, Moshi, or Kotlin serialization.

## Form-Encoded and Multipart

Methods can also send form-encoded and multipart data.

Form-encoded data is sent when [`@FormUrlEncoded`](../api/retrofit2.http/form-url-encoded.md) is present on the method. Annotate each key-value pair with [`@Field`](../api/retrofit2.http/field.md) containing the name and the object providing the value.

```java
@FormUrlEncoded
@POST("user/edit")
Call<User> updateUser(@Field("first_name") String first, @Field("last_name") String last);
```

Multipart requests are used when [`@Multipart`](../api/retrofit2.http/multipart.md) is present on the method. Declare parts using the [`@Part`](../api/retrofit2.http/part.md) annotation.

```java
@Multipart
@PUT("user/photo")
Call<User> updateUser(@Part("photo") RequestBody photo, @Part("description") RequestBody description);
```

Multipart parts use one of `Retrofit`'s converters, or they can implement `RequestBody` to handle their own serialization.

## Header Manipulation

Set static headers for a method using the [`@Headers`](../api/retrofit2.http/headers.md) annotation.

```java
@Headers("Cache-Control: max-age=640000")
@GET("widget/list")
Call<List<Widget>> widgetList();
```

```java
@Headers({
"Accept: application/vnd.github.v3.full+json",
"User-Agent: Retrofit-Sample-App"
})
@GET("users/{username}")
Call<User> getUser(@Path("username") String username);
```

> [!NOTE]
> Headers do not overwrite each other. All headers with the same name are included in the request.

Update a request header dynamically using the [`@Header`](../api/retrofit2.http/header.md) annotation, with a corresponding parameter. If the value is null, the header is omitted. Otherwise `toString` is called on the value and the result used.

```java
@GET("user")
Call<User> getUser(@Header("Authorization") String authorization);
```

As with query parameters, use a `Map` with [`@HeaderMap`](../api/retrofit2.http/header-map.md) for complex header combinations.

```java
@GET("user")
Call<User> getUser(@HeaderMap Map<String, String> headers);
```

Specify headers that must be added to every request using an [OkHttp interceptor](https://square.github.io/okhttp/features/interceptors/).

## Synchronous vs. Asynchronous

[`Call`](../api/retrofit2/call.md) instances can be executed either synchronously or asynchronously. Each instance can only be used once, but calling `clone()` creates a new instance that can be used.

> [!NOTE]
> On Android, callbacks are executed on the main thread. On the JVM, callbacks happen on the same thread that executed the HTTP request.

## Kotlin Support

Interface methods support Kotlin suspend functions, which directly return a [`Response`](../api/retrofit2/response.md) object — creating and asynchronously executing the call while suspending the current function.

```kotlin
@GET("users")
suspend fun getUser(): Response<User>
```

A suspend method may also directly return the body.

```kotlin
@GET("users")
suspend fun getUser(): User
```

> [!WARNING]
> When a suspend method returns the body directly, a non-2XX status throws an [`HttpException`](../api/retrofit2/http-exception.md) containing the response.
