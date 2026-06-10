# API Reference

> Last updated 2026-06-09 · Retrofit 3.x

# JaxbConverterFactory

Package `retrofit2.converter.jaxb` · Artifact `com.squareup.retrofit2:converter-jaxb`

```java
public final class JaxbConverterFactory extends retrofit2.Converter.Factory
```

A [`Converter.Factory`](../retrofit2/converter-factory.md) which uses JAXB (`javax.xml.bind`) for XML. All validation events are ignored. For the `jakarta.xml.bind` variant see [`jaxb3`](../retrofit2.converter.jaxb3/jaxb-converter-factory.md).

## Public Methods

### create

```java
static JaxbConverterFactory create()
static JaxbConverterFactory create(javax.xml.bind.JAXBContext context)
```

Create an instance for conversion. The no-arg overload uses a default `JAXBContext`; the other uses the supplied `context`.

### responseBodyConverter / requestBodyConverter

```java
retrofit2.Converter<okhttp3.ResponseBody, ?> responseBodyConverter(
    java.lang.reflect.Type type, java.lang.annotation.Annotation[] annotations, retrofit2.Retrofit retrofit)

retrofit2.Converter<?, okhttp3.RequestBody> requestBodyConverter(
    java.lang.reflect.Type type, java.lang.annotation.Annotation[] parameterAnnotations,
    java.lang.annotation.Annotation[] methodAnnotations, retrofit2.Retrofit retrofit)
```

Override [`Converter.Factory.responseBodyConverter`](../retrofit2/converter-factory.md#responsebodyconverter) and [`requestBodyConverter`](../retrofit2/converter-factory.md#requestbodyconverter).
