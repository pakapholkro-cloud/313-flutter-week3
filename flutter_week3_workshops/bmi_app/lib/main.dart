import 'package:flutter/material.dart';

void main() => runApp(const BmiApp());
class BmiApp extends StatelessWidget {
  const BmiApp({super.key});
  @override Widget build(BuildContext context) => MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'คำนวณ BMI',
    theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.teal),
    home: const BmiScreen(),
  );
}
class BmiScreen extends StatefulWidget {
  const BmiScreen({super.key});
  @override State<BmiScreen> createState() => _BmiScreenState();
}
class _BmiScreenState extends State<BmiScreen> {
  final weight = TextEditingController();
  final height = TextEditingController();
  double? bmi;
  String category = '', advice = '';
  Color resultColor = Colors.grey;

  void calculate() {
    final w = double.tryParse(weight.text.trim());
    final h = double.tryParse(height.text.trim());
    if (w == null || h == null || !w.isFinite || !h.isFinite || w <= 0 || h <= 0) {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(const SnackBar(content: Text('กรุณากรอกตัวเลขน้ำหนักและส่วนสูงให้มากกว่า 0')));
      return;
    }
    final value = w / ((h / 100) * (h / 100));
    if (!value.isFinite) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('ข้อมูลไม่ถูกต้อง')));
      return;
    }
    String text, tip;
    Color color;
    if (value < 18.5) {
      text = 'ผอม (น้ำหนักน้อย)';
      tip = 'เพิ่มอาหารที่มีประโยชน์ ออกกำลังกายสร้างกล้ามเนื้อ';
      color = Colors.lightBlue;
    } else if (value < 23) {
      text = 'ปกติ (สมส่วน)';
      tip = 'รักษาพฤติกรรมการกินและออกกำลังกายเดิมไว้';
      color = Colors.green;
    } else if (value < 25) {
      text = 'ท้วม (โรคอ้วนระดับ 1)';
      tip = 'ควบคุมอาหาร และออกกำลังกายสม่ำเสมอ';
      color = Colors.amber.shade700;
    } else if (value < 30) {
      text = 'อ้วน (โรคอ้วนระดับ 2)';
      tip = 'ลดอาหารหวาน มัน เค็ม ออกกำลังกายทุกวัน';
      color = Colors.deepOrange;
    } else {
      text = 'อ้วนมาก (โรคอ้วนระดับ 3)';
      tip = 'ควรปรึกษาแพทย์ หรือผู้เชี่ยวชาญ';
      color = Colors.red;
    }
    setState(() {
      bmi = value; category = text; advice = tip; resultColor = color;
    });
  }
  void clear() {
    weight.clear(); height.clear();
    setState(() { bmi = null; category = ''; advice = ''; });
  }
  @override void dispose() {
    weight.dispose(); height.dispose(); super.dispose();
  }
  @override Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('คำนวณ BMI')),
    body: Center(child: SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 480),
        child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          const Icon(Icons.monitor_weight_outlined, size: 70, color: Colors.teal),
          const SizedBox(height: 20),
          TextField(
            controller: weight,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            decoration: const InputDecoration(
              labelText: 'น้ำหนัก (กก.)', border: OutlineInputBorder())),
          const SizedBox(height: 14),
          TextField(
            controller: height,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            decoration: const InputDecoration(
              labelText: 'ส่วนสูง (ซม.)', border: OutlineInputBorder())),
          const SizedBox(height: 16),
          Row(children: [
            Expanded(child: FilledButton(
              onPressed: calculate, child: const Text('คำนวณ'))),
            const SizedBox(width: 10),
            Expanded(child: OutlinedButton(
              onPressed: clear, child: const Text('ล้างค่า'))),
          ]),
          if (bmi != null) ...[
            const SizedBox(height: 20),
            Card(
              color: resultColor.withOpacity(0.15),
              child: Padding(
                padding: const EdgeInsets.all(22),
                child: Column(children: [
                  Text('BMI ' + bmi!.toStringAsFixed(2),
                    style: Theme.of(context).textTheme.headlineMedium),
                  const SizedBox(height: 10),
                  Text(category, textAlign: TextAlign.center,
                    style: TextStyle(color: resultColor,
                      fontSize: 20, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 10),
                  Text(advice, textAlign: TextAlign.center),
                ]),
              ),
            ),
          ],
        ]),
      ),
    )),
  );
}
