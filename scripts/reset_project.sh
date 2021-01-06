echo --- Resetting project ---
echo --- Cleaning Flutter ---
flutter clean
echo --- Getting Flutter packages ---
flutter pub get
echo --- Generating Floor dependency ---
flutter packages pub run build_runner build --delete-conflicting-outputs