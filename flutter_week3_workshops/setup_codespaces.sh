#!/usr/bin/env bash
set -euo pipefail

# เตรียมโปรเจกต์ทั้ง 3 แอปจากตำแหน่งไฟล์สคริปต์
cd "$(dirname "$0")"

# Codespaces default image ไม่มี Flutter: ติดตั้ง SDK official stable ใน HOME
if ! command -v flutter >/dev/null 2>&1; then
  sdk_dir="$HOME/flutter"
  if [ ! -x "$sdk_dir/bin/flutter" ]; then
    echo "Installing Flutter stable SDK from official GitHub repository..."
    git clone --depth 1 --branch stable https://github.com/flutter/flutter.git "$sdk_dir"
  fi
  export PATH="$sdk_dir/bin:$PATH"
  # ให้ terminal ใหม่หา flutter เจอ
  bashrc_line='export PATH="$HOME/flutter/bin:$PATH"'
  if ! grep -Fqx "$bashrc_line" "$HOME/.bashrc" 2>/dev/null; then
    printf '\n%s\n' "$bashrc_line" >> "$HOME/.bashrc"
  fi
fi

flutter --version
flutter config --enable-web

# สร้าง Android/Web scaffolding แบบไม่ทับโค้ดที่เตรียมไว้
temp_dir="$(mktemp -d)"
trap 'rm -rf "$temp_dir"' EXIT
for app in bmi_app todo_app memory_game; do
  echo "Preparing $app ..."
  flutter create --platforms=android,web --project-name "$app" "$temp_dir/$app"
  for item in android web .gitignore .metadata analysis_options.yaml; do
    if [ ! -e "$app/$item" ]; then
      cp -R "$temp_dir/$app/$item" "$app/$item"
    fi
  done
  (cd "$app" && flutter pub get)
done
echo "Ready! Run: cd bmi_app && flutter run -d web-server --web-port 8080 --web-hostname 0.0.0.0"
