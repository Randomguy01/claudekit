# API Reference

> Last updated 2026-05-19 UTC

# Material Design standard icon button

Icon buttons help people take supplementary actions with a single tap. They’re used when a compact button is required, such as in a toolbar or image list.

`content` should typically be an `Icon` (see `androidx.compose.material3.internal.Icons`). If using a custom icon, note that the typical size for the internal icon is 24 x 24 dp. This icon button has an overall minimum touch target size of 48 x 48dp, to meet accessibility guidelines.

## Functions

> Added in 1.4.0

```kotlin
@Composable
fun IconButton(
    onClick: () -> Unit,
    modifier: Modifier = Modifier,
    enabled: Boolean = true,
    colors: IconButtonColors = IconButtonDefaults.iconButtonColors(),
    interactionSource: MutableInteractionSource? = null,
    shape: Shape = IconButtonDefaults.standardShape,
    content: @Composable () -> Unit
): Unit
```

| Parameter | Description |
|-----------|-------------|
| `onClick: () -> Unit` | Called when this icon button is clicked |
| `modifier: Modifier = Modifier` | The `Modifier` to be applied to this icon button |
| `enabled: Boolean = true` | Controls the enabled state of this icon button. When `false`, this component will not respond to user input, and it will appear visually disabled and disabled to accessibility services |
| `colors: IconButtonColors = IconButtonDefaults.iconButtonColors()` | `IconButtonColors` that will be used to resolve the colors used for this icon button in different states. See `IconButtonDefaults.iconButtonVibrantColors` and `IconButtonDefaults.iconButtonColors` |
| `interactionSource: MutableInteractionSource? = null` | An optional hoisted `MutableInteractionSource` for observing and emitting `Interaction`s for this icon button. You can use this to change the icon button's appearance or preview the icon button in different states. Note that if `null` is provided, interactions will still happen internally |
| `shape: Shape = IconButtonDefaults.standardShape` | The `Shape` of this icon button |
| `content: @Composable () -> Unit` | The content of this icon button, typically an `Icon` |

> Added in 1.5.0-alpha21

```kotlin
@Composable
fun IconButton(
    onClick: () -> Unit,
    shapes: IconButtonShapes,
    modifier: Modifier = Modifier,
    enabled: Boolean = true,
    colors: IconButtonColors = IconButtonDefaults.iconButtonColors(),
    interactionSource: MutableInteractionSource? = null,
    content: @Composable () -> Unit
): Unit
```

| Parameter | Description |
|-----------|-------------|
| `onClick: () -> Unit` | Called when this icon button is clicked |
| `shapes: IconButtonShapes` | The `IconButtonShapes` that the icon button will morph between depending on the user's interaction with the icon button |
| `modifier: Modifier = Modifier` | The `Modifier` to be applied to this icon button |
| `enabled: Boolean = true` | Controls the enabled state of this icon button. When `false`, this component will not respond to user input, and it will appear visually disabled and disabled to accessibility services |
| `colors: IconButtonColors = IconButtonDefaults.iconButtonColors()` | `IconButtonColors` that will be used to resolve the colors used for this icon button in different states. See `IconButtonDefaults.iconButtonVibrantColors` and `IconButtonDefaults.iconButtonColors` |
| `interactionSource: MutableInteractionSource? = null` | An optional hoisted `MutableInteractionSource` for observing and emitting `Interaction`s for this icon button. You can use this to change the icon button's appearance or preview the icon button in different states. Note that if `null` is provided, interactions will still happen internally |
| `content: @Composable () -> Unit` | The content of this icon button, typically an `Icon` |
