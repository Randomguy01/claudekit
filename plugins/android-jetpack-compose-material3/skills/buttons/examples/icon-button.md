# Examples

> Last updated 2026-05-19 UTC

Simple Usage

```kotlin
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.filled.Lock
import androidx.compose.material.icons.outlined.Lock
import androidx.compose.material3.Icon
import androidx.compose.material3.IconButton
import androidx.compose.material3.PlainTooltip
import androidx.compose.material3.Text
import androidx.compose.material3.TooltipAnchorPosition
import androidx.compose.material3.TooltipBox
import androidx.compose.material3.TooltipDefaults
import androidx.compose.material3.rememberTooltipState
import androidx.compose.runtime.remember
import androidx.compose.ui.Modifier
import androidx.compose.ui.semantics.LiveRegionMode
import androidx.compose.ui.semantics.liveRegion
import androidx.compose.ui.semantics.paneTitle
import androidx.compose.ui.semantics.semantics

val description = "Localized description"
// Icon button should have a tooltip associated with it for a11y.
TooltipBox(
    positionProvider =
        TooltipDefaults.rememberTooltipPositionProvider(TooltipAnchorPosition.Above),
    tooltip = {
        PlainTooltip(
            modifier =
                Modifier.semantics {
                    // TODO(b/496338253): Remove this modifier once bug where tooltip text is
                    //  not announced by a11y screen readers is resolved.
                    liveRegion = LiveRegionMode.Assertive
                    paneTitle = description
                }
        ) {
            Text(description)
        }
    },
    state = rememberTooltipState(),
) {
    IconButton(onClick = { /* doSomething() */ }) {
        Icon(Icons.Filled.Lock, contentDescription = description)
    }
}
```

IconButton with a color tint

```kotlin
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.filled.Lock
import androidx.compose.material.icons.outlined.Lock
import androidx.compose.material3.Icon
import androidx.compose.material3.IconButton
import androidx.compose.material3.PlainTooltip
import androidx.compose.material3.Text
import androidx.compose.material3.TooltipAnchorPosition
import androidx.compose.material3.TooltipBox
import androidx.compose.material3.TooltipDefaults
import androidx.compose.material3.rememberTooltipState
import androidx.compose.runtime.remember
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.graphics.vector.rememberVectorPainter
import androidx.compose.ui.semantics.LiveRegionMode
import androidx.compose.ui.semantics.liveRegion
import androidx.compose.ui.semantics.paneTitle
import androidx.compose.ui.semantics.semantics

val description = "Localized description"
// Icon button should have a tooltip associated with it for a11y.
TooltipBox(
    positionProvider =
        TooltipDefaults.rememberTooltipPositionProvider(TooltipAnchorPosition.Above),
    tooltip = {
        PlainTooltip(
            modifier =
                Modifier.semantics {
                    // TODO(b/496338253): Remove this modifier once bug where tooltip text is
                    //  not announced by a11y screen readers is resolved.
                    liveRegion = LiveRegionMode.Assertive
                    paneTitle = description
                }
        ) {
            Text(description)
        }
    },
    state = rememberTooltipState(),
) {
    IconButton(onClick = { /* doSomething() */ }) {
        Icon(
            rememberVectorPainter(image = Icons.Filled.Lock),
            contentDescription = description,
            tint = Color.Red,
        )
    }
}
```

Small-sized narrow round shape IconButton

```kotlin
import androidx.compose.foundation.layout.size
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.filled.Lock
import androidx.compose.material.icons.outlined.Lock
import androidx.compose.material3.FilledIconButton
import androidx.compose.material3.Icon
import androidx.compose.material3.IconButton
import androidx.compose.material3.IconButtonDefaults
import androidx.compose.material3.PlainTooltip
import androidx.compose.material3.Text
import androidx.compose.material3.TooltipAnchorPosition
import androidx.compose.material3.TooltipBox
import androidx.compose.material3.TooltipDefaults
import androidx.compose.material3.minimumInteractiveComponentSize
import androidx.compose.material3.rememberTooltipState
import androidx.compose.runtime.remember
import androidx.compose.ui.Modifier
import androidx.compose.ui.semantics.LiveRegionMode
import androidx.compose.ui.semantics.liveRegion
import androidx.compose.ui.semantics.paneTitle
import androidx.compose.ui.semantics.semantics

val description = "Localized description"
// Icon button should have a tooltip associated with it for a11y.
TooltipBox(
    positionProvider =
        TooltipDefaults.rememberTooltipPositionProvider(TooltipAnchorPosition.Above),
    tooltip = {
        PlainTooltip(
            modifier =
                Modifier.semantics {
                    // TODO(b/496338253): Remove this modifier once bug where tooltip text is
                    //  not announced by a11y screen readers is resolved.
                    liveRegion = LiveRegionMode.Assertive
                    paneTitle = description
                }
        ) {
            Text(description)
        }
    },
    state = rememberTooltipState(),
) {
    // Small narrow round icon button
    FilledIconButton(
        onClick = { /* doSomething() */ },
        modifier =
            Modifier.minimumInteractiveComponentSize()
                .size(
                    IconButtonDefaults.extraSmallContainerSize(
                        IconButtonDefaults.IconButtonWidthOption.Narrow
                    )
                ),
        shape = IconButtonDefaults.extraSmallSquareShape,
    ) {
        Icon(
            Icons.Filled.Lock,
            contentDescription = description,
            modifier = Modifier.size(IconButtonDefaults.extraSmallIconSize),
        )
    }
}
```

