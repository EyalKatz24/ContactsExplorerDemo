# Utilities Layer 🔧

The Utilities layer gathers lightweight extensions and helpers that every other package depends on. It keeps common behaviour in one place so higher layers can stay focused on features instead of re-implementing small conveniences.

## Responsibilities
- Provide cross-cutting extensions for core Swift types (`String`, `Character`, `Equatable`)
- Offer neutral helpers that do not depend on Contacts-domain concepts
- Serve as the lowest-level package in the workspace, avoiding circular dependencies

## Key Extensions
- **`String+Extension`**: Adds whitespace constants, trimming helpers, and alphanumeric cleaning—used heavily when presenting contact information.
- **`Character+Extension`**: Supplies reusable character constants for formatting and parsing.
- **`Equatable+Extension`**: Introduces the `includedIn(_:)` helper, simplifying permission checks and other membership tests.

## Collaboration
- Imported by the Data layer for contact parsing, by the Domain layer for comparisons, and by the Presentation layer for formatting. Because the code is dependency-free, it is safe to share everywhere.

## Current Status
The layer is intentionally small and stable. Additional extensions will be added only when a capability is required in multiple places, keeping the package focused and easy to reason about.

