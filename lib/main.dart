import 'dart:async';
import 'package:flutter/material.dart';

void main() {
  runApp(const YardyApp());
}

class YardyApp extends StatelessWidget {
  const YardyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Yardy',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xff121212),
      ),
      home: const HomeScreen(),
    );
  }
}

// --- ПЕРВЫЙ ЭКРАН (START) ---
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Yardy', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start, // Все блоки строго сверху
            children: [
              const SizedBox(height: 8),
              // Блок 1: Кофе
              ActionCard(
                title: 'Coffee',
                icon: Icons.local_cafe,
                iconColor: Colors.white,
                onStartPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const CoffeeScreen()));
                },
              ),
              const SizedBox(height: 16),
              // Блок 2: Мангал
              ActionCard(
                title: 'BBQ Grill',
                icon: Icons.outdoor_grill,
                iconColor: Colors.orangeAccent,
                onStartPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const GrillScreen()));
                },
              ),
              const SizedBox(height: 16),
              // Блок 3: Вода
              ActionCard(
                title: 'Water',
                icon: Icons.water_drop,
                iconColor: Colors.blue,
                onStartPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const WaterScreen()));
                },
              ),
              const SizedBox(height: 16),
              // Блок 4: Milkshake
              ActionCard(
                title: 'Milkshake',
                icon: Icons.local_bar,
                iconColor: const Color(0xFFFFC0CB),
                onStartPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const MilkshakeScreen()));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Компонент карточки на главном экране
class ActionCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color iconColor;
  final VoidCallback onStartPressed;

  const ActionCard({
    super.key,
    required this.title,
    required this.icon,
    required this.iconColor,
    required this.onStartPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E1E),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Icon(icon, size: 40, color: iconColor),
          const SizedBox(width: 16),
          Expanded(
            child: Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
          ),
          ElevatedButton(
            onPressed: onStartPressed,
            style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
            child: const Text('Start', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}

// --- ЭКРАН: КОФЕ ---
class CoffeeScreen extends StatefulWidget {
  const CoffeeScreen({super.key});

  @override
  State<CoffeeScreen> createState() => _CoffeeScreenState();
}

class _CoffeeScreenState extends State<CoffeeScreen> {
  bool _isPouring = false;
  final Stopwatch _stopwatch = Stopwatch();
  Timer? _timer;

  void _startTimer() {
    _stopwatch.reset();
    _stopwatch.start();
    setState(() => _isPouring = true);
    _timer = Timer.periodic(const Duration(milliseconds: 30), (timer) {
      setState(() {});
    });
  }

  void _stopAndResetTimer() {
    _stopwatch.stop();
    _stopwatch.reset();
    _timer?.cancel();
    setState(() => _isPouring = false);
  }

  String _formatTime() {
    final milliseconds = _stopwatch.elapsedMilliseconds;
    return '${(milliseconds / 1000).toStringAsFixed(2)} s';
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Coffee'), backgroundColor: Colors.transparent, elevation: 0),
      body: GestureDetector(
        onTapDown: (_) => _startTimer(),
        onTapUp: (_) => _stopAndResetTimer(),
        onTapCancel: () => _stopAndResetTimer(),
        child: Container(
          color: Colors.transparent,
          width: double.infinity,
          height: double.infinity,
          padding: const EdgeInsets.only(top: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(_isPouring ? 'Pouring...' : 'Press and hold to pour', style: const TextStyle(fontSize: 16, color: Colors.grey)),
              const SizedBox(height: 20),
              Text(_formatTime(), style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold, fontFamily: 'monospace', color: Colors.amber)),
              const SizedBox(height: 20),
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                height: _isPouring ? 100 : 0,
                width: 4,
                decoration: BoxDecoration(color: Colors.brown[700], borderRadius: BorderRadius.circular(4)),
              ),
              const Icon(Icons.local_cafe, size: 100, color: Colors.white),
            ],
          ),
        ),
      ),
    );
  }
}

// --- ЭКРАН: МАНГАЛ ---
class GrillScreen extends StatefulWidget {
  const GrillScreen({super.key});

  @override
  State<GrillScreen> createState() => _GrillScreenState();
}

class _GrillScreenState extends State<GrillScreen> {
  bool _isHeating = false;
  final Stopwatch _stopwatch = Stopwatch();
  Timer? _timer;

  void _startTimer() {
    _stopwatch.reset();
    _stopwatch.start();
    setState(() => _isHeating = true);
    _timer = Timer.periodic(const Duration(milliseconds: 30), (timer) {
      setState(() {});
    });
  }

  void _stopAndResetTimer() {
    _stopwatch.stop();
    _stopwatch.reset();
    _timer?.cancel();
    setState(() => _isHeating = false);
  }