Medium / default size round-shaped icon button

```kotlin
import androidx.compose.foundation.layout.size
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.filled.Lock
import androidx.compose.material.icons.outlined.Lock
import androidx.compose.material3.Icon
import androidx.compose.material3.IconButton
import androidx.compose.material3.IconButtonDefaults
import androidx.compose.material3.PlainTooltip
import androidx.compose.material3.Text
import androidx.compose.material3.TooltipAnchorPosition
import androidx.compose.material3.TooltipBox
import androidx.compose.material3.TooltipDefaults
import androidx.compose.material3.rememberTooltipState
import androidx.compose.runtime.remember
import androidx.compose.ui.Modifier
import androidx.compose.ui.semantics.LiveRegionMode
import androidx.compose.ui.semantics.liveRegion
import androidx.compose.ui.semantics.paneTitle
import androidx.compose.ui.semantics.semantics

val description = "Localized description"
// Icon button should have a tooltip associated with it for a11y.
TooltipBox(
    positionProvider =
        TooltipDefaults.rememberTooltipPositionProvider(TooltipAnchorPosition.Above),
    tooltip = {
        PlainTooltip(
            modifier =
                Modifier.semantics {
                    // TODO(b/496338253): Remove this modifier once bug where tooltip text is
                    //  not announced by a11y screen readers is resolved.
                    liveRegion = LiveRegionMode.Assertive
                    paneTitle = description
                }
        ) {
            Text(description)
        }
    },
    state = rememberTooltipState(),
) {
    IconButton(
        onClick = { /* doSomething() */ },
        modifier =
            Modifier.size(
                IconButtonDefaults.mediumContainerSize(
                    IconButtonDefaults.IconButtonWidthOption.Wide
                )
            ),
        shape = IconButtonDefaults.mediumRoundShape,
    ) {
        Icon(
            Icons.Filled.Lock,
            contentDescription = description,
            modifier = Modifier.size(IconButtonDefaults.mediumIconSize),
        )
    }
}
```

Simple Usage

```kotlin
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.filled.Lock
import androidx.compose.material.icons.outlined.Lock
import androidx.compose.material3.Icon
import androidx.compose.material3.IconButton
import androidx.compose.material3.IconButtonDefaults
import androidx.compose.material3.PlainTooltip
import androidx.compose.material3.Text
import androidx.compose.material3.TooltipAnchorPosition
import androidx.compose.material3.TooltipBox
import androidx.compose.material3.TooltipDefaults
import androidx.compose.material3.rememberTooltipState
import androidx.compose.runtime.remember
import androidx.compose.ui.Modifier
import androidx.compose.ui.semantics.LiveRegionMode
import androidx.compose.ui.semantics.liveRegion
import androidx.compose.ui.semantics.paneTitle
import androidx.compose.ui.semantics.semantics

val description = "Localized description"
// Icon button should have a tooltip associated with it for a11y.
TooltipBox(
    positionProvider =
        TooltipDefaults.rememberTooltipPositionProvider(TooltipAnchorPosition.Above),
    tooltip = {
        PlainTooltip(
            modifier =
                Modifier.semantics {
                    // TODO(b/496338253): Remove this modifier once bug where tooltip text is
                    //  not announced by a11y screen readers is resolved.
                    liveRegion = LiveRegionMode.Assertive
                    paneTitle = description
                }
        ) {
            Text(description)
        }
    },
    state = rememberTooltipState(),
) {
    IconButton(onClick = { /* doSomething() */ }, shapes = IconButtonDefaults.shapes()) {
        Icon(Icons.Filled.Lock, contentDescription = description)
    }
}
```
