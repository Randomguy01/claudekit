# API Reference

> Last updated 2026-05-06 UTC

```kotlin
@Composable
fun FilledTonalButton(
    onClick: () -> Unit,
    modifier: Modifier = Modifier,
    enabled: Boolean = true,
    shape: Shape = ButtonDefaults.filledTonalShape,
    colors: ButtonColors = ButtonDefaults.filledTonalButtonColors(),
    elevation: ButtonElevation? = ButtonDefaults.filledTonalButtonElevation(),
    border: BorderStroke? = null,
    contentPadding: PaddingValues = ButtonDefaults.ContentPadding,
    interactionSource: MutableInteractionSource? = null,
    content: @Composable RowScope.() -> Unit
): Unit
```

| Parameter | Description |
|-----------|-------------|
| `onClick: () -> Unit` | Called when this button is clicked |
| `modifier: Modifier = Modifier` | The `Modifier` to be applied to this button |
| `enabled: Boolean = true` | Controls the enabled state of this button. When `false`, this component will not respond to user input, and it will appear visually disabled and disabled to accessibility services |
| `shape: Shape = ButtonDefaults.filledTonalShape` | Defines the shape of this button's container, border (when `border` is not null), and shadow (when using `elevation`) |
| `colors: ButtonColors = ButtonDefaults.filledTonalButtonColors()` | `ButtonColors` that will be used to resolve the colors for this button in different states. See `ButtonDefaults.filledTonalButtonColors` |
| `elevation: ButtonElevation? = ButtonDefaults.filledTonalButtonElevation()` | `ButtonElevation` used to resolve the elevation for this button in different states. This controls the size of the shadow below the button. Additionally, when the container color is `ColorScheme.surface`, this controls the amount of primary color applied as an overlay |
| `border: BorderStroke? = null` | The border to draw around the container of this button |
| `contentPadding: PaddingValues = ButtonDefaults.ContentPadding` | The spacing values to apply internally between the container and the content |
| `interactionSource: MutableInteractionSource? = null` | An optional hoisted `MutableInteractionSource` for observing and emitting `Interaction`s for this button. You can use this to change the button's appearance or preview the button in different states. Note that if `null` is provided, interactions will still happen internally |
| `content: @Composable RowScope.() -> Unit` | The content displayed on the button, expected to be text, icon or image |

```kotlin
@Composable
fun FilledTonalButton(
    onClick: () -> Unit,
    shapes: ButtonShapes,
    modifier: Modifier = Modifier,
    enabled: Boolean = true,
    colors: ButtonColors = ButtonDefaults.filledTonalButtonColors(),
    elevation: ButtonElevation? = ButtonDefaults.filledTonalButtonElevation(),
    border: BorderStroke? = null,
    contentPadding: PaddingValues = ButtonDefaults.contentPaddingFor(ButtonDefaults.MinHeight),
    interactionSource: MutableInteractionSource? = null,
    content: @Composable RowScope.() -> Unit
): Unit
```

| Parameter | Description |
|-----------|-------------|
| `onClick: () -> Unit` | Called when this button is clicked |
| `shapes: ButtonShapes` | The `ButtonShapes` that this button will morph between depending on the user's interaction with the button |
| `modifier: Modifier = Modifier` | The `Modifier` to be applied to this button |
| `enabled: Boolean = true` | Controls the enabled state of this button. When `false`, this component will not respond to user input, and it will appear visually disabled and disabled to accessibility services |
| `colors: ButtonColors = ButtonDefaults.filledTonalButtonColors()` | `ButtonColors` that will be used to resolve the colors for this button in different states. See `ButtonDefaults.filledTonalButtonColors` |
| `elevation: ButtonElevation? = ButtonDefaults.filledTonalButtonElevation()` | `ButtonElevation` used to resolve the elevation for this button in different states. This controls the size of the shadow below the button. Additionally, when the container color is `ColorScheme.surface`, this controls the amount of primary color applied as an overlay |
| `border: BorderStroke? = null` | The border to draw around the container of this button |
| `contentPadding: PaddingValues = ButtonDefaults.contentPaddingFor(ButtonDefaults.MinHeight)` | The spacing values to apply internally between the container and the content |
| `interactionSource: MutableInteractionSource? = null` | An optional hoisted `MutableInteractionSource` for observing and emitting `Interaction`s for this button. You can use this to change the button's appearance or preview the button in different states. Note that if `null` is provided, interactions will still happen internally |
| `content: @Composable RowScope.() -> Unit` | The content displayed on the button, expected to be text, icon or image |
