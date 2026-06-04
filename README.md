# SignShare LSM

SignShare LSM is a Flutter Android starter app for a community-powered sign language dictionary.

The first version includes a polished home screen and navigation to four project areas:

- Search a Word
- Upload a Sign
- Recognize a Sign
- About the Project

This starter does **not** include Firebase or AI recognition yet. Those belong in later phases after the home screen and navigation are approved.

## Important: No Local Flutter Required

You can use this repository without installing Flutter on your Windows 11 PC.

GitHub Actions will build the Android APK in the cloud.

## Browser-Only GitHub Setup

1. Download and unzip this starter project.
2. Go to GitHub.
3. Create a new repository named `signshare-lsm`.
4. Use these repository settings:
   - Public or Private: either is fine
   - Add README: No
   - Add .gitignore: No
   - Add license: No
5. Open the empty repository.
6. Click **Add file**.
7. Click **Upload files**.
8. Drag the **contents inside** the unzipped `signshare_lsm_starter` folder into GitHub.
9. Make sure `.github/workflows/android-build.yml` is included.
10. Click **Commit changes**.

## Build the APK with GitHub Actions

After the files are committed:

1. Open the repository on GitHub.
2. Click the **Actions** tab.
3. Click **Android Build**.
4. Wait for the build to finish.
5. Open the completed workflow run.
6. Scroll down to **Artifacts**.
7. Download `signshare-lsm-debug-apk`.
8. Unzip the artifact.
9. Install `app-debug.apk` on an Android phone.

## What the GitHub Action Does

The workflow file is located at:

```text
.github/workflows/android-build.yml
```

It runs:

```bash
flutter pub get
flutter analyze
flutter test
flutter create --platforms=android --org com.signshare --project-name signshare_lsm .
flutter build apk --debug
```

The Android project files are generated inside GitHub Actions, so your PC does not need Flutter, Android Studio, Java, Gradle, or the Android SDK.

## Local Setup Later

After the GitHub Actions build works, you can install Flutter locally later.

Then run:

```bash
flutter pub get
flutter create --platforms=android --org com.signshare --project-name signshare_lsm .
flutter run
```

## Project Structure

```text
lib/
  main.dart
  core/
    constants/app_strings.dart
    routes/app_routes.dart
    theme/app_theme.dart
  features/
    home/home_screen.dart
    home/home_card.dart
    search/search_screen.dart
    upload/upload_screen.dart
    recognition/recognition_screen.dart
    about/about_screen.dart
  models/sign_video.dart
```

## Phase 2 Recommended Tasks

1. Replace the Search placeholder with real local demo data.
2. Add sample words such as `hola`, `gracias`, `agua`, and `ayuda`.
3. Add video result cards.
4. Add Firebase after the local demo works.
5. Add AI recognition only after upload and search are stable.
