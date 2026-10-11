# Zebvix Payments — Flutter

This is the Flutter/Dart app source. It uses the provided Zebvix splash artwork,
a matching launcher icon, a soft entrance animation, a pulsing emerald glow,
and a repeating diagonal shimmer.

## Run

Use Flutter 3.32 or newer with Dart 3.8 or newer:

```sh
flutter pub get
flutter pub run flutter_launcher_icons
flutter pub run flutter_native_splash:create
flutter run
```

The source and assets are ready, but native `android/` and `ios/` runner folders
are not included. On a machine with the Flutter SDK, generate those platform
folders once without replacing the existing app source:

```sh
flutter create --platforms android,ios --project-name zebvix_payments --org com.zebvix platform_shell
cp -R platform_shell/android platform_shell/ios .
rm -rf platform_shell
flutter pub get
flutter pub run flutter_launcher_icons
flutter pub run flutter_native_splash:create
```

Replit's built-in mobile preview supports Expo rather than Flutter, so the
Flutter source is delivered here instead of through the Expo preview.
