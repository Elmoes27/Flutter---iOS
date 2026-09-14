import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // 0 = Home, 1 = Product, 2 = Menu
  int _selectedIndex = 0;

  // Ini daftar "halaman" yang akan ditampilkan bergantian
  final List<Widget> _pages = const [
    HomeContent(),
    ProductContent(),
    MenuContent(),
  ];

  void _onMenuTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('Go Service', style: TextStyle(color: Colors.white)),
        actions: [
          _buildMenuButton('Home', 0),
          _buildMenuButton('Product', 1),
          _buildMenuButton('Menu', 2),
          const SizedBox(width: 8),
        ],
      ),
      body: _pages[_selectedIndex],
    );
  }

  Widget _buildMenuButton(String title, int index) {
    final bool isSelected = _selectedIndex == index;
    return TextButton(
      onPressed: () => _onMenuTap(index),
      child: Text(
        title,
        style: TextStyle(
          color: isSelected ? Colors.amber : Colors.white,
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
        ),
      ),
    );
  }
}

// ------- Konten Home -------
class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network(
              'https://images.unsplash.com/photo-1558981806-ec527fa84c39?w=600',
              height: 220,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 20),
            const Text(
              'Touring Bike',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Motor Touring dengan desain yang nyaman, bermesin 1000cc bertenaga, '
                'cocok untuk perjalanan harian maupun perawatan servis rutin di Go Service.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14, color: Colors.black87),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ------- Konten Product -------
class ProductContent extends StatelessWidget {
  const ProductContent({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Ini halaman Product',
        style: TextStyle(fontSize: 20),
      ),
    );
  }
}

// ------- Konten Menu -------
class MenuContent extends StatelessWidget {
  const MenuContent({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Ini halaman Menu',
        style: TextStyle(fontSize: 20),
      ),
    );
  }
}