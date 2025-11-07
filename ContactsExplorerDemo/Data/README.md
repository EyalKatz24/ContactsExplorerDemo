# Data Layer 💾

The Data layer owns every concern related to retrieving, mapping, and persisting contact information. It hides the iOS Contacts framework behind stable models and services so the rest of the project can reason about contacts without dealing with platform details.

## Responsibilities
- Define contact-centric domain models and supporting value types
- Provide an actor-based service that talks to the Contacts framework
- Persist in-memory and on-disk state required by upper layers (for example, favorite contacts)
- Translate framework errors and authorization statuses into project-specific abstractions

## Modules
- **`Models`**: Swift value types such as `Contact`, `Contact.PhoneNumber`, `Contact.Email`, `ContactsError`, and `ContactsAuthorization`. These structs are Codable, Sendable, and designed to stay stable regardless of framework changes.
- **`Services`**: Contains `ContactsService`, an actor that encapsulates fetching, authorization, and favorite management. It uses Swift Sharing for persistence and Identified Collections for efficient storage.

## Persistence & Synchronization
- Contacts are cached in memory (`@Shared(.allContacts)`) after every successful fetch so presentation and domain logic can react instantly.
- Favorite contacts use file-backed shared storage (`@Shared(.favoriteContacts)`) to keep state across launches while remaining lightweight.
- The service tracks whether contacts were already fetched, allowing higher layers to avoid redundant work.

## Error & Authorization Abstractions
- Framework-specific errors are mapped to the `ContactsError` enum, giving upper layers predictable cases to handle.
- Authorization status is exposed through the `ContactsAuthorization` enum, decoupling business logic from `CNAuthorizationStatus`.

## Dependencies & Collaboration
- Depends on the Utilities package for cross-cutting string and collection helpers.
- Exposes two library products (`Models` and `Services`) consumed by the Domain and Presentation layers.
- Integrates with Swift Dependencies and Swift Sharing so other layers can request the data service through dependency injection.

## Current Status
Documentation, models, and services are in place. Structured unit tests are planned next so the actor and persistence logic can be verified independently of the UI.

