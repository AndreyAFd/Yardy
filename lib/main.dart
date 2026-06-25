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
        scaffoldBackgroundColor: const Color.fromARGB(255, 0, 0, 0),
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            const Text('Yardy', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            ActionCard(
              title: 'Coffee',
              icon: Icons.local_cafe,
              iconColor: Colors.white,
              onStartPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const CoffeeScreen()));
              },
            ),
            const SizedBox(height: 16),
            ActionCard(
              title: 'BBQ Grill',
              icon: Icons.outdoor_grill,
              iconColor: Colors.orangeAccent,
              onStartPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const GrillScreen()));
              },
            ),
            const SizedBox(height: 16),
            ActionCard(
              title: 'Water',
              icon: Icons.water_drop,
              iconColor: const Color.fromARGB(255, 34, 62, 246),
              onStartPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const WaterScreen()));
              },
            ),
          ],
        ),
      ),
    );
  }
}

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
            child: Text(title,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
          ),
          ElevatedButton(
            onPressed: onStartPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 18, 198, 24),
            ),
            child: const Text('Start',
                style: TextStyle(color: Color.fromARGB(255, 255, 255, 255))),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('Brewing Coffee'),
          backgroundColor: Colors.transparent,
          elevation: 0),
      body: GestureDetector(
        onTapDown: (_) => setState(() => _isPouring = true),
        onTapUp: (_) => setState(() => _isPouring = false),
        onTapCancel: () => setState(() => _isPouring = false),
        child: Container(
          color: Colors.transparent,
          width: double.infinity,
          height: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(_isPouring ? 'Pouring...' : 'Press and hold to pour',
                  style: const TextStyle(fontSize: 16, color: Colors.grey)),
              const SizedBox(height: 40),
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                height: _isPouring ? 100 : 0,
                width: 4,
                decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 48, 33, 28),
                    borderRadius: BorderRadius.circular(4)),
              ),
              const Icon(Icons.local_cafe,
                  size: 100, color: Color.fromARGB(255, 255, 255, 255)),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('BBQ Grill'),
          backgroundColor: Colors.transparent,
          elevation: 0),
      body: GestureDetector(
        onTapDown: (_) => setState(() => _isHeating = true),
        onTapUp: (_) => setState(() => _isHeating = false),
        onTapCancel: () => setState(() => _isHeating = false),
        child: Container(
          color: Colors.transparent,
          width: double.infinity,
          height: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                  _isHeating
                      ? 'Fanning the flames!'
                      : 'Press and hold to heat up coals',
                  style: const TextStyle(fontSize: 16, color: Colors.grey)),
              const SizedBox(height: 20),
              const SizedBox(height: 10),
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
                              spreadRadius: 10)
                        ]
                      : [],
                ),
                child: Icon(Icons.outdoor_grill,
                    size: 100,
                    color: _isHeating ? Colors.deepOrange : Colors.grey[600]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// --- ВТОРОЙ ЭКРАН: ВОДА ---
class WaterScreen extends StatefulWidget {
  const WaterScreen({super.key});

  @override
  State<WaterScreen> createState() => _WaterScreenState();
}

class _WaterScreenState extends State<WaterScreen> {
  bool _isFlowing = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('Water'),
          backgroundColor: Colors.transparent,
          elevation: 0),
      body: GestureDetector(
        onTapDown: (_) => setState(() => _isFlowing = true),
        onTapUp: (_) => setState(() => _isFlowing = false),
        onTapCancel: () => setState(() => _isFlowing = false),
        child: Container(
          color: Colors.transparent,
          width: double.infinity,
          height: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                  _isFlowing
                      ? 'Water is flowing...'
                      : 'Press and hold to open the tap',
                  style: const TextStyle(fontSize: 16, color: Colors.grey)),
              const SizedBox(height: 40),
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                height: _isFlowing ? 100 : 0,
                width: 6,
                decoration: BoxDecoration(
                    color: Colors.blue[300],
                    borderRadius: BorderRadius.circular(4)),
              ),
              const Icon(Icons.water_drop, size: 100, color: Color.from(alpha: 1, red: 0.129, green: 0.588, blue: 0.953)),
            ],
          ),
        ),
      ),
    );
  }
}
