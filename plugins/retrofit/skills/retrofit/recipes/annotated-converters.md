# Register Converters by Annotation

A generalization of [Select a Converter by Annotation](json-and-xml-converters.md): instead of hard-coding two formats, build a [`Converter.Factory`](../api/retrofit2/converter-factory.md) that maps any marker annotation to a delegate factory. Methods opt into a serializer by applying the matching annotation.

Define one runtime annotation per library:

```java
@Retention(RUNTIME) public @interface Moshi {}
@Retention(RUNTIME) public @interface Gson {}
@Retention(RUNTIME) public @interface SimpleXml {}
```

The factory holds an annotation-to-factory map and delegates to the first match:

```java
public static final class AnnotatedConverterFactory extends Converter.Factory {
  private final Map<Class<? extends Annotation>, Converter.Factory> factories;

  public static final class Builder {
    private final Map<Class<? extends Annotation>, Converter.Factory> factories =
        new LinkedHashMap<>();

    public Builder add(Class<? extends Annotation> cls, Converter.Factory factory) {
      if (cls == null) throw new NullPointerException("cls == null");
      if (factory == null) throw new NullPointerException("factory == null");
      factories.put(cls, factory);
      return this;
    }

    public AnnotatedConverterFactory build() {
      return new AnnotatedConverterFactory(factories);
    }
  }

  AnnotatedConverterFactory(Map<Class<? extends Annotation>, Converter.Factory> factories) {
    this.factories = new LinkedHashMap<>(factories);
  }

  @Override public @Nullable Converter<ResponseBody, ?> responseBodyConverter(
      Type type, Annotation[] annotations, Retrofit retrofit) {
    for (Annotation annotation : annotations) {
      Converter.Factory factory = factories.get(annotation.annotationType());
      if (factory != null) {
        return factory.responseBodyConverter(type, annotations, retrofit);
      }
    }
    return null;
  }

  // requestBodyConverter mirrors this over parameterAnnotations.
}
```

Build the factory from the libraries you need, and add a plain fallback factory after it for methods with no marker:

```java
Retrofit retrofit = new Retrofit.Builder()
    .baseUrl(baseUrl)
    .addConverterFactory(new AnnotatedConverterFactory.Builder()
        .add(Moshi.class, MoshiConverterFactory.create())
        .add(Gson.class, GsonConverterFactory.create())
        .add(SimpleXml.class, SimpleXmlConverterFactory.create())
        .build())
    .addConverterFactory(GsonConverterFactory.create()) // default for unmarked methods
    .build();
```

> [!NOTE]
> Factories are consulted in registration order. Place the annotated factory first so its markers win; the trailing factory handles methods that carry none. Keying on `annotation.annotationType()` matches by class, so unrelated annotations on the method are ignored.

Delegates: [`MoshiConverterFactory`](../api/retrofit2.converter.moshi/moshi-converter-factory.md), [`GsonConverterFactory`](../api/retrofit2.converter.gson/gson-converter-factory.md), [`SimpleXmlConverterFactory`](../api/retrofit2.converter.simplexml/simple-xml-converter-factory.md).
