# 🏋️ Gym Management System

A comprehensive, production-ready Flutter application for managing gym operations with Clean Architecture, BLoC pattern, and beautiful Material 3 design.

![Flutter](https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white)
![Dart](https://img.shields.io/badge/Dart-0175C2?style=for-the-badge&logo=dart&logoColor=white)
![Material Design](https://img.shields.io/badge/Material%20Design-757575?style=for-the-badge&logo=material-design&logoColor=white)
![Clean Architecture](https://img.shields.io/badge/Clean%20Architecture-4CAF50?style=for-the-badge)

## ✨ Features

### 👥 Member Management

- Complete member profiles with personal information
- Membership status tracking
- Member search and filtering
- Profile management

### 📅 Class Scheduling

- Create and manage gym classes
- Instructor assignment
- Class capacity management
- Schedule viewing and booking

### 🏋️ Equipment Tracking

- Equipment inventory management
- Maintenance scheduling
- Equipment status monitoring
- Usage tracking

### 💳 Payments & Billing

- Member payment tracking
- Subscription management
- Payment history
- Billing notifications

### 📊 Attendance Tracking

- QR code check-in system
- Real-time attendance monitoring
- Class attendance reports
- Member attendance history

### 👨‍🏫 Trainer Management

- Trainer profiles and specializations
- Class assignments
- Performance tracking
- Schedule management

### 📈 Reports & Analytics

- Dashboard with key metrics
- Revenue reports
- Attendance analytics
- Equipment utilization reports

### 🔔 Notifications

- Class reminders
- Payment notifications
- System alerts
- Custom notifications

### 👤 Profile Management

- User profile settings
- Preferences management
- Account security
- Personal information

### 📱 QR Code Check-In

- Advanced QR scanning
- Payment verification before check-in
- Real-time validation
- Secure access control

## 🏗️ Architecture

This app follows **Clean Architecture** principles with a **feature-first** folder structure and well-defined layers. The goal is to keep each feature isolated, maintainable, and easy to extend.

### 🧱 System Architecture Overview

At a high level, the system is organized into three main layers, with a shared core and feature modules.

1. **Presentation Layer**
   - UI widgets (pages, dialogs, forms)
   - BLoC classes (state management)
   - Event → State flow

2. **Domain Layer**
   - Business rules and use cases
   - Entities and models
   - Repository interfaces (abstractions)

3. **Data Layer**
   - Concrete repository implementations
   - Data sources (mock/remote/local)
   - API clients and network handling

> **Data flow example:**
>
> 1. User action triggers a BLoC event in Presentation.
> 2. BLoC calls a Use Case in Domain.
> 3. Use Case calls a Repository interface.
> 4. Repository implementation in Data fetches data (mock or API).
> 5. Data is returned back through layers to the UI.
>
> **System architecture (ASCII diagram):**
>
> ```
> [UI/Widgets]  <--->  [BLoC / State]  <--->  [Use Cases]
>      ^                     ^                 ^
>      |                     |                 |
>      +---------------------+                 |
>                    |                         |
>               [Repositories]  <------------+
>                    |
>     +--------------+----------------+
>     |                               |
> [Local Data]                   [Remote API]
> ```
>
> **Diagram legend:**
>
> - **UI/Widgets**: Flutter pages, forms, dialogs, and visual components.
> - **BLoC / State**: Business logic components that react to events and emit states.
> - **Use Cases**: Domain-level actions that enforce business rules.
> - **Repositories**: Abstractions that provide data from local or remote sources.
> - **Local Data**: Mock data stores, local persistence, caching layers.
> - **Remote API**: Network calls, REST endpoints, and remote services.

### 🗂️ Folder Structure (Feature-First)

```
lib/
├── core/                    # Core functionality (DI, networking, session, utils)
│   ├── di/                 # Dependency injection
│   ├── network/            # Network utilities
│   ├── session/            # Session management
│   └── utils/              # Utility functions
├── features/               # Feature modules (each contains presentation/domain/data)
│   ├── auth/              # Authentication
│   ├── members/           # Member management
│   ├── classes/           # Class scheduling
│   ├── equipment/         # Equipment tracking
│   ├── payments/          # Payment system
│   ├── attendance/        # Attendance tracking
│   ├── trainers/          # Trainer management
│   ├── reports/           # Analytics & reports
│   ├── notifications/     # Notification system
│   ├── profile/           # Profile management
│   └── qr_checkin/        # QR check-in system
├── shared/                # Shared components (themes, widgets, constants)
│   ├── themes/           # App themes
│   ├── widgets/          # Reusable widgets
│   └── constants/        # App constants
└── main.dart             # App entry point
```

### 🏛️ Design Patterns

- **BLoC Pattern** for state management (events → states)
- **Repository Pattern** for data access and separation
- **Dependency Injection** with GetIt (service locator)
- **Clean Architecture** layering (Presentation, Domain, Data)
- **Event Bus** for cross-feature communication

## 🛠️ Tech Stack

- **Framework**: Flutter 3.0+
- **Language**: Dart 3.0+
- **State Management**: flutter_bloc ^8.1.3
- **Dependency Injection**: get_it ^7.6.4
- **HTTP Client**: dio ^5.3.3
- **Network Monitoring**: connectivity_plus ^5.0.2
- **QR Scanning**: mobile_scanner ^6.0.0
- **Event Bus**: event_bus ^2.0.0
- **UI Design**: Material Design 3

## 🚀 Getting Started

### Prerequisites

- Flutter SDK >= 3.0.0
- Dart SDK >= 3.0.0
- Android Studio / VS Code with Flutter extensions
- Git

### Installation

1. **Clone the repository**

   ```bash
   git clone https://github.com/kelemnati/gym-management-sys.git
   cd gym-management
   ```

2. **Install dependencies**

   ```bash
   flutter pub get
   ```

3. **Run the app**
   ```bash
   flutter run
   ```

### Test Credentials

The app includes mock authentication for testing. Use these credentials to log in:

- **Admin Account:**
  - Email: `admin@gym.com`
  - Password: `admin123`

- **Staff Account:**
  - Email: `staff@gym.com`
  - Password: `staff123`

### Build for Production

**Android APK:**

```bash
flutter build apk --release
```

**iOS (on macOS):**

```bash
flutter build ios --release
```

**Web:**

```bash
flutter build web --release
```

## 📱 Screenshots

### Home Dashboard

Beautiful grid layout with feature cards and quick access to all modules.

### QR Check-In

Advanced QR scanning using the **mobile_scanner** plugin with payment verification and real-time feedback.

### Member Management

Complete member profiles with search, filtering, and detailed information.

### Reports Dashboard

Comprehensive analytics with charts and key performance indicators.

## 🔧 Configuration

### Environment Setup

The app uses mock data by default. To connect to a real backend:

1. Update `lib/core/network/api_endpoints.dart` with your API URLs
2. Implement real API calls in data sources
3. Configure authentication tokens
4. Set up push notification services

### Theme Customization

Modify `lib/shared/themes/app_theme.dart` to customize colors and styling:

```dart
const ColorScheme colorScheme = ColorScheme(
  primary: Color(0xFF1E3A8A),      // Deep Blue
  secondary: Color(0xFF059669),    // Emerald
  tertiary: Color(0xFFF59E0B),     // Amber
  // ... other colors
);
```

## 🧪 Testing

Run tests:

```bash
flutter test
```

Run tests with coverage:

```bash
flutter test --coverage
```

## 📊 Code Quality

- **Linting**: `flutter analyze`
- **Formatting**: `flutter format .`
- **Code Metrics**: Follows Flutter best practices
- **Null Safety**: Full null safety implementation

## 🔒 Security Features

- Secure QR code validation
- Payment verification before check-in
- Session management
- Network security with Dio interceptors
- Input validation and sanitization

## 🌟 Key Highlights

### Payment-Verified QR Check-In

The QR check-in system verifies member payment status before allowing access, ensuring only active members can check into classes.

### Beautiful Material 3 Design

Modern, professional UI with custom color scheme, smooth animations, and responsive design.

### Comprehensive Mock Data

Rich mock data for all features, making the app fully functional for demonstrations and testing.

### Production-Ready Architecture

Scalable architecture ready for backend integration and enterprise deployment.

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## 📝 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- Flutter team for the amazing framework
- Material Design for beautiful design system
- Open source community for inspiration and tools

## 📞 Support

For support, email natikeleme1@gmail.com

---

**Made with ❤️ using Flutter**
