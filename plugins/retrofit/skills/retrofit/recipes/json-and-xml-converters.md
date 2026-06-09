# Select a Converter by Annotation

When one service mixes content types — some endpoints return JSON, others XML — register multiple converters and choose between them per method with a marker annotation. Wrap the underlying factories in a [`Converter.Factory`](../api/retrofit2/converter-factory.md) that dispatches on the annotations Retrofit passes in.

Declare runtime annotations to mark each format:

```java
@Retention(RUNTIME) @interface Json {}
@Retention(RUNTIME) @interface Xml {}
```

The factory inspects the annotations and delegates to the matching converter, returning `null` when none apply so other factories get a chance:

```java
static class QualifiedTypeConverterFactory extends Converter.Factory {
  private final Converter.Factory jsonFactory;
  private final Converter.Factory xmlFactory;

  QualifiedTypeConverterFactory(Converter.Factory jsonFactory, Converter.Factory xmlFactory) {
    this.jsonFactory = jsonFactory;
    this.xmlFactory = xmlFactory;
  }

  @Override public @Nullable Converter<ResponseBody, ?> responseBodyConverter(
      Type type, Annotation[] annotations, Retrofit retrofit) {
    for (Annotation annotation : annotations) {
      if (annotation instanceof Json) {
        return jsonFactory.responseBodyConverter(type, annotations, retrofit);
      }
      if (annotation instanceof Xml) {
        return xmlFactory.responseBodyConverter(type, annotations, retrofit);
      }
    }
    return null;
  }

  // requestBodyConverter mirrors this, dispatching on parameterAnnotations.
}
```

Mark each method with the format it expects, and register the factory:

```java
interface Service {
  @GET("/") @Json Call<User> exampleJson();
  @GET("/") @Xml  Call<User> exampleXml();
}

Retrofit retrofit = new Retrofit.Builder()
    .baseUrl(baseUrl)
    .addConverterFactory(new QualifiedTypeConverterFactory(
        GsonConverterFactory.create(), SimpleXmlConverterFactory.create()))
    .build();
```

> [!NOTE]
> Response selection reads the method annotations; request-body selection reads the parameter annotations. Handle both in the factory if the type travels in each direction.

See [`GsonConverterFactory`](../api/retrofit2.converter.gson/gson-converter-factory.md) and [`SimpleXmlConverterFactory`](../api/retrofit2.converter.simplexml/simple-xml-converter-factory.md) for the delegate factories used here. For a reusable, builder-driven version of this pattern, see [Register Converters by Annotation](annotated-converters.md).
