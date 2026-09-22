import 'dart:math' as math;
import 'package:flutter/material.dart';

void main() {
  runApp(const MyWalletApp());
}

// ================= COLOR PALETTE =================
class AppColors {
  static const Color background = Color(0xFF171622);
  static const Color cardBg = Color(0xFF242132);
  static const Color cardBgLight = Color(0xFF322C46);
  static const Color primaryPurple = Color(0xFF7B61FF);
  static const Color accentNeon = Color(0xFFB57BFB);
  static const Color accentOrange = Color(0xFFFFAE73);
  static const Color textWhite = Color(0xFFFFFFFF);
  static const Color textMuted = Color(0xFF8B87A0);
  static const Color success = Color(0xFF66BB6A);
  static const Color danger = Color(0xFFEF5350);
}

class MyWalletApp extends StatelessWidget {
  const MyWalletApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Wallet App',
      theme: ThemeData(
        scaffoldBackgroundColor: AppColors.background,
        fontFamily: 'sans-serif',
        brightness: Brightness.dark,
        useMaterial3: true,
      ),
      home: const MainNavigation(),
    );
  }
}

// ================= MODEL DATA GOAL =================
class GoalData {
  final String title;
  final IconData icon;
  final int current;
  final int target;

  GoalData({
    required this.title,
    required this.icon,
    required this.current,
    required this.target,
  });
}

// ================= BOTTOM NAVIGATION =================
class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _selectedIndex = 0;

  void _onTabSelected(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      HomePage(onNavigateToAnalytics: () => _onTabSelected(1)),
      AnalyticsPage(onBackToHome: () => _onTabSelected(0)),
      const SettingsPage(),
    ];

    return Scaffold(
      body: pages[_selectedIndex],
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          color: AppColors.background,
          border: Border(
            top: BorderSide(color: Color(0xFF262237), width: 1),
          ),
        ),
        child: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: _onTabSelected,
          backgroundColor: AppColors.background,
          selectedItemColor: AppColors.primaryPurple,
          unselectedItemColor: AppColors.textMuted,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          elevation: 0,
          type: BottomNavigationBarType.fixed,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_filled, size: 26),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.pie_chart_rounded, size: 26),
              label: 'Analytics',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings_rounded, size: 26),
              label: 'Settings',
            ),
          ],
        ),
      ),
    );
  }
}

// ================= HOME PAGE (DENGAN TAMBAH GOAL) =================
class HomePage extends StatefulWidget {
  final VoidCallback onNavigateToAnalytics;

  const HomePage({super.key, required this.onNavigateToAnalytics});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // List goals dinamis
  final List<GoalData> _goals = [
    GoalData(
      title: 'Beli Kamera',
      icon: Icons.camera_alt_rounded,
      current: 8500000,
      target: 20000000,
    ),
    GoalData(
      title: 'Beli Mobil',
      icon: Icons.directions_car_rounded,
      current: 45000000,
      target: 150000000,
    ),
  ];

  // Modal Sheet Tambah Goal
  void _showAddGoalDialog() {
    final titleController = TextEditingController();
    final targetController = TextEditingController();
    final currentController = TextEditingController();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.cardBg,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) => Padding(
        padding: EdgeInsets.only(
          left: 24,
          right: 24,
          top: 24,
          bottom: MediaQuery.of(ctx).viewInsets.bottom + 24,
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: AppColors.cardBgLight,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Tambah Goal Baru',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textWhite,
                ),
              ),
              const SizedBox(height: 18),
              
