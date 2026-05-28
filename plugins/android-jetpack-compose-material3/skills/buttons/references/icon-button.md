# API Reference

> Last updated 2026-05-19 UTC

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
