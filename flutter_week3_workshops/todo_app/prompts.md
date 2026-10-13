# Workshop 2 — To-do List (Step-by-step)

## Prompt 1
คุณคือผู้สอน Flutter สำหรับมือใหม่ ขอเฉพาะโครงแอป 3 หน้า
เก็บ 1 งาน (id ชื่องาน ความสำคัญ สถานะ) ให้เป็น JSON
สร้าง models/task.dart, data/task_store.dart เก็บข้อมูลด้วย shared_preferences,
screens/home_screen.dart, add_task_screen.dart, manage_screen.dart และ main.dart
ให้เชื่อมการนำทางก่อน ขอ code เต็มทีละไฟล์พร้อม path

## Prompt 2
ปรับหน้าเพิ่มงานให้กรอกชื่องานห้ามว่าง, Dropdown สูง/กลาง/ต่ำ
กดบันทึกแล้วกลับหน้าแรก พร้อมแจ้งเตือน

## Prompt 3
ปรับหน้าแรกเป็น DataTable ลำดับ/ชื่องาน/ความสำคัญ/สถานะ
เรียงสูงไปต่ำ, ขนาดจอเล็กต้องเลื่อนแนวนอนได้, โหลดใหม่หลังกลับจากหน้าอื่น

## Prompt 4
หน้าจัดการแสดงงานเรียงตามความสำคัญ สลับสถานะเสร็จ/ไม่เสร็จ
ขีดฆ่างานที่เสร็จ และยืนยันก่อนลบ ทุกครั้งต้องบันทึกทันที

บริบท: Flutter stable, Dart null safety, Material 3,
Codespaces Web Server, Android ได้, ใช้ package เฉพาะที่ระบุ,
โค้ดเต็มทุกไฟล์

ทดสอบ: เพิ่ม 3 งานระดับต่างกัน; เปลี่ยนสถานะ; ยืนยันลบ; กด F5 แล้วข้อมูลยังอยู่
