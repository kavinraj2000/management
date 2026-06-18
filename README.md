# Profile Discovery App

## Overview

Profile Discovery is a Flutter application built using **Clean Architecture**, **MVVM principles**, and **BLoC State Management**. The application allows users to sign in, manage profile information, upload profile images using the device camera or gallery, store temporary user data locally, edit profile details, and apply filtering functionality for profile discovery.

The project focuses on scalability, maintainability, separation of concerns, and production-ready architecture.

---

# Project Setup Instructions

## Prerequisites

Before running the project, ensure the following tools are installed:

* Flutter SDK (Latest Stable Version)
* Dart SDK
* Android Studio / VS Code
* Android Emulator or Physical Device
* Git

## Clone Repository

```bash
git clone git clone https://github.com/kavinraj2000/management.git

cd profile-discovery
```

## Install Dependencies

```bash
flutter pub get
```

## Run Application

```bash
flutter run
```

## Generate Build

Android APK:

```bash
flutter build apk --release
```

Android App Bundle:

```bash
flutter build appbundle --release
```

---

# Architecture Overview

The application follows **Clean Architecture** combined with **MVVM** and **BLoC** for state management.

## Architecture Layers

### Presentation Layer

Responsible for UI rendering and user interactions.

Components:

* Screens
* Widgets
* BLoCs
* Events
* States

Responsibilities:

* Handle UI updates
* Dispatch events
* Listen to state changes

---

### Domain Layer

Contains business logic and application rules.

Components:

* Entities
* Repository Contracts
* Use Cases

Responsibilities:

* Independent of frameworks
* Contains core business rules
* Reusable and testable

---

### Data Layer

Responsible for data handling.

Components:

* Repository Implementations
* Local Data Sources
* Models

Responsibilities:

* Data transformation
* Communication with local storage
* Mapping models to entities

---

# Folder Structure

```text
lib/
│
├── core/
│   ├── constants/
│   ├── utils/
│   └── services/
│
├── data/
│   ├── datasource/
│   │   └── local/
│   ├── models/
│   └── repositories/
│
├── domain/
│   ├── entities/
│   ├── repositories/
│   └── usecases/
│
├── presentation/
│   ├── pages/
│   ├── widgets/
│   ├── viewmodels/
│   └── blocs/
│
└── main.dart
```

---

# Features

## Authentication

* User Sign In
* Form Validation
* Temporary local session storage

---

## Profile Management

* View profile information
* Edit profile details
* Update profile image
* Persist temporary profile data locally

---

## Image Picker Integration

Supports:

### Gallery Access

Users can select profile images from device storage.

### Camera Access

Users can capture profile pictures directly from the device camera.

---

## Local Database Storage

Temporary user information is stored using local database storage.

Stored Information:

* User Name
* Email
* Profile Image Path
* Session Information

Benefits:

* Offline availability
* Faster data retrieval
* Reduced dependency on network calls

---

## Filter Functionality

Users can filter profile data based on predefined criteria.

Example filters:

* Name


Features:

* Real-time filtering
* Efficient state updates using BLoC
* Dynamic UI refresh

---

# State Management

The project uses Flutter BLoC.

## Flow

```text
UI
 ↓
Event
 ↓
BLoC
 ↓
Use Case
 ↓
Repository
 ↓
Local Database
 ↓
State
 ↓
UI Update
```

Benefits:

* Predictable state management
* Separation of UI and business logic
* Easy testing and maintenance

---

# Libraries Used

## State Management

```yaml
flutter_bloc
equatable
```

Purpose:

* Business logic management
* State comparison optimization

---

## Dependency Injection

```yaml
get_it

```

Purpose:

* Service registration
* Loose coupling

---

## Local Database

Choose one:



```yaml
sqflite
```

Purpose:

* Temporary local data persistence

---

## Image Handling

```yaml
image_picker
```

Purpose:

* Camera access
* Gallery image selection

---

## Form Validation

```yaml
form_builder_validators
```

Purpose:

* Input validation

---

## Utility Libraries

```yaml
path_provider
shared_preferences
```

Purpose:

* Local file storage
* Session management


# Assumptions and Decisions

## Clean Architecture

Decision:

* Business logic is isolated from UI and data layers.

Reason:

* Improves scalability and maintainability.


## BLoC State Management

Decision:

* Use BLoC for all state transitions.

Reason:

* Predictable state flow.
* Easier testing.


## Local Storage First

Decision:

* User profile information is stored locally for temporary persistence.

Reason:

* Faster loading.
* Offline support.



## Image Storage

Decision:

* Store image path locally instead of storing image bytes.

Reason:

* Reduced storage consumption.
* Better performance.


## MVVM Pattern

Decision:

* Separate UI rendering from presentation logic.

Reason:

* Cleaner codebase.
* Easier feature expansion.



## Future Enhancements

* Backend API Integration
* JWT Authentication
* Profile Synchronization
* Cloud Image Upload
* Pagination
* Advanced Search Filters
* Unit Testing
* Integration Testing
* CI/CD Pipeline
* Push Notifications


# Conclusion

This project demonstrates a scalable Flutter application using Clean Architecture, MVVM, and BLoC. The architecture ensures maintainability, testability, and clear separation of concerns while supporting profile management, local data storage, image selection, camera integration, and profile filtering functionality.
