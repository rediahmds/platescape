# Platescape

Where every plate tells a story – A sleek and intuitive app for mocking restaurant menus and  
showcasing delicious dishes. Designed for seamless exploration, it allows users to browse menus
and  
discover restaurants effortlessly. Perfect for prototyping a restaurant app with Flutter. 🚀🍽️

## Introduction

This Flutter application is developed as part of an online course on Flutter development. The
project aims to enhance knowledge and hands-on experience in building mobile applications using
Flutter and Dart.

## Design Inspiration

This app draws significant inspiration from designs found on [Dribbble](https://dribbble.com/).
Below are the designs that influenced this project the most, with gratitude to their creators:

- [Cari Kopi - Cafe/Coffie Shop Finder](https://dribbble.com/shots/18232643-Cari-Kopi-Cafe-Coffie-Shop-Finder?utm_source=Clipboard_Shot&utm_campaign=asaldesign&utm_content=Cari%20Kopi%20-%20Cafe/Coffie%20Shop%20Finder&utm_medium=Social_Share&utm_source=Clipboard_Shot&utm_campaign=asaldesign&utm_content=Cari%20Kopi%20-%20Cafe/Coffie%20Shop%20Finder&utm_medium=Social_Share)
  by [Asal Design](https://dribbble.com/asaldesign)
  for [Enver Studio](https://dribbble.com/Enver-studio)
- [Restaurant finder app](https://dribbble.com/shots/18232643-Cari-Kopi-Cafe-Coffie-Shop-Finder?utm_source=Clipboard_Shot&utm_campaign=asaldesign&utm_content=Cari%20Kopi%20-%20Cafe/Coffie%20Shop%20Finder&utm_medium=Social_Share&utm_source=Clipboard_Shot&utm_campaign=asaldesign&utm_content=Cari%20Kopi%20-%20Cafe/Coffie%20Shop%20Finder&utm_medium=Social_Share)
  by [Excel Belmiro](https://dribbble.com/Excelbe)

## Assets

- [PlusJakartaSans](https://github.com/tokotype/PlusJakartaSans) fonts
  via [Google Fonts](https://fonts.google.com/specimen/Plus+Jakarta+Sans)
- App Icon generated using [IconKitchen](https://icon.kitchen/)

## Testing

### Unit and Widget Tests

To run unit and widget tests, use the following command:

```bash
flutter test
```

### Integration Test

The current integration test scenario requires granting a permission at app startup. To automate this process, you can use a test driver along with `adb` commands to allow the required permission.

Run the integration test with the following command:

```bash
flutter drive --driver=test_driver/integration_test_driver.dart --target=integration_test/app_test.dart
```
