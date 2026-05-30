# API Reference

> Last updated 2026-05-29 UTC

```kotlin
@Composable
fun MediumFloatingActionButton(
    onClick: () -> Unit,
    modifier: Modifier = Modifier,
    shape: Shape = FloatingActionButtonDefaults.mediumShape,
    containerColor: Color = FloatingActionButtonDefaults.containerColor,
    contentColor: Color = contentColorFor(containerColor),
    elevation: FloatingActionButtonElevation = FloatingActionButtonDefaults.elevation(),
    interactionSource: MutableInteractionSource? = null,
    content: @Composable () -> Unit
): Unit
```

| Parameter | Description |
|-----------|-------------|
| `onClick: () -> Unit` | called when this FAB is clicked |
| `modifier: Modifier = Modifier` | the `Modifier` to be applied to this FAB |
| `shape: Shape = FloatingActionButtonDefaults.mediumShape` | defines the shape of this FAB's container and shadow (when using `elevation`) |
| `containerColor: Color = FloatingActionButtonDefaults.containerColor` | the color used for the background of this FAB. Use `Color.Transparent` to have no color. |
| `contentColor: Color = contentColorFor(containerColor)` | the preferred color for content inside this FAB. Defaults to either the matching content color for `containerColor`, or to the current `LocalContentColor` if `containerColor` is not a color from the theme. |
| `elevation: FloatingActionButtonElevation = FloatingActionButtonDefaults.elevation()` | `FloatingActionButtonElevation` used to resolve the elevation for this FAB in different states. This controls the size of the shadow below the FAB. Additionally, when the container color is `ColorScheme.surface`, this controls the amount of primary color applied as an overlay. See also: `Surface`. |
| `interactionSource: MutableInteractionSource? = null` | an optional hoisted `MutableInteractionSource` for observing and emitting `Interaction`s for this FAB. You can use this to change the FAB's appearance or preview the FAB in different states. Note that if `null` is provided, interactions will still happen internally. |
| `content: @Composable () -> Unit` | the content of this FAB, typically an `Icon` |
