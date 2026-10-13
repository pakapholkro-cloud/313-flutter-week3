# Flutter Week 3 — Workshop ทั้ง 3 งาน

โค้ด Flutter สำหรับ Workshop ตามเอกสาร Week 3 หน้า 48–51

- bmi_app — คำนวณ BMI, แปลผลและแนะนำตามเกณฑ์ 5 ระดับ
- todo_app — จัดการงาน 3 หน้าจอ บันทึกด้วย shared_preferences
- memory_game — จำลำดับไฟ 4 สี

แต่ละแอปมี prompts.md แสดงแนวทาง AI Prompt และรายการทดสอบ
งาน Bonus ยังไม่รวม

## เริ่มใช้บน GitHub Codespaces

เปิด Codespaces จาก Repository นี้ แล้วเปิด Terminal:

    cd flutter_week3_workshops
    bash setup_codespaces.sh
    cd bmi_app
    flutter run -d web-server --web-port 8080 --web-hostname 0.0.0.0

เปิดแท็บ PORTS พอร์ต 8080 แล้วเปิดเว็บแอป
กด q เพื่อหยุด จากนั้นสลับไปแอปอื่น:

    cd ../todo_app
    flutter run -d web-server --web-port 8080 --web-hostname 0.0.0.0

หรือ

    cd ../memory_game
    flutter run -d web-server --web-port 8080 --web-hostname 0.0.0.0

โปรดทดสอบใน Codespaces ก่อนส่ง เนื่องจากยังไม่ได้คอมไพล์ด้วย Flutter SDK
