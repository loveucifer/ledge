<p align="center">
  <img src="assets/images/icon.png" alt="ledger Logo" width="150"/>
</p>



# Ledge

An expense tracking application that embodiesminimalist design philosophy with clean typography, subtle shadows, and elegant micro-interactions.


## Features


### Data Visualizations
- **Colorful Charts**: Vibrant, distinct colors for clear data differentiation
- **Pie Charts**: Category breakdown with percentage visualization
- **Spending Trends**: Visual representation of monthly expenses

### Expense Management
- **Add Expenses**: Quick entry with smart category suggestions
- **Edit/Delete**: Full CRUD operations with swipe-to-delete
- **Category System**: Predefined categories with custom icons
- **Multi-Currency**: Support for ₹, $, €, £ with Indian Rupee as default

### Theme Support
- **Light/Dark Mode**: Seamless theme switching
- **Persistent Preferences**: Theme choice saved between sessions
- **System Adaptive**: Automatically adapts to system theme

### Offline-First Architecture
- **Local Storage**: SharedPreferences for persistent data storage
- **No Authentication**: Private by default, no account required
- **Instant Access**: Works immediately without network connectivity


### Prerequisites
- Flutter SDK 3.0 or higher
- Dart SDK 2.17 or higher
- Android Studio / VS Code with Flutter extensions

### Installation

1. **Clone the repository**
```bash
git clone https://github.com/your-username/ledge.git
cd ledge
```

2. **Install dependencies**
```bash
flutter pub get
```

3. **Run the app**
```bash
flutter run
```

### Building for Production

**Android:**
```bash
flutter build apk --release
```

**iOS:**
```bash
flutter build ios --release
```

## 🛠️ Tech Stack

- **Framework**: [Flutter](https://flutter.dev)
- **State Management**: [Provider](https://pub.dev/packages/provider)
- **Data Visualization**: [fl_chart](https://pub.dev/packages/fl_chart)
- **Local Storage**: [shared_preferences](https://pub.dev/packages/shared_preferences)
- **Date Formatting**: [intl](https://pub.dev/packages/intl)
- **UI Components**: Material Design with custom theming

## 📁 Project Structure

```
lib/
├── main.dart                 # App entry point
├── models/                   # Data models
│   ├── expense.dart          # Expense model
│   ├── category.dart         # Category model
│   └── predefined_categories.dart # Predefined categories
├── providers/                # State management
│   └── expense_provider.dart # Expense state provider
├── screens/                  # Main screens
│   ├── dashboard_screen.dart # Main dashboard
│   ├── add_expense_screen.dart # Add expense form
│   ├── edit_expense_screen.dart # Edit expense form
│   └── settings_screen.dart  # Settings screen
├── widgets/                  # Reusable components
│   ├── expense_chart.dart    # Data visualization
│   ├── expense_list.dart     # Expense list component
│   └── month_selector.dart   # Month navigation
└── services/                 # Business logic
    └── local_storage_service.dart # Local storage handling
```

## Contributing

We welcome contributions from the community! Here's how you can help:

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

### Development Setup

1. Ensure you have Flutter installed and set up
2. Fork and clone the repository
3. Run `flutter pub get` to install dependencies
4. Run `flutter analyze` to check for code issues
5. Run `flutter test` to execute tests

### Coding Standards

- Follow the existing code style
- Write meaningful commit messages
- Add tests for new functionality
- Update documentation as needed

##  Testing

Run the test suite:
```bash
flutter test
```

Run tests with coverage:
```bash
flutter test --coverage
```

## 📖 Documentation

### Architecture

Ledge follows a clean architecture pattern with:
- **Models**: Data structures and business logic
- **Providers**: State management using Provider package
- **Services**: Data access layer (local storage)
- **Screens**: Main UI pages and user flows
- **Widgets**: Reusable UI components

### State Management

The app uses the Provider package for state management:
- `ExpenseProvider`: Manages the list of expenses and provides methods for CRUD operations
- Change notifications automatically update the UI when data changes

### Data Persistence

All data is stored locally using SharedPreferences:
- Expenses are serialized to JSON and stored as a string list
- Theme preferences and currency settings are also persisted

## 🐛 Reporting Issues

If you find a bug or have a feature request, please [open an issue](https://github.com/your-username/ledge/issues) on GitHub. When reporting a bug, please include:

1. A clear description of the issue
2. Steps to reproduce the problem
3. Expected vs. actual behavior
4. Screenshots if applicable
5. Device and OS information

## 📜 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
