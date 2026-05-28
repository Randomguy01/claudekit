# Examples

> Last updated 2026-05-06 UTC

```kotlin
import androidx.compose.material3.Button
import androidx.compose.material3.ElevatedButton
import androidx.compose.material3.Text

ElevatedButton(onClick = { /* Do something! */ }) { Text("Elevated Button") }
```

```kotlin
import androidx.compose.material3.Button
import androidx.compose.material3.ButtonDefaults
import androidx.compose.material3.ElevatedButton
import androidx.compose.material3.Text

ElevatedButton(onClick = {}, shapes = ButtonDefaults.shapes()) { Text("Elevated Button") }
```