              // Input Nama Goal
              const Text('Nama Goal', style: TextStyle(color: AppColors.textMuted, fontSize: 13)),
              const SizedBox(height: 6),
              TextField(
                controller: titleController,
                style: const TextStyle(color: AppColors.textWhite),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: AppColors.background,
                  hintText: 'Misal: Beli Laptop Baru',
                  hintStyle: const TextStyle(color: Colors.white24, fontSize: 14),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: BorderSide.none),
                ),
              ),
              const SizedBox(height: 14),

              // Input Target Uang
              const Text('Target Uang (Rp)', style: TextStyle(color: AppColors.textMuted, fontSize: 13)),
              const SizedBox(height: 6),
              TextField(
                controller: targetController,
                keyboardType: TextInputType.number,
                style: const TextStyle(color: AppColors.textWhite),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: AppColors.background,
                  hintText: 'Misal: 15000000',
                  hintStyle: const TextStyle(color: Colors.white24, fontSize: 14),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: BorderSide.none),
                ),
              ),
              const SizedBox(height: 14),

              // Input Saldo Terkumpul Saat Ini
              const Text('Sudah Terkumpul (Rp)', style: TextStyle(color: AppColors.textMuted, fontSize: 13)),
              const SizedBox(height: 6),
              TextField(
                controller: currentController,
                keyboardType: TextInputType.number,
                style: const TextStyle(color: AppColors.textWhite),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: AppColors.background,
                  hintText: 'Misal: 3000000 (boleh isi 0)',
                  hintStyle: const TextStyle(color: Colors.white24, fontSize: 14),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: BorderSide.none),
                ),
              ),
              const SizedBox(height: 24),

              // Tombol Simpan Goal
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryPurple,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  ),
                  onPressed: () {
                    final title = titleController.text.trim();
                    final target = int.tryParse(targetController.text.trim()) ?? 0;
                    final current = int.tryParse(currentController.text.trim()) ?? 0;

                    if (title.isNotEmpty && target > 0) {
                      setState(() {
                        _goals.add(
                          GoalData(
                            title: title,
                            icon: Icons.flag_rounded,
                            current: current,
                            target: target,
                          ),
                        );
                      });
                      Navigator.pop(ctx);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Goal "$title" berhasil ditambahkan!')),
                      );
                    }
                  },
                  child: const Text(
                    'Simpan Goal',
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header: Hello, Elmo + Avatar
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Hello, Elmo',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textWhite,
                    letterSpacing: -0.5,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(3),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      colors: [AppColors.primaryPurple, AppColors.accentNeon],
                    ),
                  ),
                  child: const CircleAvatar(
                    radius: 20,
                    backgroundColor: Color(0xFF4A3C6B),
                    child: Icon(Icons.person_rounded, color: Colors.white, size: 24),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Stacked Card: Total Saldo Rp 425.000.000
            Stack(
              clipBehavior: Clip.none,
              children: [
                Positioned(
                  top: -8,
                  left: 12,
                  right: 12,
                  child: Container(
                    height: 80,
                    decoration: BoxDecoration(
                      color: const Color(0xFF7257E8).withOpacity(0.5),
                      borderRadius: BorderRadius.circular(24),
                    ),
                  ),
                ),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(28),
                    gradient: const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Color(0xFFB57BFB),
                        Color(0xFF7352EB),
                        Color(0xFF563BC7),
                      ],
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF7352EB).withOpacity(0.35),
                        blurRadius: 25,
                        offset: const Offset(0, 12),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Total Saldo',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const SizedBox(height: 6),
                      const Text(
                        'Rp 425.000.000',
                        style: TextStyle(
                          color: AppColors.textWhite,
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          letterSpacing: -0.5,
                        ),
                      ),
                      const SizedBox(height: 24),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            'Nomor Kartu',
                            style: TextStyle(color: Colors.white60, fontSize: 11),
                          ),
                          SizedBox(height: 4),
                          Text(
                            '•••• •••• •••• 4821',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              letterSpacing: 1.2,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Stat Cards (Spending & Profit)
            Row(
              children: const [
                Expanded(
                  child: StatCard(
                    title: 'Spending',
                    amount: 'Rp 2.450.000',
                    icon: Icons.arrow_downward_rounded,
                    color: AppColors.danger,
                  ),
                ),
                SizedBox(width: 14),
                Expanded(
                  child: StatCard(
                    title: 'Profit',
                    amount: 'Rp 5.800.000',
                    icon: Icons.arrow_upward_rounded,
                    color: AppColors.success,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 28),

            // Goal Section Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Goal Kamu',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textWhite,
                  ),
                ),
                GestureDetector(
                  onTap: widget.onNavigateToAnalytics,
                  child: const Text(
                    'See all',
                    style: TextStyle(
                      fontSize: 13,
                      color: AppColors.textMuted,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Daftar Goals Dinamis
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _goals.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final item = _goals[index];
                return GoalTile(
                  title: item.title,
                  icon: item.icon,
                  current: item.current,
                  target: item.target,
                );
              },
            ),
            const SizedBox(height: 16),

            // Tombol "Tambahkan Goal" di Bawah Sendiri
            InkWell(
              onTap: _showAddGoalDialog,
              borderRadius: BorderRadius.circular(18),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 16),
                decoration: BoxDecoration(
                  color: AppColors.cardBg,
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(
                    color: AppColors.primaryPurple.withOpacity(0.4),
                    style: BorderStyle.solid,
                    width: 1.5,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(Icons.add_circle_outline_rounded, color: AppColors.accentNeon, size: 22),
                    SizedBox(width: 8),
                    Text(
                      'Tambahkan Goal',
                      style: TextStyle(
                        color: AppColors.accentNeon,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}

// ---------- Stat Card ----------
class StatCard extends StatelessWidget {
  final String title;
  final String amount;
  final IconData icon;
  final Color color;

  const StatCard({
    super.key,
    required this.title,
    required this.amount,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.cardBg,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.18),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, color: color, size: 16),
              ),
              const SizedBox(width: 8),
              Text(
                title,
                style: const TextStyle(
                  color: AppColors.textMuted,
                  fontSize: 13,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            amount,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 15,
              color: AppColors.textWhite,
            ),
          ),
        ],
      ),
    );
  }
}

// ---------- Goal Tile ----------
class GoalTile extends StatelessWidget {
  final String title;
  final IconData icon;
  final int current;
  final int target;

  const GoalTile({
    super.key,
    required this.title,
    required this.icon,
    required this.current,
    required this.target,
  });

  String _formatRp(int amount) {
    return 'Rp ${amount.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.')}';
  }

  @override
  Widget build(BuildContext context) {
    final double progress = target > 0 ? (current / target).clamp(0.0, 1.0) : 0.0;
    final int percentage = (progress * 100).toInt();

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.cardBg,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFF332F47),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(icon, color: AppColors.accentNeon, size: 24),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: AppColors.textWhite,
                      ),
                    ),
                    Text(
                      '$percentage%',
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: AppColors.accentNeon,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: LinearProgressIndicator(
                    value: progress,
                    minHeight: 7,
                    backgroundColor: AppColors.cardBgLight,
                    valueColor: const AlwaysStoppedAnimation<Color>(
                      AppColors.primaryPurple,
                    ),
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  '${_formatRp(current)} / ${_formatRp(target)}',
                  style: const TextStyle(
                    fontSize: 11,
                    color: AppColors.textMuted,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ================= ANALYTICS PAGE =================
class AnalyticsPage extends StatefulWidget {
  final VoidCallback onBackToHome;

  const AnalyticsPage({super.key, required this.onBackToHome});

  @override
  State<AnalyticsPage> createState() => _AnalyticsPageState();
}

class _AnalyticsPageState extends State<AnalyticsPage> {
  bool isExpenses = true;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: widget.onBackToHome,
              child: const Icon(Icons.arrow_back, color: AppColors.textWhite),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'September',
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textWhite,
                  ),
                ),
                Text(
                  isExpenses ? '- Rp 2.450.000' : '+ Rp 5.000.000',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: isExpenses ? AppColors.textWhite : AppColors.success,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 28),
            Center(
              child: SizedBox(
                width: 220,
                height: 220,
                child: CustomPaint(
                  painter: isExpenses
                      ? FourSegmentDonutPainter()
                      : SingleSegmentDonutPainter(),
                ),
              ),
            ),
            const SizedBox(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () => setState(() => isExpenses = true),
                  child: Column(
                    children: [
                      Text(
                        'Expenses',
                        style: TextStyle(
                          color: isExpenses
                              ? AppColors.textWhite
                              : AppColors.textMuted,
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        height: 2.5,
                        width: 60,
                        decoration: BoxDecoration(
                          color: isExpenses
                              ? AppColors.accentNeon
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 48),
                GestureDetector(
                  onTap: () => setState(() => isExpenses = false),
                  child: Column(
                    children: [
                      Text(
                        'Income',
                        style: TextStyle(
                          color: !isExpenses
                              ? AppColors.textWhite
                              : AppColors.textMuted,
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        height: 2.5,
                        width: 60,
                        decoration: BoxDecoration(
                          color: !isExpenses
                              ? AppColors.accentNeon
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 28),
            if (isExpenses) ...[
              const TransactionTile(
                title: 'Makanan',
                transactionsCount: '24 transaksi',
                amount: '- Rp 1.050.000',
                color: Color(0xFF6554F4),
                icon: Icons.restaurant_rounded,
              ),
              const SizedBox(height: 16),
              const TransactionTile(
                title: 'Minuman',
                transactionsCount: '16 transaksi',
                amount: '- Rp 350.000',
                color: Color(0xFF38EF7D),
                icon: Icons.local_cafe_rounded,
              ),
              const SizedBox(height: 16),
              const TransactionTile(
                title: 'Entertainment',
                transactionsCount: '8 transaksi',
                amount: '- Rp 450.000',
                color: Color(0xFFD663EC),
                icon: Icons.local_activity_rounded,
              ),
              const SizedBox(height: 16),
              const TransactionTile(
                title: 'Beli Barang',
                transactionsCount: '5 transaksi',
                amount: '- Rp 600.000',
                color: Color(0xFFFF9A57),
                icon: Icons.shopping_bag_rounded,
              ),
            ] else ...[
              const TransactionTile(
                title: 'Freelance',
                transactionsCount: '10 project',
                amount: '+ Rp 5.000.000',
                color: Color(0xFF38EF7D),
                icon: Icons.work_outline_rounded,
              ),
            ],
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

// ---------- Transaction Tile ----------
class TransactionTile extends StatelessWidget {
  final String title;
  final String transactionsCount;
  final String amount;
  final Color color;
  final IconData icon;

  const TransactionTile({
    super.key,
    required this.title,
    required this.transactionsCount,
    required this.amount,
    required this.color,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: Colors.white, size: 20),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: AppColors.textWhite,
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 3),
              Text(
                transactionsCount,
                style: const TextStyle(
                  color: AppColors.textMuted,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
        Text(
          amount,
          style: const TextStyle(
            color: AppColors.textWhite,
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
        ),
      ],
    );
  }
}

// ---------- Painters (Expenses & Income) ----------
class FourSegmentDonutPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    const strokeWidth = 36.0;
    final radius = (size.width - strokeWidth) / 2;
    final rect = Rect.fromCircle(center: center, radius: radius);

    final pMakanan = Paint()
      ..color = const Color(0xFF6554F4)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    final pMinuman = Paint()
      ..color = const Color(0xFF38EF7D)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    final pEntertainment = Paint()
      ..color = const Color(0xFFD663EC)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    final pBeliBarang = Paint()
      ..color = const Color(0xFFFF9A57)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    const gap = 0.08;
    canvas.drawArc(rect, -math.pi * 0.9 + gap, math.pi * 0.85 - gap, false, pMakanan);
    canvas.drawArc(rect, -0.05 * math.pi + gap, math.pi * 0.35 - gap, false, pMinuman);
    canvas.drawArc(rect, 0.30 * math.pi + gap, math.pi * 0.45 - gap, false, pEntertainment);
    canvas.drawArc(rect, 0.75 * math.pi + gap, math.pi * 0.35 - gap, false, pBeliBarang);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class SingleSegmentDonutPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    const strokeWidth = 36.0;
    final radius = (size.width - strokeWidth) / 2;
    final rect = Rect.fromCircle(center: center, radius: radius);

    final pIncome = Paint()
      ..color = const Color(0xFF38EF7D)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    canvas.drawArc(rect, 0, math.pi * 2, false, pIncome);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// ================= SETTINGS PAGE =================
class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext ctx) {
        return AlertDialog(
          backgroundColor: AppColors.cardBg,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: const Text(
            'Keluar Akun',
            style: TextStyle(color: AppColors.textWhite, fontWeight: FontWeight.bold),
          ),
          content: const Text(
            'Apakah anda yakin mau keluar?',
            style: TextStyle(color: AppColors.textMuted, fontSize: 14),
          ),
          actionsAlignment: MainAxisAlignment.spaceBetween,
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text('Cancel', style: TextStyle(color: AppColors.textMuted)),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(ctx);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Simulasi: Berpindah akun...')),
                );
              },
              child: const Text('Switch Account', style: TextStyle(color: AppColors.accentNeon)),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(ctx);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Berhasil keluar.')),
                );
              },
              child: const Text('Logout', style: TextStyle(color: AppColors.danger)),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Settings',
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: AppColors.textWhite,
              ),
            ),
            const SizedBox(height: 20),

            // Profil Elmo
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [AppColors.primaryPurple, Color(0xFF563BC7)],
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  const CircleAvatar(
                    radius: 28,
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.person_rounded,
                      color: AppColors.primaryPurple,
                      size: 30,
                    ),
                  ),
                  const SizedBox(width: 14),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'Elmo',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(height: 2),
                      Text(
                        'hilmiy5b@gmail.com',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Akun
            const Text(
              'Akun',
              style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.textMuted),
            ),
            const SizedBox(height: 8),
            SettingsTile(
              icon: Icons.person_outline,
              title: 'Akun Saya',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AccountDetailPage()),
                );
              },
            ),
            SettingsTile(
              icon: Icons.lock_outline,
              title: 'Keamanan & Password',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SecurityPasswordPage()),
                );
              },
            ),

            const SizedBox(height: 20),
            // Data
            const Text(
              'Data',
              style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.textMuted),
            ),
            const SizedBox(height: 8),
            SettingsTile(
              icon: Icons.storage_outlined,
              title: 'Kelola Data',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ManageDataPage()),
                );
              },
            ),
            SettingsTile(
              icon: Icons.download_outlined,
              title: 'Export Laporan',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ExportReportPage()),
                );
              },
            ),

            const SizedBox(height: 20),
            // Umum
            const Text(
              'Umum',
              style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.textMuted),
            ),
            const SizedBox(height: 8),
            SettingsTile(
              icon: Icons.notifications_outlined,
              title: 'Notifikasi',
              onTap: () {},
            ),
            SettingsTile(
              icon: Icons.info_outline,
              title: 'Tentang Aplikasi',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AboutAppPage()),
                );
              },
            ),
            SettingsTile(
              icon: Icons.logout_rounded,
              title: 'Keluar',
              color: AppColors.danger,
              onTap: () => _showLogoutDialog(context),
            ),
          ],
        ),
      ),
    );
  }
}

