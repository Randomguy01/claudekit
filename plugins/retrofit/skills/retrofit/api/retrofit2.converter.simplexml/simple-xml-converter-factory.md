# API Reference

> Last updated 2026-06-09 · Retrofit 3.x

# SimpleXmlConverterFactory

Package `retrofit2.converter.simplexml` · Artifact `com.squareup.retrofit2:converter-simplexml`

```java
@Deprecated
public final class SimpleXmlConverterFactory extends retrofit2.Converter.Factory
```

**Deprecated** — switch to the JAXB converter ([`jaxb`](../retrofit2.converter.jaxb/jaxb-converter-factory.md) / [`jaxb3`](../retrofit2.converter.jaxb3/jaxb-converter-factory.md)).

A [`Converter.Factory`](../retrofit2/converter-factory.md) which uses Simple Framework for XML. This converter only applies for class types; parameterized types (e.g. `List<Foo>`) are not handled.

## Public Methods

### create

```java
static SimpleXmlConverterFactory create()
static SimpleXmlConverterFactory create(org.simpleframework.xml.Serializer serializer)
```

Create a strict instance. The no-arg overload uses a default `Persister`; the other uses the supplied `serializer`.

### createNonStrict

```java
static SimpleXmlConverterFactory createNonStrict()
static SimpleXmlConverterFactory createNonStrict(org.simpleframework.xml.Serializer serializer)
```

Create a non-strict instance. The no-arg overload uses a default `Persister`; the other uses the supplied `serializer`.

### isStrict

```java
boolean isStrict()
```

### responseBodyConverter / requestBodyConverter

```java
retrofit2.Converter<okhttp3.ResponseBody, ?> responseBodyConverter(
    java.lang.reflect.Type type, java.lang.annotation.Annotation[] annotations, retrofit2.Retrofit retrofit)

retrofit2.Converter<?, okhttp3.RequestBody> requestBodyConverter(
    java.lang.reflect.Type type, java.lang.annotation.Annotation[] parameterAnnotations,
    java.lang.annotation.Annotation[] methodAnnotations, retrofit2.Retrofit retrofit)
```

Override [`Converter.Factory.responseBodyConverter`](../retrofit2/converter-factory.md#responsebodyconverter) and [`requestBodyConverter`](../retrofit2/converter-factory.md#requestbodyconverter).
