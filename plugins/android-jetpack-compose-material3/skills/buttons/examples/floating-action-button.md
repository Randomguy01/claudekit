# Examples

> Last updated 2026-05-30 UTC

FAB typically contains an icon, for a FAB with text and an icon, see `ExtendedFloatingActionButton`.

```kotlin
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.filled.Add
import androidx.compose.material3.FloatingActionButton
import androidx.compose.material3.Icon
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

// A FAB should have a tooltip associated with it.
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
                    paneTitle = "Localized description"
                }
        ) {
            Text("Localized description")
        }
    },
    state = rememberTooltipState(),
) {
    FloatingActionButton(onClick = { /* do something */ }) {
        Icon(Icons.Filled.Add, "Localized description")
    }
}
```
