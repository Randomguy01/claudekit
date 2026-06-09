---
name: retrofit
description: >
  Build and maintain a Retrofit HTTP client in a Java or Kotlin/Android
  app. Use this skill when the user defines a typed API interface and its
  request annotations (@GET/@POST, @Path, @Query, @Body, @Field, @Part,
  @Header); builds or configures a Retrofit instance; adds converters
  (Gson, Moshi, kotlinx.serialization, Jackson, XML, protobuf, scalars) or
  call adapters (RxJava, Guava, Scala, coroutine suspend); handles
  responses and error bodies; rewrites URLs or hosts at runtime; adds
  per-method logging or metrics via interceptors; or mocks a service for
  tests. Applies even when the user doesn't say "Retrofit" by name — e.g.
  "turn this REST API into a Kotlin interface," "call this JSON endpoint
  from Android," or "my @GET / suspend fun won't deserialize." Skip for
  raw OkHttp/HttpURLConnection work, Ktor, or non-JVM HTTP clients.
---

# Retrofit

Retrofit turns an HTTP API into a Java or Kotlin interface. Annotations on the interface methods describe how each request is built — URL and query parameters, request bodies, form and multipart data, headers — and the `Retrofit` class generates the implementation that performs the calls over OkHttp.

This skill is a router. Decide what the task needs, then read the matching file before writing or reviewing code:

- **`references/*.md`** — task guides. How to declare requests and configure a `Retrofit` instance. **Read these first.**
- **`recipes/*.md`** — worked solutions to specific, recurring problems (custom adapters, error bodies, mocking, logging). Read these when the task matches one.
- **`api/<package>/*.md`** — per-type API references. Exact annotation attributes, method signatures, and parameters. Read these when you need the precise contract of a specific type.

When in doubt, open the reference guide for the task, then drill into the `api/` file for any type it links.

## Reference guides (`references/`)

- New to Retrofit, or want the one-page picture of interface → `Retrofit.create` → `Call` → `references/introduction.md`
- Add Retrofit to a build (Gradle/Maven, version selection, R8/ProGuard) → `references/installation.md`
- Declare HTTP requests — methods, `@Path`/`@Query`, `@Body`, form-encoded and multipart, headers, sync/async, Kotlin `suspend` → `references/declarations.md`
- Configure the `Retrofit` instance — converters (Gson, Moshi, kotlinx, XML, protobuf, scalars) and call adapters (RxJava, Guava, Scala, suspend) → `references/configuration.md`

## Recipes (`recipes/`)

### Converters

- One service mixes JSON and XML; pick the converter per method with a marker annotation → `recipes/json-and-xml-converters.md`
- Generalize that to any annotation → delegate-factory mapping → `recipes/annotated-converters.md`
- Read a structured error document out of a non-2xx response → `recipes/deserialize-error-body.md`

### Call adapters

- Return a custom type instead of `Call`, with a callback that splits outcomes by status class → `recipes/custom-call-adapter.md`

### Requests and hosts

- Switch the base URL / host at runtime without rebuilding Retrofit → `recipes/dynamic-base-url.md`

### Observability

- Attribute timing/metrics to the exact API method via the `Invocation` request tag → `recipes/invocation-metrics.md`
- Enable verbose logging on selected endpoints only, gated on a method annotation → `recipes/conditional-logging.md`

### Testing

- Back a service interface with fake data and simulated network behavior → `recipes/mock-service.md`

## API references (`api/`)

Each annotation, class, and interface has its own file. Filenames are the kebab-case form of the type name (`@GET` → `get.md`, `Retrofit.Builder` → `retrofit-builder.md`). Run `ls api/<package>/` to discover the full set.

### Core (`api/retrofit2/`)

- `retrofit.md` — the access point; built with `retrofit-builder.md`
- `call.md`, `callback.md`, `response.md` — the request/response contract; `http-exception.md` for suspend-body failures
- `converter.md`, `converter-factory.md`, `optional-converter-factory.md` — body conversion
- `call-adapter.md`, `call-adapter-factory.md` — adapting `Call` to other return types
- `invocation.md` — per-call metadata tag; `skip-callback-executor.md` to bypass the callback executor

### Request annotations (`api/retrofit2.http/`)

- HTTP methods: `get.md`, `post.md`, `put.md`, `patch.md`, `delete.md`, `head.md`, `options.md`, `http.md`
- URL and parameters: `path.md`, `query.md`, `query-map.md`, `query-name.md`, `url.md`
- Bodies: `body.md`, `form-url-encoded.md`, `field.md`, `field-map.md`, `multipart.md`, `part.md`, `part-map.md`, `streaming.md`
- Headers and tags: `headers.md`, `header.md`, `header-map.md`, `tag.md`

### Converters (`api/retrofit2.converter.*/`)

One factory per serialization library: `gson`, `moshi`, `kotlinx.serialization` (`as-converter-factory.md`), `jackson`, `protobuf`, `wire`, `scalars`, `simplexml`, `jaxb`/`jaxb3`. The two delegating optional converters live under `api/retrofit2.converter.guava/` and `api/retrofit2.converter.java8/`.

### Call adapters (`api/retrofit2.adapter.*/`)

One factory per execution library: `rxjava`, `rxjava2`, `rxjava3` (each with `result.md`), `guava`, `java8`, `scala`. RxJava and Guava adapters define their own `http-exception.md`.

### Mocking (`api/retrofit2.mock/`)

`mock-retrofit.md` (+ `mock-retrofit-builder.md`), `network-behavior.md`, `behavior-delegate.md`, `calls.md`.

Read the `api/` file when you need to confirm an annotation's attributes or a method's exact signature — not for how-to workflows, which live in `references/` and `recipes/`.
