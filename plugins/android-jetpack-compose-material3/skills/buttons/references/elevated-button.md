# API Reference

> Last updated 2026-05-06 UTC

# Material Design elevated button

Buttons help people initiate actions, from sending an email, to sharing a document, to liking a post.

Elevated buttons are high-emphasis buttons that are essentially `FilledTonalButtons` with a shadow. To prevent shadow creep, only use them when absolutely necessary, such as when the button requires visual separation from patterned container.

Choose the best button for an action based on the amount of emphasis it needs. The more important an action is, the higher emphasis its button should be.

See `Button` for a high-emphasis button without a shadow, also known as a filled button.
See `FilledTonalButton` for a middle ground between `OutlinedButton` and `Button`.
See `OutlinedButton` for a medium-emphasis button with a border.
See `TextButton` for a low-emphasis button with no border.

The default text style for internal `Text` components will be set to `Typography.labelLarge`.

## Functions

> Added in 1.0.0

```kotlin
@Composable
fun ElevatedButton(
    onClick: () -> Unit,
    modifier: Modifier = Modifier,
    enabled: Boolean = true,
    shape: Shape = ButtonDefaults.elevatedShape,
    colors: ButtonColors = ButtonDefaults.elevatedButtonColors(),
    elevation: ButtonElevation? = ButtonDefaults.elevatedButtonElevation(),
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
| `shape: Shape = ButtonDefaults.elevatedShape` | Defines the shape of this button's container, border (when `border` is not null), and shadow (when using `elevation`) |
| `colors: ButtonColors = ButtonDefaults.elevatedButtonColors()` | `ButtonColors` that will be used to resolve the colors for this button in different states. See `ButtonDefaults.elevatedButtonColors` |
| `elevation: ButtonElevation? = ButtonDefaults.elevatedButtonElevation()` | `ButtonElevation` used to resolve the elevation for this button in different states. This controls the size of the shadow below the button. Additionally, when the container color is `ColorScheme.surface`, this controls the amount of primary color applied as an overlay. See `ButtonDefaults.elevatedButtonElevation` |
| `border: BorderStroke? = null` | The border to draw around the container of this button |
| `contentPadding: PaddingValues = ButtonDefaults.ContentPadding` | The spacing values to apply internally between the container and the content |
| `interactionSource: MutableInteractionSource? = null` | An optional hoisted `MutableInteractionSource` for observing and emitting `Interaction`s for this button. You can use this to change the button's appearance or preview the button in different states. Note that if `null` is provided, interactions will still happen internally |
| `content: @Composable RowScope.() -> Unit` | The content displayed on the button, expected to be text, icon or image |

```kotlin
@Composable
fun ElevatedButton(
    onClick: () -> Unit,
    shapes: ButtonShapes,
    modifier: Modifier = Modifier,
    enabled: Boolean = true,
    colors: ButtonColors = ButtonDefaults.elevatedButtonColors(),
    elevation: ButtonElevation? = ButtonDefaults.elevatedButtonElevation(),
    border: BorderStroke? = null,
    contentPadding: PaddingValues = ButtonDefaults.contentPaddingFor(ButtonDefaults.MinHeight),
    interactionSource: MutableInteractionSource? = null,
    content: @Composable RowScope.() -> Unit
): Unit
```

It also morphs between the shapes provided in `shapes` depending on the state of the interaction with the button as long as the shapes provided our `CornerBasedShapes`. If a shape in `shapes` isn't a `CornerBasedShape`, then button will change between the `ButtonShapes` according to user interaction.

| Parameter | Description |
|-----------|-------------|
| `onClick: () -> Unit` | Called when this button is clicked |
| `shapes: ButtonShapes` | The `ButtonShapes` that this button will morph between depending on the user's interaction with the button |
| `modifier: Modifier = Modifier` | The `Modifier` to be applied to this button |
| `enabled: Boolean = true` | Controls the enabled state of this button. When `false`, this component will not respond to user input, and it will appear visually disabled and disabled to accessibility services |
| `colors: ButtonColors = ButtonDefaults.elevatedButtonColors()` | `ButtonColors` that will be used to resolve the colors for this button in different states. See `ButtonDefaults.elevatedButtonColors` |
| `elevation: ButtonElevation? = ButtonDefaults.elevatedButtonElevation()` | `ButtonElevation` used to resolve the elevation for this button in different states. This controls the size of the shadow below the button. Additionally, when the container color is `ColorScheme.surface`, this controls the amount of primary color applied as an overlay. See `ButtonDefaults.elevatedButtonElevation` |
| `border: BorderStroke? = null` | The border to draw around the container of this button |
| `contentPadding: PaddingValues = ButtonDefaults.contentPaddingFor(ButtonDefaults.MinHeight)` | The spacing values to apply internally between the container and the content |
| `interactionSource: MutableInteractionSource? = null` | An optional hoisted `MutableInteractionSource` for observing and emitting `Interaction`s for this button. You can use this to change the button's appearance or preview the button in different states. Note that if `null` is provided, interactions will still happen internally |
| `content: @Composable RowScope.() -> Unit` | The content displayed on the button, expected to be text, icon or image |
