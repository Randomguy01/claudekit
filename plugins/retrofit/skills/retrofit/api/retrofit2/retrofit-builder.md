# API Reference

> Last updated 2026-06-09 · Retrofit 3.x

# Retrofit.Builder

Package `retrofit2` · Enclosing class [`Retrofit`](retrofit.md)

```java
public static final class Retrofit.Builder
```

Build a new [`Retrofit`](retrofit.md). Calling [`baseUrl`](#baseurl) is required before calling [`build`](#build); all other methods are optional.

## Public Constructors

### Builder

```java
Builder()
```

## Public Methods

### baseUrl

```java
Retrofit.Builder baseUrl(okhttp3.HttpUrl baseUrl)
Retrofit.Builder baseUrl(java.lang.String baseUrl)
Retrofit.Builder baseUrl(java.net.URL baseUrl)
```

Set the API base URL. The `String` and `URL` overloads delegate to the `HttpUrl` form.

Endpoint values (such as on [`@GET`](../retrofit2.http/get.md)) are resolved against this value using `HttpUrl.resolve(String)`, matching how an `<a href="">` link resolves on a website.

**Base URLs should always end in `/`.** A trailing `/` ensures relative endpoint paths append correctly to a base that has path components. This method enforces the trailing `/`.

| Base URL | Endpoint | Result |
|----------|----------|--------|
| `http://example.com/api/` | `foo/bar/` | `http://example.com/api/foo/bar/` |
| `http://example.com/api` | `foo/bar/` | `http://example.com/foo/bar/` (incorrect — no trailing slash) |

Endpoint values with a leading `/` are absolute: they retain only the host from `baseUrl` and ignore its path components.

| Base URL | Endpoint | Result |
|----------|----------|--------|
| `http://example.com/api/` | `/foo/bar/` | `http://example.com/foo/bar/` |

An endpoint may be a full URL. A value with a host replaces the host of `baseUrl`; a value with a scheme replaces the scheme too.

| Base URL | Endpoint | Result |
|----------|----------|--------|
| `http://example.com/` | `https://github.com/square/retrofit/` | `https://github.com/square/retrofit/` |
| `http://example.com` | `//github.com/square/retrofit/` | `http://github.com/square/retrofit/` (scheme stays `http`) |

### client

```java
Retrofit.Builder client(okhttp3.OkHttpClient client)
```

The HTTP client used for requests. A convenience method for calling [`callFactory`](#callfactory).

### callFactory

```java
Retrofit.Builder callFactory(okhttp3.Call.Factory factory)
```

Specify a custom call factory for creating [`Call`](call.md) instances. Calling [`client`](#client) automatically sets this value.

### addConverterFactory

```java
Retrofit.Builder addConverterFactory(Converter.Factory factory)
```

Add a converter factory for serialization and deserialization of objects.

### addCallAdapterFactory

```java
Retrofit.Builder addCallAdapterFactory(CallAdapter.Factory factory)
```

Add a call adapter factory for supporting service method return types other than [`Call`](call.md).

### callbackExecutor

```java
Retrofit.Builder callbackExecutor(java.util.concurrent.Executor executor)
```

The executor on which [`Callback`](callback.md) methods are invoked when returning [`Call`](call.md) from your service method. Not used for [custom method return types](#addcalladapterfactory).

### callAdapterFactories

```java
java.util.List<CallAdapter.Factory> callAdapterFactories()
```

Returns a modifiable list of call adapter factories.

### converterFactories

```java
java.util.List<Converter.Factory> converterFactories()
```

Returns a modifiable list of converter factories.

### validateEagerly

```java
Retrofit.Builder validateEagerly(boolean validateEagerly)
```

When calling [`Retrofit.create`](retrofit.md#create) on the resulting [`Retrofit`](retrofit.md) instance, eagerly validate the configuration of all methods in the supplied interface.

### build

```java
Retrofit build()
```

Create the [`Retrofit`](retrofit.md) instance using the configured values. If neither [`client`](#client) nor [`callFactory`](#callfactory) is called, a default `OkHttpClient` is created and used.
