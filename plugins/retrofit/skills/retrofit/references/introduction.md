# Introduction

Retrofit turns an HTTP API into a Java or Kotlin interface.

```java
public interface GitHubService {
  @GET("users/{user}/repos")
  Call<List<Repo>> listRepos(@Path("user") String user);
}
```

The [`Retrofit`](../api/retrofit2/retrofit.md) class generates an implementation of the `GitHubService` interface.

```java
Retrofit retrofit = new Retrofit.Builder()
    .baseUrl("https://api.github.com/")
    .build();

GitHubService service = retrofit.create(GitHubService.class);
```

Each [`Call`](../api/retrofit2/call.md) from the created `GitHubService` can make synchronous or asynchronous HTTP requests to the remote webserver.

```java
Call<List<Repo>> repos = service.listRepos("octocat");
```

Annotations on each interface method describe how the HTTP request is built:

* URL parameter replacement and query parameter support
* Object conversion to request body (e.g., JSON, protocol buffers)
* Multipart request body and file upload

> [!NOTE]
> See [`declarations.md`](declarations.md) for the full set of method and parameter annotations, and [`configuration.md`](configuration.md) for adding converters and call adapters to the `Retrofit` instance.