// ---------- Settings Tile ----------
class SettingsTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final Color color;
  final VoidCallback onTap;

  const SettingsTile({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
    this.color = AppColors.textWhite,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: AppColors.cardBg,
        borderRadius: BorderRadius.circular(16),
      ),
      child: ListTile(
        onTap: onTap,
        leading: Icon(
          icon,
          color: color == AppColors.danger ? color : AppColors.accentNeon,
        ),
        title: Text(
          title,
          style: TextStyle(color: color, fontSize: 14, fontWeight: FontWeight.w500),
        ),
        trailing: const Icon(
          Icons.chevron_right_rounded,
          color: AppColors.textMuted,
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
    );
  }
}

// ================= HALAMAN DETAIL AKUN SAYA =================
class AccountDetailPage extends StatelessWidget {
  const AccountDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textWhite),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Akun Saya',
          style: TextStyle(color: AppColors.textWhite, fontWeight: FontWeight.bold, fontSize: 18),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: const [
            CircleAvatar(
              radius: 46,
              backgroundColor: Color(0xFF4A3C6B),
              child: Icon(Icons.person_rounded, size: 52, color: Colors.white),
            ),
            SizedBox(height: 32),
            ProfileInfoTile(label: 'Nama Lengkap', value: 'Elmo', icon: Icons.person_outline),
            ProfileInfoTile(label: 'Email', value: 'hilmiy5b@gmail.com', icon: Icons.email_outlined),
            ProfileInfoTile(label: 'Nomor Telepon', value: '-', icon: Icons.phone_outlined),
            ProfileInfoTile(label: 'Tanggal Lahir', value: '20-02-2002', icon: Icons.cake_outlined),
            ProfileInfoTile(label: 'Region', value: 'Indonesia', icon: Icons.public_outlined),
          ],
        ),
      ),
    );
  }
}

