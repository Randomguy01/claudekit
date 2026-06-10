# Deserialize an Error Body

A non-2xx [`Response`](../api/retrofit2/response.md) is still a successful HTTP exchange — `isSuccessful()` returns `false` and the payload is exposed through `errorBody()` as a raw `ResponseBody`. APIs often return a structured error document there.

Obtain a [`Converter`](../api/retrofit2/converter.md) for the error type directly from the [`Retrofit`](../api/retrofit2/retrofit.md) instance with `responseBodyConverter`, then convert the error body.

```java
interface Service {
  @GET("/user")
  Call<User> getUser();
}

class ErrorBody {
  String message;
}

Response<User> response = service.getUser().execute();

if (!response.isSuccessful()) {
  Converter<ResponseBody, ErrorBody> errorConverter =
      retrofit.responseBodyConverter(ErrorBody.class, new Annotation[0]);
  ErrorBody error = errorConverter.convert(response.errorBody());
  // error.message holds the server-supplied detail.
}
```

> [!NOTE]
> Pass `new Annotation[0]` unless the error type needs annotation-driven converter selection. The converter is resolved from the same factories registered on the builder, so this works for any format the instance supports.

> [!IMPORTANT]
> `errorBody()` is a one-shot stream. Read it once, and close it (`convert` does so for you) to avoid leaking the connection.
