# Domain Layer 🎯

The Domain layer captures the business rules that drive ContactsExplorerDemo. It coordinates how the app interacts with contacts by exposing focused use cases that sit between presentation logic and the data service.

## Responsibilities
- Wrap the `ContactsService` in intent-based use cases (fetch, filter, toggle favorite, etc.)
- Express app-specific workflows, such as opening Settings when permission is denied
- Normalize asynchronous work so reducers can depend on simple, testable functions
- Provide a single access point (`ContactsUseCases` and `AppUseCases`) for the Presentation layer

## Use-Case Groups
- **Contacts**: Retrieval, filtering, authorization checks, favorite toggling, and metadata queries. Each function lives in its own use-case struct registered with Swift Dependencies.
- **App**: Currently exposes opening the system Settings app. The pattern is ready for future global actions.

## Collaboration Pattern
1. The Presentation layer requests a dependency (for example, `contacts.retrieveAll`).
2. The use case delegates to the Data layer actor, handles mapping, and returns a project-level result.
3. Reducers react to the result without touching the Contacts framework directly.

## Dependency Management
- Uses Swift Dependencies to inject live, test, and preview implementations of every use case.
- Depends on the `Models` and `Services` targets from the Data package, plus shared helpers from Utilities.
- Keeps all interfaces Sendable and composable, mirroring TCA expectations.

## Current Status
All core contact scenarios have live use cases, and the dependency graph is stable. Layer-specific unit tests are planned next so reducers can rely on dedicated test doubles instead of ad-hoc stubs.

