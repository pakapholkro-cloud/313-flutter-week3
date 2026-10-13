# Flutter Week 3 — ขั้นตอนเปิด Workshop บน Codespaces

โปรเจกต์นี้สำหรับงานสัปดาห์ที่ 3 (BMI, To-do, เกมความจำ 4 สี)

## เปิด Codespace ใหม่
จากหน้า Repository กด **Code → Codespaces → Create codespace on main** แล้วรอหน้า VS Code เปิด

## เพิ่มชุด Workshop
ดาวน์โหลดไฟล์ `Flutter_Week3_3_Workshops.zip` จากแชต ChatGPT แล้วลากไฟล์ใส่ Explorer ที่ root ของ Codespace

จาก Terminal:
```bash
unzip Flutter_Week3_3_Workshops.zip
cd flutter_week3_workshops
bash setup_codespaces.sh
```

## ทดลองรัน BMI
```bash
cd bmi_app
flutter run -d web-server --web-port 8080 --web-hostname 0.0.0.0
```
เปิดหน้า **PORTS** แล้วเลือกพอร์ต 8080

กด `q` เพื่อหยุดก่อนรัน To-do:
```bash
cd ../todo_app
flutter run -d web-server --web-port 8080 --web-hostname 0.0.0.0
```
กด `q` แล้วรันเกม:
```bash
cd ../memory_game
flutter run -d web-server --web-port 8080 --web-hostname 0.0.0.0
```

## บันทึกงานขึ้น GitHub
เปิด Terminal ที่ root ของ repo:
```bash
git add .
git commit -m "Add week3 Flutter workshops"
git push
```

ต้องรันและทดสอบจริงก่อนส่ง เพราะชุดโค้ดเริ่มต้นยังไม่ได้ทดสอบกับ Flutter SDK
