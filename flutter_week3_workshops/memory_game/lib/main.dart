import 'dart:math';
import 'package:flutter/material.dart';

void main() => runApp(const MemoryApp());

class MemoryApp extends StatelessWidget {
  const MemoryApp({super.key});
  @override Widget build(BuildContext context) => MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.deepPurple),
    home: const MemoryScreen(),
  );
}

class MemoryScreen extends StatefulWidget {
  const MemoryScreen({super.key});
  @override State<MemoryScreen> createState() => _MemoryScreenState();
}

class _MemoryScreenState extends State<MemoryScreen> {
  final rng = Random();
  final sequence = <int>[];
  final colors = const [Colors.red, Colors.green, Colors.amber, Colors.blue];
  int round = 0;
  int nextTap = 0;
  int highlighted = -1;
  int generation = 0;
  bool showing = false;
  bool accepting = false;

  void start() {
    if (showing) return; // กันกดระหว่างไฟกำลังแสดง
    ++generation;
    setState(() {
      sequence.clear();
      round = 0;
      nextTap = 0;
      highlighted = -1;
      accepting = false;
    });
    nextRound(generation);
  }

  Future<void> nextRound(int token) async {
    sequence.add(rng.nextInt(4)); // ต่อท้ายลำดับเดิมเพียง 1 สี
    setState(() { showing = true; accepting = false; nextTap = 0; });
    await Future.delayed(const Duration(milliseconds: 350));
    for (final color in sequence) {
      if (!mounted || token != generation) return;
      setState(() => highlighted = color);
      await Future.delayed(const Duration(milliseconds: 600));
      if (!mounted || token != generation) return;
      setState(() => highlighted = -1);
      await Future.delayed(const Duration(milliseconds: 250));
    }
    if (!mounted || token != generation) return;
    setState(() { showing = false; accepting = true; });
  }

  Future<void> pressColor(int index) async {
    if (!accepting || showing) return;
    if (sequence[nextTap] != index) {
      final completed = round;
      ++generation;
      setState(() {
        accepting = false;
        showing = false;
        sequence.clear();
        nextTap = 0;
        highlighted = -1;
        round = 0;
      });
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(SnackBar(
          duration: const Duration(milliseconds: 1500),
          content: Text('ผิด! ได้ ' + completed.toString() + ' รอบ')));
      return;
    }
    ++nextTap;
    if (nextTap == sequence.length) {
      final token = generation;
      setState(() { accepting = false; ++round; });
      await Future.delayed(const Duration(milliseconds: 500));
      if (!mounted || token != generation) return;
      await nextRound(token);
    } else {
      setState(() {});
    }
  }

  @override void dispose() { ++generation; super.dispose(); }

  @override Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('เกมความจำ 4 สี')),
    body: Center(child: SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 480),
        child: Column(children: [
          Text('รอบ: ' + round.toString(),
            style: Theme.of(context).textTheme.headlineMedium),
          const SizedBox(height: 12),
          Text(showing ? 'จำลำดับสีที่สว่าง'
            : accepting ? 'กดสีตามลำดับ' : 'กด Start เพื่อเริ่ม'),
          const SizedBox(height: 20),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, mainAxisSpacing: 12, crossAxisSpacing: 12),
            itemCount: 4,
            itemBuilder: (context, index) => GestureDetector(
              onTap: accepting && !showing ? () => pressColor(index) : null,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 130),
                decoration: BoxDecoration(
                  color: highlighted == index
                    ? Color.lerp(colors[index], Colors.white, 0.47)
                    : colors[index],
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: highlighted == index
                    ? [BoxShadow(color: colors[index], blurRadius: 28,
                        spreadRadius: 4)] : [],
                ),
                child: Center(child: Text(
                  ['แดง', 'เขียว', 'เหลือง', 'น้ำเงิน'][index],
                  style: const TextStyle(fontSize: 19, color: Colors.white,
                    fontWeight: FontWeight.bold,
                    shadows: [Shadow(color: Colors.black54, blurRadius: 5)]),
                )),
              ),
            ),
          ),
          const SizedBox(height: 18),
          SizedBox(width: double.infinity,
            child: FilledButton.icon(
              onPressed: showing ? null : start,
              icon: const Icon(Icons.play_arrow),
              label: const Text('Start / เริ่มใหม่'),
            ),
          ),
        ]),
      ),
    )),
  );
}
