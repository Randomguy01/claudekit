# Configuring Retrofit

[`Retrofit`](../api/retrofit2/retrofit.md) is the class through which API interfaces are turned into callable objects. Retrofit provides sane defaults for the platform while allowing customization.

## Converters

By default, Retrofit can only deserialize HTTP bodies into OkHttp's `ResponseBody` type, and it can only accept its `RequestBody` type for [`@Body`](../api/retrofit2.http/body.md).

Add converters to support other types. Sibling modules adapt popular serialization libraries.

### Built-in Converters

* Gson: `com.squareup.retrofit2:converter-gson`
* Jackson: `com.squareup.retrofit2:converter-jackson` — supports [multiple formats](https://github.com/FasterXML/jackson#data-format-modules) (JSON, XML, CBOR, YAML, etc.) by supplying a different mapper and media type
* Moshi: `com.squareup.retrofit2:converter-moshi`
* Protobuf: `com.squareup.retrofit2:converter-protobuf`
* Wire: `com.squareup.retrofit2:converter-wire`
* Simple XML: `com.squareup.retrofit2:converter-simplexml`
* JAXB: `com.squareup.retrofit2:converter-jaxb`
* Kotlin serialization: `com.squareup.retrofit2:converter-kotlinx-serialization`
* Scalars (primitives, boxed, and String): `com.squareup.retrofit2:converter-scalars`

Pass a converter factory to the builder. The following uses `GsonConverterFactory` to deserialize the `GitHubService` responses with Gson:

```java
Retrofit retrofit = new Retrofit.Builder()
    .baseUrl("https://api.github.com/")
    .addConverterFactory(GsonConverterFactory.create())
    .build();

GitHubService service = retrofit.create(GitHubService.class);
```

### Delegating Converters

Delegating converters differ from the converters above in that they don't convert bytes to an object. Instead, they delegate to another converter, then wrap the potentially-null result into an optional.

Two delegating converters are provided:

* Guava's `Optional<T>` — `com.squareup.retrofit2:converter-guava`
* Java 8's `Optional<T>` — `com.squareup.retrofit2:converter-java8`

### Custom Converters

To communicate with an API that uses a content format Retrofit does not support out of the box (e.g. YAML, txt, custom format), or to use a different library for an existing format, create a custom converter. Create a class that extends [`Converter.Factory`](../api/retrofit2/converter-factory.md) and pass an instance when building the `Retrofit` instance.

### Third-Party Converters

Various third-party converters have been created by the community for other libraries and serialization formats:

* [MessagePack](https://github.com/komamitsu/retrofit-converter-msgpack) — `org.komamitsu:retrofit-converter-msgpack`
* [LoganSquare](https://github.com/aurae/retrofit-logansquare) — `com.github.aurae.retrofit2:converter-logansquare`
* [FastJson](https://github.com/ZYRzyr/FastJsonConverter) — `com.github.ZYRzyr:FastJsonConverter`
* [FastJson](https://github.com/ligboy/retrofit-converter-fastjson) — `org.ligboy.retrofit2:converter-fastjson` or `org.ligboy.retrofit2:converter-fastjson-android`
* [Thrifty](https://github.com/infinum/thrifty-retrofit-converter) — `co.infinum:retrofit-converter-thrifty`
* [jspoon](https://github.com/DroidsOnRoids/jspoon/tree/master/retrofit-converter-jspoon) (HTML) — `pl.droidsonroids.retrofit2:converter-jspoon`
* [Fruit](https://github.com/ghuiii/Fruit/tree/master/converter-retrofit) — `me.ghui:fruit-converter-retrofit`
* [JakartaEE JsonB](https://github.com/cchacin/jsonb-retrofit-converter/) — `io.github.cchacin:jsonb-retrofit-converter`

## Call Adapters

Retrofit is pluggable, allowing different execution mechanisms and their libraries to be used for performing the HTTP call. This allows API requests to compose with any existing threading model and/or task framework in the rest of the app.

### Built-in Call Adapters

* RxJava `Observable` & `Single` — `com.squareup.retrofit2:adapter-rxjava`
* RxJava2 `Observable`, `Flowable`, `Single`, `Completable` & `Maybe` — `com.squareup.retrofit2:adapter-rxjava2`
* RxJava3 `Observable`, `Flowable`, `Single`, `Completable` & `Maybe` — `com.squareup.retrofit2:adapter-rxjava3`
* Guava `ListenableFuture` — `com.squareup.retrofit2:adapter-guava`
* Java 8 `CompletableFuture` — `com.squareup.retrofit2:adapter-java8`
* Kotlin `suspend` functions — no dependency needed

### Custom Call Adapters

To integrate with a work library that Retrofit does not support out of the box, or to use a different strategy for adapting an existing library, create a custom call adapter. Create a class that extends [`CallAdapter.Factory`](../api/retrofit2/call-adapter-factory.md) for a target type, and return an adapter that wraps the built-in [`Call`](../api/retrofit2/call.md).

### Third-Party Call Adapters

Various third-party adapters have been created by the community for other libraries:

* [Bolts](https://github.com/zeng1990java/retrofit-bolts-call-adapter)
* [Agera](https://github.com/drakeet/retrofit-agera-call-adapter)
* [Project Reactor](https://github.com/JakeWharton/retrofit2-reactor-adapter)
