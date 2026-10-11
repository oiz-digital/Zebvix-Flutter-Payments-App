# Flutter app architecture

The Dart app uses a feature-first structure so each product area can grow
without turning the app entry point or a single screen file into a catch-all.

```text
lib/
├── main.dart
├── app/
│   └── zebvix_app.dart
├── core/
│   ├── constants/
│   │   └── app_assets.dart
│   ├── platform/
│   │   └── system_ui_config.dart
│   └── theme/
│       ├── app_colors.dart
│       └── app_theme.dart
└── features/
    └── splash/
        └── presentation/
            ├── screens/
            │   └── splash_screen.dart
            ├── widgets/
            │   ├── sparkle_overlay.dart
            │   ├── splash_artwork.dart
            │   ├── splash_light_effects.dart
            │   └── splash_progress_indicator.dart
            ├── painters/
            │   └── sparkle_painter.dart
            └── splash_animation_durations.dart

test/
└── features/
    └── splash/
        └── presentation/
            └── splash_screen_test.dart
```

## Responsibilities and boundaries

- `main.dart` performs startup only; app composition lives in `app/`.
- `core/` contains genuinely shared tokens and platform configuration. Feature
  code may depend on core; core must not depend on a feature.
- Each product area lives under `features/<feature>/`. UI and animation details
  stay inside that feature rather than leaking into global utilities.
- Tests mirror the feature structure under `test/`.
- Add domain, data, networking, routing, or dependency-injection layers when a
  real flow needs them. Avoid empty folders and abstractions with no caller.

Run checks from `flutter_app/`:

```sh
flutter analyze
flutter test
```
