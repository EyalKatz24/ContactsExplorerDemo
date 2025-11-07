# ContactsExplorerDemo 📱

A lightweight demo Contacts Explorer application built with SwiftUI and The Composable Architecture (TCA), demonstrating modern iOS development practices and clean architecture principles.

## Overview

ContactsExplorerDemo is a demo application that showcases a complete, modular iOS app architecture. It provides an interface for exploring device contacts, featuring real-time synchronization, persistent favorites, and a design system that adapts to the latest iOS features.

## Architecture 🏗️

The project follows **Clean Architecture** principles with a clear separation of concerns, organized into four distinct layers using local Swift Package Manager modules:

### Layer Structure

- **`Data`** 💾: Models and services layer, handling data persistence and external API interactions
- **`Domain`** 🎯: Business logic layer containing use cases and domain rules
- **`Presentation`** 🎨: UI layer built with SwiftUI and TCA, including features, navigators, and design system
- **`Utilities`** 🔧: Shared utilities and extensions used across layers

### Architectural Pattern

The presentation layer implements the **MVI (Model-View-Intent)** pattern using [The Composable Architecture](https://github.com/pointfreeco/swift-composable-architecture) (v1.23.1+), providing:

- Predictable state management
- Testable business logic
- Clear separation between view actions and side effects
- Type-safe navigation and feature composition

### Key Dependencies

- **Composable Architecture**: State management and unidirectional data flow
- **Swift Sharing**: Persistent storage for favorite contacts
- **Identified Collections**: Efficient collection management with stable identifiers
- **[Localized](https://github.com/EyalKatz24/Localized)**: Type-safe localization system (personally developed Swift macro for enum-based localization)
- **[VeryLazy](https://github.com/EyalKatz24/swiftui-very-lazy)**: Optimized lazy loading and shimmer effects for SwiftUI views (personally developed SPM)

## Features ✨

### Contacts Management
- **Complete Contact List**: Displays all device contacts with smooth, performant lazy loading
- **Real-time Search & Filter**: Search contacts by name or phone number with debounced, cancellable filtering
- **Contact Details**: Comprehensive detail view showing:
  - Contact photos with dynamic gradient backgrounds
  - Phone numbers with type labels
  - Email addresses
  - Job titles and company information
  - Birthday information

### User Experience
- **Favorite Contacts**: Persistent favorites system with file-based storage
- **Contextual Actions**: Toggle favorites via context menus or dedicated buttons
- **Real-time Synchronization**: Automatically syncs when contacts are added, edited, or removed in Apple's Contacts app
- **Authorization Handling**: Graceful permission request flow with clear error states
- **Empty States**: Thoughtfully designed empty states for various scenarios

### Design System
- **Modern UI**: Leverages iOS 26+ liquid glass effects where available
- **Adaptive Design**: Supports iOS 18.2+ with feature detection for newer APIs
- **Dynamic Colors**: Contact-specific gradient backgrounds based on image average colors
- **Accessibility**: Built with accessibility considerations (see Known Issues for ongoing improvements)
- **SwiftUI Previews**: Every view and feature includes working Xcode previews

## Technical Highlights ⚙️

### State Management
- Unidirectional data flow with TCA reducers
- Observable state using `@ObservableState`
- Type-safe action composition
- Dependency injection using TCA's dependency system

### Performance
- Lazy loading for contact lists
- Debounced search with cancellable effects
- Efficient collection updates using IdentifiedCollections
- Actor-based service layer for thread-safe operations

### Data Persistence
- File-based persistence for favorites using Swift Sharing
- In-memory caching for all contacts
- Automatic synchronization via `CNContactStoreDidChange` notifications

### Navigation
- Type-safe navigation with TCA
- Modular navigator composition
- Deep linking support structure

## Requirements 📋

- **iOS** 📱: 18.2+
- **Swift** 🦉: 5.10+
- **Xcode** 🛠️: 15.0+ (recommended)
- **Dependencies** 📦: Managed via Swift Package Manager

## Getting Started 🚀

### Prerequisites

1. Ensure you have Xcode 15.0 or later installed
2. Clone the repository:
   ```bash
   git clone https://github.com/EyalKatz24/ContactsExplorerDemo.git
   cd ContactsExplorerDemo
   ```

### Building the Project

1. Open `ContactsExplorerDemo.xcodeproj` in Xcode
2. Select your target device or simulator
3. Build and run (⌘R)

The project uses Swift Package Manager for dependency management. Dependencies will be automatically resolved on first build.

### Permissions

The app requires Contacts permission to function. On first launch, iOS will prompt for permission. If denied, you can grant access via Settings → ContactsExplorerDemo → Contacts.

## Project Structure 📁

```
ContactsExplorerDemo/
├── ContactsExplorerDemo/          # Main app target
│   ├── App/                       # App entry point
│   ├── Localization/              # Localized strings
│   └── Supporting Files/          # Assets and resources
├── Data/                          # Data layer package
│   ├── Models/                    # Domain models
│   └── Services/                  # Data services
├── Domain/                        # Domain layer package
│   └── UseCases/                  # Business logic use cases
├── Presentation/                  # Presentation layer package
│   ├── Features/                  # Feature modules
│   ├── Navigators/                # Navigation modules
│   └── DesignSystem/              # Reusable UI components
└── Utilities/                     # Utilities package
    └── Extensions/                # Shared extensions
```

## Known Issues & Future Improvements 🔧

The following areas are being actively refined:

1. **Unit Tests**: The project is currently missing unit tests due to rapid development constraints. Comprehensive test coverage will be added very soon for each layer (Data, Domain, Presentation, and Utilities).

2. **Search & Filter Enhancement**: Text highlighting and search matching logic needs improvement to handle additional edge cases and provide more precise results.

3. **Dynamic Type Support**: Lazy loading layouts for larger dynamic type sizes require pixel-perfect refinement to ensure optimal rendering across all accessibility settings.

4. **Accessibility Compliance**: The dynamic gradient backgrounds based on contact image average colors may not always meet AAA contrast standards. I'm exploring solutions to ensure consistent accessibility compliance while maintaining the visual design.

## Contributing 💬

This is a demo project, but feedback and suggestions are welcome. If you encounter any issues or have ideas for improvement, please feel free to open an issue on GitHub.

## License 📄

See the [LICENSE](LICENSE) file for details.

## Author 👤

**Eyal Katz**

For questions or feedback, please visit the [GitHub repository](https://github.com/EyalKatz24/ContactsExplorerDemo).

---

*Built with ❤️ using SwiftUI and The Composable Architecture*
