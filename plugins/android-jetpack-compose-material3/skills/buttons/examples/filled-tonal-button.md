# Examples

> Last updated 2026-05-06 UTC

```kotlin
import androidx.compose.material3.Button
import androidx.compose.material3.FilledTonalButton
import androidx.compose.material3.Text

FilledTonalButton(onClick = { /* Do something! */ }) { Text("Filled Tonal Button") }
```

```kotlin
import androidx.compose.material3.Button
import androidx.compose.material3.ButtonDefaults
import androidx.compose.material3.FilledTonalButton
import androidx.compose.material3.Text

FilledTonalButton(onClick = {}, shapes = ButtonDefaults.shapes()) {
    Text("Filled Tonal Button")
}
```
