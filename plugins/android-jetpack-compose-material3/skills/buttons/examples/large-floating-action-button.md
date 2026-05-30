# Examples

> Last updated 2026-05-29 UTC

```kotlin
import androidx.compose.foundation.layout.size
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.filled.Add
import androidx.compose.material3.FloatingActionButton
import androidx.compose.material3.FloatingActionButtonDefaults
import androidx.compose.material3.Icon
import androidx.compose.material3.LargeFloatingActionButton
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
    LargeFloatingActionButton(onClick = { /* do something */ }) {
        Icon(
            Icons.Filled.Add,
            contentDescription = "Localized description",
            modifier = Modifier.size(FloatingActionButtonDefaults.LargeIconSize),
        )
    }
}
```

FABs can also be shown and hidden with an animation when the main content is scrolled:

```kotlin
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.size
import androidx.compose.foundation.lazy.LazyColumn
import androidx.compose.foundation.lazy.rememberLazyListState
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.filled.Add
import androidx.compose.material3.FabPosition
import androidx.compose.material3.FloatingActionButton
import androidx.compose.material3.FloatingActionButtonDefaults
import androidx.compose.material3.Icon
import androidx.compose.material3.MediumFloatingActionButton
import androidx.compose.material3.PlainTooltip
import androidx.compose.material3.Scaffold
import androidx.compose.material3.Text
import androidx.compose.material3.TooltipAnchorPosition
import androidx.compose.material3.TooltipBox
import androidx.compose.material3.TooltipDefaults
import androidx.compose.material3.animateFloatingActionButton
import androidx.compose.material3.rememberTooltipState
import androidx.compose.runtime.derivedStateOf
import androidx.compose.runtime.remember
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.semantics.LiveRegionMode
import androidx.compose.ui.semantics.liveRegion
import androidx.compose.ui.semantics.paneTitle
import androidx.compose.ui.semantics.semantics
import androidx.compose.ui.unit.dp

val listState = rememberLazyListState()
// The FAB is initially shown. Upon scrolling past the first item we hide the FAB by using a
// remembered derived state to minimize unnecessary compositions.
val fabVisible by remember { derivedStateOf { listState.firstVisibleItemIndex == 0 } }

Scaffold(
    floatingActionButton = {
        // A FAB should have a tooltip associated with it.
        TooltipBox(
            positionProvider =
                TooltipDefaults.rememberTooltipPositionProvider(TooltipAnchorPosition.Above),
            tooltip = {
                PlainTooltip(
                    modifier =
                        Modifier.semantics {
                            // TODO(b/496338253): Remove this modifier once bug where tooltip
                            //  text is not announced by a11y screen readers is resolved.
                            liveRegion = LiveRegionMode.Assertive
                            paneTitle = "Localized description"
                        }
                ) {
                    Text("Localized description")
                }
            },
            state = rememberTooltipState(),
        ) {
            MediumFloatingActionButton(
                modifier =
                    Modifier.animateFloatingActionButton(
                        visible = fabVisible,
                        alignment = Alignment.BottomEnd,
                    ),
                onClick = { /* do something */ },
            ) {
                Icon(
                    Icons.Filled.Add,
                    contentDescription = "Localized description",
                    modifier = Modifier.size(FloatingActionButtonDefaults.MediumIconSize),
                )
            }
        }
    },
    floatingActionButtonPosition = FabPosition.End,
) {
    LazyColumn(state = listState, modifier = Modifier.fillMaxSize()) {
        for (index in 0 until 100) {
            item { Text(text = "List item - $index", modifier = Modifier.padding(24.dp)) }
        }
    }
}
```
