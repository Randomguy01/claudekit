# API Reference

> Last updated 2026-06-11

# GeneratesRootInput

```java
@Target(ANNOTATION_TYPE)
@Retention(CLASS)
public @interface GeneratesRootInput
```

For annotating annotations that generate input for the generated components. A meta-annotation: applying it to a custom annotation tells Hilt that the annotation produces code which must be processed before the Hilt root component is generated, so Hilt waits for that generation to finish.
</content>