class ProfileInfoTile extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;

  const ProfileInfoTile({
    super.key,
    required this.label,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
      decoration: BoxDecoration(
        color: AppColors.cardBg,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Icon(icon, color: AppColors.accentNeon, size: 22),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, style: const TextStyle(color: AppColors.textMuted, fontSize: 12)),
                const SizedBox(height: 4),
                Text(value, style: const TextStyle(color: AppColors.textWhite, fontSize: 14, fontWeight: FontWeight.w600)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ================= HALAMAN KEAMANAN & PASSWORD =================
class SecurityPasswordPage extends StatefulWidget {
  const SecurityPasswordPage({super.key});

  @override
  State<SecurityPasswordPage> createState() => _SecurityPasswordPageState();
}

class _SecurityPasswordPageState extends State<SecurityPasswordPage> {
  final TextEditingController _oldPassController = TextEditingController();
  final TextEditingController _newPassController = TextEditingController();
  final TextEditingController _confirmPassController = TextEditingController();

  Widget _buildPasswordField(String label, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(color: AppColors.textMuted, fontSize: 13)),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          obscureText: true,
          style: const TextStyle(color: AppColors.textWhite),
          decoration: InputDecoration(
            filled: true,
            fillColor: AppColors.cardBg,
            hintText: 'Masukkan password',
            hintStyle: const TextStyle(color: Colors.white24, fontSize: 14),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: BorderSide.none),
          ),
        ),
        const SizedBox(height: 18),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textWhite),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Ganti Password',
          style: TextStyle(color: AppColors.textWhite, fontWeight: FontWeight.bold, fontSize: 18),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            _buildPasswordField('Password Lama', _oldPassController),
            _buildPasswordField('Password Baru', _newPassController),
            _buildPasswordField('Konfirmasi Password Baru', _confirmPassController),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryPurple,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                ),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Password berhasil diperbarui!')),
                  );
                  Navigator.pop(context);
                },
                child: const Text(
                  'Simpan Password',
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Kelola Data
class ManageDataPage extends StatelessWidget {
  const ManageDataPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> records = [
      {'kategori': 'Profit', 'nominal': 'Rp 5.800.000', 'tipe': 'Masuk'},
      {'kategori': 'Spending', 'nominal': 'Rp 2.450.000', 'tipe': 'Keluar'},
      {'kategori': 'Expenses (Makanan)', 'nominal': 'Rp 1.050.000', 'tipe': 'Keluar'},
      {'kategori': 'Expenses (Minuman)', 'nominal': 'Rp 350.000', 'tipe': 'Keluar'},
      {'kategori': 'Expenses (Entertainment)', 'nominal': 'Rp 450.000', 'tipe': 'Keluar'},
      {'kategori': 'Expenses (Beli Barang)', 'nominal': 'Rp 600.000', 'tipe': 'Keluar'},
      {'kategori': 'Income (Freelance)', 'nominal': 'Rp 5.000.000', 'tipe': 'Masuk'},
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textWhite),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Kelola Data',
          style: TextStyle(color: AppColors.textWhite, fontWeight: FontWeight.bold, fontSize: 18),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.cardBg,
            borderRadius: BorderRadius.circular(18),
          ),
          padding: const EdgeInsets.all(12),
          child: DataTable(
            horizontalMargin: 12,
            columnSpacing: 18,
            columns: const [
              DataColumn(label: Text('Kategori', style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.accentNeon))),
              DataColumn(label: Text('Nominal', style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.accentNeon))),
              DataColumn(label: Text('Tipe', style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.accentNeon))),
            ],
            rows: records.map((item) {
              final isMasuk = item['tipe'] == 'Masuk';
              return DataRow(cells: [
                DataCell(Text(item['kategori']!, style: const TextStyle(fontSize: 12, color: AppColors.textWhite))),
                DataCell(Text(item['nominal']!, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.textWhite))),
                DataCell(Text(
                  item['tipe']!,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: isMasuk ? AppColors.success : AppColors.danger,
                  ),
                )),
              ]);
            }).toList(),
          ),
        ),
      ),
    );
  }
}

