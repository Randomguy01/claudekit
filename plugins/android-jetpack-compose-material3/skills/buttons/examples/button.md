# Examples

> Last updated 2026-05-06 UTC

```kotlin
import androidx.compose.material3.Button
import androidx.compose.material3.Text

Button(onClick = {}) { Text("Button") }
```

```kotlin
import androidx.compose.foundation.layout.Spacer
import androidx.compose.foundation.layout.size
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.filled.Favorite
import androidx.compose.material3.Button
import androidx.compose.material3.ButtonDefaults
import androidx.compose.material3.Icon
import androidx.compose.material3.Text
import androidx.compose.ui.Modifier

Button(
    onClick = { /* Do something! */ },
    contentPadding =
        ButtonDefaults.contentPaddingFor(ButtonDefaults.MinHeight, hasStartIcon = true),
) {
    Icon(
        Icons.Filled.Favorite,
        contentDescription = "Localized description",
        modifier = Modifier.size(ButtonDefaults.iconSizeFor(ButtonDefaults.MinHeight)),
    )
    Spacer(Modifier.size(ButtonDefaults.iconSpacingFor(ButtonDefaults.MinHeight)))
    Text("Like")
}
```

Button that uses a square shape instead of the default round shape:
```kotlin
import androidx.compose.material3.Button
import androidx.compose.material3.ButtonDefaults
import androidx.compose.material3.Text

Button(onClick = { /* Do something! */ }, shape = ButtonDefaults.squareShape) { Text("Button") }
```

Button that utilizes the small design content padding:
```kotlin
import androidx.compose.material3.Button
import androidx.compose.material3.ButtonDefaults
import androidx.compose.material3.Text

Button(onClick = { /* Do something! */ }, contentPadding = ButtonDefaults.SmallContentPadding) {
    Text("Button")
}
```

Button uses the small design spec as default. For a Button that uses the design for extra small, medium, large, or extra large buttons:
```kotlin
import androidx.compose.foundation.layout.Spacer
import androidx.compose.foundation.layout.heightIn
import androidx.compose.foundation.layout.size
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.filled.Edit
import androidx.compose.material3.Button
import androidx.compose.material3.ButtonDefaults
import androidx.compose.material3.Icon
import androidx.compose.material3.Text
import androidx.compose.ui.Modifier

val size = ButtonDefaults.ExtraSmallContainerHeight // or ButtonDefaults.MediumContainerHeight, ButtonDefaults.LargeContainerHeight, ButtonDefaults.ExtraLargeContainerHeight
Button(
    onClick = { /* Do something! */ },
    modifier = Modifier.heightIn(size),
    contentPadding = ButtonDefaults.contentPaddingFor(size, hasStartIcon = true),
) {
    Icon(
        Icons.Filled.Edit,
        contentDescription = "Localized description",
        modifier = Modifier.size(ButtonDefaults.iconSizeFor(size)),
    )
    Spacer(Modifier.size(ButtonDefaults.iconSpacingFor(size)))
    Text("Label")
}
```

```kotlin
import androidx.compose.material3.Button
import androidx.compose.material3.ButtonDefaults
import androidx.compose.material3.Text

Button(onClick = {}, shapes = ButtonDefaults.shapes()) { Text("Button") }
```
