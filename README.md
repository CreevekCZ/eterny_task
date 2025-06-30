# Eterny task

## Thought Process
- I started by using the project setup that I use in other production apps. My tech stack is Flutter, Bloc, Freezed, GetIt with injectable and auto_route.
- I created my usual folder structure.
- I started using localization from the beginning, even though the app is in English only. This allows for easy future localization.
- When I analyzed the content of the JSON data, I found out that there are a lot of catches:
  - JSON keys contain spaces and special characters.
  - bool values are provided as strings.
  - null values are presented as 'NULL' string or an empty string.
  - DateTime values are provided in proprietary format.
  - integer values are provided as strings.
  - children is not a list of objects but an object that contains keys that then contain lists of objects.
- After the analysis, I decided not to strongly type every value but mostly keep data as strings to ensure that the assignment of displaying values in a table goes smoothly.
- Because of the specific shape of the data, there is a need for unit tests that ensure that parsing and formatting work correctly, and it also improves the developer experience

- I created a custom DateTime parse function that handles the proprietary format and converts it to a standard DateTime object.
- I used the `timezone` package to handle timezones and ensure that the date is displayed correctly in the user's local timezone.
- DateTime values are decoded mainly because the future tasks could require sorting or filtering by date, and having a DateTime object allows for easier manipulation.


## Supported Platforms
- iOS
- Android
- macOS

## How to run

### Prerequisites
- Flutter SDK installed (version 3.32.5 or later).
- Dart SDK installed (version 3.32.5 or later).
- An emulator or physical device for testing.
- IDE with Flutter support (e.g., Visual Studio Code, Android Studio).

### Steps to Run the Application
To run the Eterny Task application, follow these steps:

1. Clone the repository.
2. Navigate to the project directory.
3. Run `flutter pub get` to install dependencies.
4. Run `flutter run` to start the application.

## Packages
- bloc https://pub.dev/packages/bloc - State management library that helps to separate business logic from UI.
- freezed https://pub.dev/packages/freezed - Code generation library for immutable classes and union types.
- get_it https://pub.dev/packages/get_it - Service locator for dependency injection and managing app-level services.
- injectable https://pub.dev/packages/injectable - Code generator for get_it dependency injection setup with annotations.
- auto_route https://pub.dev/packages/auto_route - Declarative code generation based router with nested routing support.
- flutter_svg https://pub.dev/packages/flutter_svg - SVG rendering support for Flutter applications.
- skeletonizer https://pub.dev/packages/skeletonizer - Loading state animations and skeleton screens for better UX.
- timezone https://pub.dev/packages/timezone - Comprehensive timezone data and utilities for date/time handling.
- json_serializable https://pub.dev/packages/json_serializable - Automatic JSON serialization code generation.
- flutter_gen https://pub.dev/packages/flutter_gen - Asset code generation for type-safe access to assets and resources.