import 'package:flutter/material.dart';
import 'action_card.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: const MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _coins = 0;

  void _addCoins(int amount) {
    setState(() {
      _coins += amount;
    });
  }

  void _resetCoins() {
    setState(() {
      _coins = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFF1E1E1E),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: const Color(0xFF2E2E2E)),
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.monetization_on,
                          color: Colors.amber,
                          size: 24,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          '$_coins Coins',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),

                  TextButton.icon(
                    onPressed: _resetCoins,
                    icon: const Icon(
                      Icons.refresh_rounded,
                      color: Colors.redAccent,
                    ),
                    label: const Text(
                      'Clear',
                      style: TextStyle(
                        color: Colors.redAccent,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    style: TextButton.styleFrom(
                      backgroundColor: const Color(0xFF2C1A1A),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 10,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Expanded(
              child: ListView(
                children: [
                  // Карточка 1: Кофе
                  ActionCard(
                    title: 'Coffee Station',
                    reward: 'Earn 10 coins',
                    icon: Icons.coffee,
                    iconColor: Colors.orangeAccent,
                    onStartPressed: () => _addCoins(10),
                  ),

                  ActionCard(
                    title: 'BBQ Grill',
                    reward: 'Earn 25 coins',
                    icon: Icons.outdoor_grill_rounded, // Новый красивый гриль
                    iconColor: Colors.redAccent,
                    onStartPressed: () => _addCoins(25), // Прибавляем 25
                  ),

                  ActionCard(
                    title: 'Backyard Garden',
                    reward: 'Earn 15 coins',
                    icon: Icons.water_drop_rounded,
                    iconColor: Colors.blueAccent,
                    onStartPressed: () => _addCoins(15),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