// ================= HALAMAN EXPORT LAPORAN =================
class ExportReportPage extends StatelessWidget {
  const ExportReportPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textWhite),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Export Laporan',
          style: TextStyle(color: AppColors.textWhite, fontWeight: FontWeight.bold, fontSize: 18),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(28),
              decoration: BoxDecoration(
                color: AppColors.cardBg,
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.primaryPurple.withOpacity(0.3), width: 2),
              ),
              child: const Icon(Icons.picture_as_pdf_rounded, size: 70, color: AppColors.accentNeon),
            ),
            const SizedBox(height: 28),
            const Text(
              'Download Laporan dalam PDF',
              style: TextStyle(color: AppColors.textWhite, fontSize: 18, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            const Text(
              'Dapatkan rekapitulasi data keuangan bulanan Anda dalam format dokumen PDF.',
              style: TextStyle(color: AppColors.textMuted, fontSize: 13),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 36),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryPurple,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                ),
                icon: const Icon(Icons.download_rounded, color: Colors.white),
                label: const Text(
                  'Install / Unduh PDF',
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15),
                ),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Mengunduh Laporan_September_2026.pdf... (Simulasi Selesai)'),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ================= HALAMAN TENTANG APLIKASI =================
class AboutAppPage extends StatelessWidget {
  const AboutAppPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textWhite),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Tentang Aplikasi',
          style: TextStyle(color: AppColors.textWhite, fontWeight: FontWeight.bold, fontSize: 18),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 90,
                height: 90,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  gradient: const LinearGradient(
                    colors: [AppColors.primaryPurple, AppColors.accentNeon],
                  ),
                ),
                child: const Icon(Icons.account_balance_wallet_rounded, size: 48, color: Colors.white),
              ),
              const SizedBox(height: 20),
              const Text(
                'My Wallet App',
                style: TextStyle(color: AppColors.textWhite, fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text(
                'Versi 2.4.1 (Build 2026)',
                style: TextStyle(color: AppColors.accentNeon, fontSize: 14, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}