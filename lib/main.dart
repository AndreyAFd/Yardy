import 'dart:async';
import 'package:flutter/material.dart';

final ValueNotifier<ThemeMode> themeNotifier = ValueNotifier(ThemeMode.dark);

void main() {
  runApp(const YardyApp());
}

class YardyApp extends StatelessWidget {
  const YardyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: themeNotifier,
      builder: (_, ThemeMode currentMode, __) {
        return MaterialApp(
          title: 'Yardy',
          debugShowCheckedModeBanner: false,
          themeMode: currentMode,
          theme: ThemeData(
            useMaterial3: true,
            brightness: Brightness.light,
            scaffoldBackgroundColor: const Color(0xFFF5F5F5),
            appBarTheme: const AppBarTheme(
              backgroundColor: Colors.transparent,
              elevation: 0,
              iconTheme: IconThemeData(color: Colors.black),
              titleTextStyle: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          darkTheme: ThemeData(
            useMaterial3: true,
            brightness: Brightness.dark,
            scaffoldBackgroundColor: const Color(0xFF121212),
            appBarTheme: const AppBarTheme(
              backgroundColor: Colors.transparent,
              elevation: 0,
              iconTheme: IconThemeData(color: Colors.white),
              titleTextStyle: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          home: const HomeScreen(),
        );
      },
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void _showThemeDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Select Theme'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: const Text('Dark Mode'),
                leading: const Icon(Icons.dark_mode),
                onTap: () {
                  themeNotifier.value = ThemeMode.dark;
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text('Light Mode'),
                leading: const Icon(Icons.light_mode),
                onTap: () {
                  themeNotifier.value = ThemeMode.light;
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Yardy'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () => _showThemeDialog(context),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 8),
              ActionCard(
                title: 'Coffee',
                icon: Icons.local_cafe,
                iconColorDark: const Color(0xFFFFFFFF),
                iconColorLight: const Color(0xFF8D6E63),
                onStartPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const CoffeeScreen()),
                  );
                },
              ),
              const SizedBox(height: 16),
              ActionCard(
                title: 'BBQ Grill',
                icon: Icons.outdoor_grill,
                iconColorDark: const Color(0xFFFFB74D),
                iconColorLight: const Color(0xFFE65100),
                onStartPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const GrillScreen()),
                  );
                },
              ),
              const SizedBox(height: 16),
              ActionCard(
                title: 'Water',
                icon: Icons.water_drop,
                iconColorDark: const Color(0xFF4FC3F7),
                iconColorLight: const Color(0xFF0288D1),
                onStartPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const WaterScreen()),
                  );
                },
              ),
              const SizedBox(height: 16),
              ActionCard(
                title: 'Milkshake',
                icon: Icons.local_bar,
                iconColorDark: const Color(0xFFFFC0CB),
                iconColorLight: const Color(0xFFC2185B),
                onStartPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const MilkshakeScreen()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ActionCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color iconColorDark;
  final Color iconColorLight;
  final VoidCallback onStartPressed;

  const ActionCard({
    super.key,
    required this.title,
    required this.icon,
    required this.iconColorDark,
    required this.iconColorLight,
    required this.onStartPressed,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: isDark
            ? []
            : [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                )
              ],
      ),
      child: Row(
        children: [
          Icon(
            icon,
            size: 40,
            color: isDark ? iconColorDark : iconColorLight,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: isDark ? Colors.white : Colors.black,
              ),
            ),
          ),
          ElevatedButton(
            onPressed: onStartPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF12D639),
              foregroundColor: Colors.black,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
            ),
            child: const Text('Start'),
          ),
        ],
      ),
    );
  }
}

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
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(title: const Text('Coffee')),
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
              Text(
                _isPouring ? 'Pouring...' : 'Press and hold to pour',
                style: const TextStyle(fontSize: 16, color: Colors.grey),
              ),
              const SizedBox(height: 20),
              Text(
                _formatTime(),
                style: const TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'monospace',
                  color: Colors.amber,
                ),
              ),
              const SizedBox(height: 20),
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                height: _isPouring ? 100 : 0,
                width: 4,
                decoration: BoxDecoration(
                  color: Colors.brown[700],
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              Icon(
                Icons.local_cafe,
                size: 100,
                color: isDark ? Colors.white : Colors.brown[400],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

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
      appBar: AppBar(title: const Text('BBQ Grill')),
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
              Text(
                _isHeating
                    ? 'Fanning the flames!'
                    : 'Press and hold to heat up coals',
                style: const TextStyle(fontSize: 16, color: Colors.grey),
              ),
              const SizedBox(height: 20),
              Text(
                _formatTime(),
                style: const TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'monospace',
                  color: Colors.deepOrangeAccent,
                ),
              ),
              const SizedBox(height: 20),
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _isHeating
                      ? Colors.redAccent.withOpacity(0.2)
                      : Colors.transparent,
                  boxShadow: _isHeating
                      ? [
                          BoxShadow(
                            color: Colors.orange.withOpacity(0.5),
                            blurRadius: 40,
                            spreadRadius: 10,
                          )
                        ]
                      : [],
                ),
                child: Icon(
                  Icons.outdoor_grill,
                  size: 100,
                  color: _isHeating ? Colors.deepOrange : Colors.grey[600],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

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
      appBar: AppBar(title: const Text('Water')),
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
              Text(
                _isFlowing
                    ? 'Water is flowing...'
                    : 'Press and hold to open the tap',
                style: const TextStyle(fontSize: 16, color: Colors.grey),
              ),
              const SizedBox(height: 20),
              Text(
                _formatTime(),
                style: const TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'monospace',
                  color: Colors.blueAccent,
                ),
              ),
              const SizedBox(height: 20),
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                height: _isFlowing ? 100 : 0,
                width: 6,
                decoration: BoxDecoration(
                  color: Colors.blue[300],
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              const Icon(Icons.water_drop, size: 100, color: Colors.blue),
            ],
          ),
        ),
      ),
    );
  }
}

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
      appBar: AppBar(title: const Text('Milkshake')),
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
              Text(
                _isMixing ? 'Mixing shake...' : 'Press and hold to mix',
                style: const TextStyle(fontSize: 16, color: Colors.grey),
              ),
              const SizedBox(height: 20),
              Text(
                _formatTime(),
                style: const TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'monospace',
                  color: Color(0xFFFFB6C1),
                ),
              ),
              const SizedBox(height: 20),
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                height: _isMixing ? 100 : 0,
                width: 6,
                decoration: BoxDecoration(
                  color: const Color(0xFFFFF0F5),
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              const Icon(Icons.local_bar, size: 100, color: Color(0xFFFFC0CB)),
            ],
          ),
        ),
      ),
    );
  }
}
