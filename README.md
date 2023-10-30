
## Getting Started

This project is a flutter application and Flutter SDK needs to be setup to run the project.

A few resources to get you started if this is your first attempt running a Flutter project:

- [Setup: Install Flutter SDK](https://docs.flutter.dev/get-started/install)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

### Project Setup
- Click on the code button to see the repo link
- Open your terminal and run ``` git clone  https://github.com/oghenekparobor/weather-app.git ```
- Change to the flutter project ```cd weather-app ```
- Install the flutter plugins ```flutter pub get```
- Install the flutter plugins ```echo "baseUrl=https://api.openweathermap.org" > .env```
- Replace ```******apikey******``` with your apikey before run the next command
- Install the flutter plugins ```echo "apiKey=******apikey******" > .env```
- Get all generated classes ```dart run build_runner build --delete-conflicting-outputs```
- Install the flutter plugins ```flutter test```
- We either you physical device connected or an emulator run the project ```flutter run```