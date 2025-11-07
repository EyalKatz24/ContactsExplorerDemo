# Presentation Layer 🎨

The Presentation layer delivers the user experience for ContactsExplorerDemo. It is written entirely in SwiftUI, follows the MVI pattern, and relies on The Composable Architecture (TCA) for predictable state management.

## Responsibilities
- Render features (Contacts and Contact Details) with SwiftUI views backed by TCA reducers
- Coordinate navigation through dedicated navigator reducers and views
- Provide a reusable design system, ensuring consistent visuals across screens
- Bridge user intents to Domain layer use cases via small, testable interactors

## Structure
- **Features**: `ContactsFeature` and `ContactDetailsFeature` expose `Store`-driven SwiftUI views, reducers, and interactors. They react to authorization, search, and real-time contact updates.
- **Navigators**: `AppNavigator` orchestrates the root flow, while `ContactsNavigator` manages stacked navigation between the list and detail screens. Both listen for contact changes and keep paths in sync.
- **DesignSystem**: Houses common components (contact cards, empty states, shimmer placeholders), view modifiers (glass effect, grouping, feature scaffolding), styles, and extensions shared by every feature.
- **InternalUtilities**: Collects localization enums, effect helpers (debounce, delayed sends), and minor extensions used only within presentation logic.

## State & Side Effects
- All reducers use `@ObservableState`, `@ViewAction`, and dependency injection to keep state changes explicit.
- Effects are carefully scoped: contact retrieval, search filtering, and favorite toggles are delegated to Domain use cases, while UI-only work (animations, first-appear hooks) stays inside the layer.
- Shared state such as favorites leverages the `@Shared` wrapper so navigating between list and detail views stays in sync without manual plumbing.

## Dependencies & Collaboration
- Depends on Utilities for foundational helpers, Data for models, Domain for use cases, and personally developed packages ([Localized](https://github.com/EyalKatz24/Localized), [VeryLazy](https://github.com/EyalKatz24/swiftui-very-lazy)) for localization and lazy rendering.
- Emits navigation actions and view effects that Domain fulfills, keeping presentation code agnostic of data-access details.

## Current Status
Navigation, design system components, and feature logic are all implemented with working previews. Structured UI tests and reducer-specific unit tests are planned so interaction flows remain stable as features evolve.

