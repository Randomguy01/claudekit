---
name: buttons
description: API reference for all Material 3 button components in Android Jetpack Compose
---


## Components

- `Button` - Filled buttons are high-emphasis buttons. Filled buttons have the most visual impact after the FloatingActionButton, and should be used for important, final actions that complete a flow, like "Save", "Join now", or "Confirm".
- `ElevatedButton` - Elevated buttons are high-emphasis buttons that are essentially FilledTonalButtons with a shadow. To prevent shadow creep, only use them when absolutely necessary, such as when the button requires visual separation from patterned container.
- `FilledTonalButton` - Filled tonal buttons are medium-emphasis buttons that is an alternative middle ground between default Buttons (filled) and OutlinedButtons. They can be used in contexts where lower-priority button requires slightly more emphasis than an outline would give, such as "Next" in an onboarding flow. Tonal buttons use the secondary color mapping.
- `FloatingActionButton` - The FAB represents the most important action on a screen. It puts key actions within reach.
- `IconButton` - The FAB represents the most important action on a screen. It puts key actions within reach. 
- `LargeFloatingActionButton` - The FAB represents the most important action on a screen. It puts key actions within reach. 
- `MediumFloatingActionButton` - The FAB represents the most important action on a screen. It puts key actions within reach.
- `SmallFloatingActionButton` - The FAB represents the most important action on a screen. It puts key actions within reach. 

## Choosing a Button

How to choose the best button for an action based on the amount of emphasis:
- See OutlinedButton for a medium-emphasis button with a border.
- See ElevatedButton for an FilledTonalButton with a shadow.
- See TextButton for a low-emphasis button with no border.
- See FilledTonalButton for a middle ground between OutlinedButton and Button.

