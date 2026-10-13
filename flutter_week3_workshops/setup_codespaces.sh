#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")"
if ! command -v flutter >/dev/null; then
  echo "ERROR: ไม่พบ Flutter SDK ใน Codespaces" >&2
  exit 1
fi
temp_dir="$(mktemp -d)"
trap 'rm -rf "$temp_dir"' EXIT
for app in bmi_app todo_app memory_game; do
  echo "Preparing $app"
  flutter create --platforms=android,web --project-name "$app" "$temp_dir/$app"
  for item in android web .gitignore .metadata analysis_options.yaml; do
    if [ ! -e "$app/$item" ]; then cp -R "$temp_dir/$app/$item" "$app/$item"; fi
  done
  (cd "$app" && flutter pub get)
done
echo "เสร็จแล้ว: cd bmi_app และ flutter run -d web-server --web-port 8080 --web-hostname 0.0.0.0"
