#!/usr/bin/env bash
set -euo pipefail

flutter pub get
flutter analyze
flutter test
flutter create --platforms=android --org com.signshare --project-name signshare_lsm .
flutter pub get
flutter build apk --debug