  String _formatTime() {
    final milliseconds = _stopwatch.elapsedMilliseconds;
    return '${(milliseconds / 1000).toStringAsFixed(2)} s';
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('BBQ Grill'), backgroundColor: Colors.transparent, elevation: 0),
      body: GestureDetector(
        onTapDown: (_) => _startTimer(),
        onTapUp: (_) => _stopAndResetTimer(),
        onTapCancel: () => _stopAndResetTimer(),
        child: Container(
          color: Colors.transparent,
          width: double.infinity,
          height: double.infinity,
          padding: const EdgeInsets.only(top: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(_isHeating ? 'Fanning the flames! 🔥' : 'Press and hold to heat up coals', style: const TextStyle(fontSize: 16, color: Colors.grey)),
              const SizedBox(height: 20),
              Text(_formatTime(), style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold, fontFamily: 'monospace', color: Colors.deepOrangeAccent)),
              const SizedBox(height: 20),
              AnimatedOpacity(
                duration: const Duration(milliseconds: 300),
                opacity: _isHeating ? 0.6 : 0.0,
                child: const Column(
                  children: [
                    Text('💨', style: TextStyle(fontSize: 24)),
                    Text(' 💨', style: TextStyle(fontSize: 20)),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _isHeating ? Colors.redAccent.withOpacity(0.2) : Colors.transparent,
                  boxShadow: _isHeating ? [BoxShadow(color: Colors.orange.withOpacity(0.5), blurRadius: 40, spreadRadius: 10)] : [],
                ),
                child: Icon(Icons.outdoor_grill, size: 100, color: _isHeating ? Colors.deepOrange : Colors.grey[600]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// --- ЭКРАН: ВОДА ---
class WaterScreen extends StatefulWidget {
  const WaterScreen({super.key});

  @override
  State<WaterScreen> createState() => _WaterScreenState();
}

class _WaterScreenState extends State<WaterScreen> {
  bool _isFlowing = false;
  final Stopwatch _stopwatch = Stopwatch();
  Timer? _timer;

  void _startTimer() {
    _stopwatch.reset();
    _stopwatch.start();
    setState(() => _isFlowing = true);
    _timer = Timer.periodic(const Duration(milliseconds: 30), (timer) {
      setState(() {});
    });
  }

  void _stopAndResetTimer() {
    _stopwatch.stop();
    _stopwatch.reset();
    _timer?.cancel();
    setState(() => _isFlowing = false);
  }

  String _formatTime() {
    final milliseconds = _stopwatch.elapsedMilliseconds;
    return '${(milliseconds / 1000).toStringAsFixed(2)} s';
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Water'), backgroundColor: Colors.transparent, elevation: 0),
      body: GestureDetector(
        onTapDown: (_) => _startTimer(),
        onTapUp: (_) => _stopAndResetTimer(),
        onTapCancel: () => _stopAndResetTimer(),
        child: Container(
          color: Colors.transparent,
          width: double.infinity,
          height: double.infinity,
          padding: const EdgeInsets.only(top: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(_isFlowing ? 'Water is flowing...' : 'Press and hold to open the tap', style: const TextStyle(fontSize: 16, color: Colors.grey)),
              const SizedBox(height: 20),
              Text(_formatTime(), style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold, fontFamily: 'monospace', color: Colors.blueAccent)),
              const SizedBox(height: 20),
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                height: _isFlowing ? 100 : 0,
                width: 6,
                decoration: BoxDecoration(color: Colors.blue[300], borderRadius: BorderRadius.circular(4)),
              ),
              const Icon(Icons.water_drop, size: 100, color: Colors.blue),
            ],
          ),
        ),
      ),
    );
  }
}

// --- ЭКРАН: МОЛОЧНЫЙ КОКТЕЙЛЬ ---
class MilkshakeScreen extends StatefulWidget {
  const MilkshakeScreen({super.key});

  @override
  State<MilkshakeScreen> createState() => _MilkshakeScreenState();
}

class _MilkshakeScreenState extends State<MilkshakeScreen> {
  bool _isMixing = false;
  final Stopwatch _stopwatch = Stopwatch();
  Timer? _timer;

  void _startTimer() {
    _stopwatch.reset();
    _stopwatch.start();
    setState(() => _isMixing = true);
    _timer = Timer.periodic(const Duration(milliseconds: 30), (timer) {
      setState(() {});
    });
  }

  void _stopAndResetTimer() {
    _stopwatch.stop();
    _stopwatch.reset();
    _timer?.cancel();
    setState(() => _isMixing = false);
  }

  String _formatTime() {
    final milliseconds = _stopwatch.elapsedMilliseconds;
    return '${(milliseconds / 1000).toStringAsFixed(2)} s';
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Milkshake'), backgroundColor: Colors.transparent, elevation: 0),
      body: GestureDetector(
        onTapDown: (_) => _startTimer(),
        onTapUp: (_) => _stopAndResetTimer(),
        onTapCancel: () => _stopAndResetTimer(),
        child: Container(
          color: Colors.transparent,
          width: double.infinity,
          height: double.infinity,
          padding: const EdgeInsets.only(top: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(_isMixing ? 'Mixing shake...' : 'Press and hold to mix', style: const TextStyle(fontSize: 16, color: Colors.grey)),
              const SizedBox(height: 20),
              Text(_formatTime(), style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold, fontFamily: 'monospace', color: Color(0xFFFFB6C1))),
              const SizedBox(height: 20),
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                height: _isMixing ? 100 : 0,
                width: 6,
                decoration: BoxDecoration(color: const Color(0xFFFFF0F5), borderRadius: BorderRadius.circular(4)),
              ),
              const Icon(Icons.local_bar, size: 100, color: Color(0xFFFFC0CB)),
            ],
          ),
        ),
      ),
    );
  }
}