import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const ProfilSaya());
}

class ProfilSaya extends StatelessWidget {
  const ProfilSaya({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Profil Saya',
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF0A0A0A),
        fontFamily: 'Arial',
        colorScheme: const ColorScheme.dark(
          primary: Colors.white,
          secondary: Color(0xFF9E9E9E),
          surface: Color(0xFF141414),
        ),
        useMaterial3: true,
      ),
      home: const PortfolioPage(),
    );
  }
}

class PortfolioPage extends StatefulWidget {
  const PortfolioPage({super.key});

  @override
  State<PortfolioPage> createState() => _PortfolioPageState();
}

class _PortfolioPageState extends State<PortfolioPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  bool _isDark = true;

  // Warna monochrome palette
  final Color bg = const Color(0xFF0A0A0A);
  final Color card = const Color(0xFF141414);
  final Color cardAlt = const Color(0xFF1C1C1C);
  final Color border = const Color(0xFF2A2A2A);
  final Color accent = const Color(0xFFFFFFFF);
  final Color muted = const Color(0xFF9E9E9E);
  final Color dim = const Color(0xFF666666);

  // =========================
  // 🔗 GANTI LINK SOSMED KAMU DI SINI
  // =========================
  final String githubUrl = 'https://github.com/username-kamu';
  final String instagramUrl = 'https://instagram.com/username-kamu';
  final String emailUrl = 'mailto:emailkamu@gmail.com';
  final String linkedinUrl = 'https://linkedin.com/in/username-kamu';
  final String whatsappUrl = 'https://wa.me/6281234567890';

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  // 🔗 Fungsi buka link
  Future<void> _launchUrl(String url) async {
    final Uri uri = Uri.parse(url);
    try {
      if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
        throw Exception('Tidak bisa membuka $url');
      }
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Gagal membuka link: $e',
              style: TextStyle(color: accent)),
          backgroundColor: cardAlt,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bg,
      appBar: AppBar(
        backgroundColor: bg,
        elevation: 0,
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: card,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: border),
              ),
              child: Icon(Icons.code_rounded, color: accent, size: 18),
            ),
            const SizedBox(width: 10),
            Text(
              'OKA.DEV',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                letterSpacing: 2,
                color: accent,
                fontSize: 16,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {
              setState(() => _isDark = !_isDark);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    _isDark ? 'Dark Mode aktif' : 'Light Mode (demo)',
                    style: TextStyle(color: accent),
                  ),
                  backgroundColor: cardAlt,
                  duration: const Duration(milliseconds: 800),
                ),
              );
            },
            icon: Icon(
              _isDark ? Icons.dark_mode_rounded : Icons.light_mode_rounded,
              color: muted,
            ),
          ),
          const SizedBox(width: 8),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(48),
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: card,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: border),
            ),
            child: TabBar(
              controller: _tabController,
              indicator: BoxDecoration(
                color: cardAlt,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: border),
              ),
              indicatorSize: TabBarIndicatorSize.tab,
              dividerColor: Colors.transparent,
              labelColor: accent,
              unselectedLabelColor: dim,
              labelStyle: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.5,
              ),
              tabs: const [
                Tab(text: 'ABOUT'),
                Tab(text: 'SKILLS'),
                Tab(text: 'PROJECT'),
                Tab(text: 'CONTACT'),
              ],
            ),
          ),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildAboutTab(),
          _buildSkillsTab(),
          _buildProjectsTab(),
          _buildContactTab(),
        ],
      ),
    );
  }

  // =========================
  // PROFILE HEADER DENGAN FOTO
  // =========================
  Widget _buildProfileHeader() {
    return Center(
      child: Column(
        children: [
          // 📸 Foto profil dengan animasi & ring
          TweenAnimationBuilder<double>(
            tween: Tween(begin: 0, end: 1),
            duration: const Duration(milliseconds: 900),
            curve: Curves.easeOutBack,
            builder: (context, value, child) {
              return Transform.scale(scale: value, child: child);
            },
            child: GestureDetector(
              onTap: () => _showPhotoDialog(),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Glow ring
                  Container(
                    width: 140,
                    height: 140,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: SweepGradient(
                        colors: [
                          Colors.white.withOpacity(0.0),
                          Colors.white.withOpacity(0.6),
                          Colors.white.withOpacity(0.0),
                        ],
                        stops: const [0.0, 0.5, 1.0],
                      ),
                    ),
                  ),
                  // Border ring
                  Container(
                    width: 128,
                    height: 128,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: accent, width: 2),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.white.withOpacity(0.15),
                          blurRadius: 30,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                  ),
                  // Foto profil
                  Container(
                    width: 116,
                    height: 116,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    child: ClipOval(
                      child: Image.asset(
                        'assets/profile.jpg',
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stack) {
                          // Fallback kalau foto belum ada
                          return Container(
                            color: card,
                            child: Icon(
                              Icons.person_rounded,
                              size: 60,
                              color: accent,
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  // Badge online (opsional)
                  Positioned(
                    bottom: 8,
                    right: 8,
                    child: Container(
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(
                        color: accent,
                        shape: BoxShape.circle,
                        border: Border.all(color: bg, width: 3),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 24),

          Text(
            'I MADE OKA WALI PUTRA',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.5,
              color: accent,
            ),
          ),

          const SizedBox(height: 8),

          _TypingText(
            text: 'Computer Engineering Student',
            style: TextStyle(
              fontSize: 15,
              color: muted,
              letterSpacing: 1,
            ),
          ),

          const SizedBox(height: 14),

          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: card,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: border),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.badge_outlined, size: 14, color: muted),
                const SizedBox(width: 8),
                Text(
                  'NIM • 202463121004',
                  style: TextStyle(
                    color: muted,
                    fontSize: 12,
                    letterSpacing: 1,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // 🔗 Quick social icons di bawah profile
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _iconButton(
                Icons.code_rounded,
                'GitHub',
                githubUrl,
              ),
              const SizedBox(width: 12),
              _iconButton(
                Icons.camera_alt_outlined,
                'Instagram',
                instagramUrl,
              ),
              const SizedBox(width: 12),
              _iconButton(
                Icons.work_outline,
                'LinkedIn',
                linkedinUrl,
              ),
              const SizedBox(width: 12),
              _iconButton(
                Icons.email_outlined,
                'Email',
                emailUrl,
              ),
            ],
          ),
        ],
      ),
    );
  }

  // 🔘 Icon button dengan animasi hover & onTap
  Widget _iconButton(IconData icon, String tooltip, String url) {
    return Tooltip(
      message: tooltip,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => _launchUrl(url),
          borderRadius: BorderRadius.circular(12),
          child: Container(
            width: 46,
            height: 46,
            decoration: BoxDecoration(
              color: card,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: border),
            ),
            child: Icon(icon, color: accent, size: 20),
          ),
        ),
      ),
    );
  }

  // 🖼️ Dialog preview foto fullscreen
  void _showPhotoDialog() {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: const EdgeInsets.all(20),
        child: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: accent, width: 2),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(18),
              child: Image.asset(
                'assets/profile.jpg',
                fit: BoxFit.cover,
                errorBuilder: (context, error, stack) {
                  return Container(
                    height: 300,
                    color: card,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.broken_image_outlined,
                              size: 60, color: muted),
                          const SizedBox(height: 12),
                          Text(
                            'Foto belum ditambahkan\nTaruh di assets/profile.jpg',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: muted),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  // =========================
  // TAB 1: ABOUT
  // =========================
  Widget _buildAboutTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildProfileHeader(),
          const SizedBox(height: 45),
          _sectionTitle('ABOUT ME'),
          const SizedBox(height: 12),
          Text(
            'Halo! Saya Oka, mahasiswa Teknik Komputer yang '
            'tertarik pada pengembangan website, mobile application, '
            'IoT, dan teknologi digital. Saya senang membuat project '
            'yang sederhana, modern, dan dapat digunakan secara nyata.',
            style: TextStyle(
              fontSize: 15,
              height: 1.8,
              color: muted,
            ),
          ),
          const SizedBox(height: 30),
          Row(
            children: [
              Expanded(
                child: _infoCard(
                  Icons.school_outlined,
                  'Pendidikan',
                  'Teknik Komputer',
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _infoCard(
                  Icons.location_on_outlined,
                  'Lokasi',
                  'Indonesia',
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _infoCard(
                  Icons.work_outline,
                  'Fokus',
                  'Web • Mobile • IoT',
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _infoCard(
                  Icons.coffee_outlined,
                  'Hobi',
                  'Coding & Design',
                ),
              ),
            ],
          ),
          const SizedBox(height: 30),
          _sectionTitle('STATISTIK'),
          const SizedBox(height: 15),
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: card,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: border),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _statItem('10+', 'Projects'),
                Container(width: 1, height: 40, color: border),
                _statItem('2+', 'Years'),
                Container(width: 1, height: 40, color: border),
                _statItem('8+', 'Skills'),
              ],
            ),
          ),
          const SizedBox(height: 40),
          _footer(),
        ],
      ),
    );
  }

  // =========================
  // TAB 2: SKILLS
  // =========================
  Widget _buildSkillsTab() {
    final skills = [
      {'name': 'Flutter', 'level': 0.85},
      {'name': 'Dart', 'level': 0.80},
      {'name': 'Laravel', 'level': 0.75},
      {'name': 'PHP', 'level': 0.78},
      {'name': 'MySQL', 'level': 0.72},
      {'name': 'IoT', 'level': 0.70},
      {'name': 'ESP32', 'level': 0.68},
      {'name': 'GitHub', 'level': 0.80},
    ];

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionTitle('MY SKILLS'),
          const SizedBox(height: 8),
          Text('Teknologi yang saya kuasai',
              style: TextStyle(color: dim, fontSize: 13)),
          const SizedBox(height: 25),
          ...skills.map((s) => _skillBar(
                s['name'] as String,
                s['level'] as double,
              )),
          const SizedBox(height: 35),
          _sectionTitle('TOOLS'),
          const SizedBox(height: 15),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: [
              _chip('VS Code'),
              _chip('Android Studio'),
              _chip('Postman'),
              _chip('Figma'),
              _chip('Arduino IDE'),
              _chip('Git'),
            ],
          ),
          const SizedBox(height: 40),
          _footer(),
        ],
      ),
    );
  }

  // =========================
  // TAB 3: PROJECTS
  // =========================
  Widget _buildProjectsTab() {
    final projects = [
      {
        'icon': Icons.library_books_rounded,
        'title': 'SiPerpus',
        'desc':
            'Website sistem informasi manajemen perpustakaan berbasis Laravel dengan fitur buku, anggota, peminjaman dan booking.',
        'tags': ['Laravel', 'MySQL', 'Web'],
        'status': 'Completed',
      },
      {
        'icon': Icons.water_drop_rounded,
        'title': 'Smart Water Monitoring',
        'desc':
            'Konsep sistem monitoring penggunaan air berbasis IoT dengan ESP32, sensor dan dashboard web.',
        'tags': ['IoT', 'ESP32', 'Dashboard'],
        'status': 'In Progress',
      },
      {
        'icon': Icons.phone_android_rounded,
        'title': 'Mobile Portfolio App',
        'desc':
            'Aplikasi portfolio pribadi berbasis Flutter dengan UI modern monochrome dan animasi smooth.',
        'tags': ['Flutter', 'Dart', 'Mobile'],
        'status': 'Completed',
      },
    ];

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionTitle('FEATURED PROJECT'),
          const SizedBox(height: 8),
          Text('Beberapa project yang saya kerjakan',
              style: TextStyle(color: dim, fontSize: 13)),
          const SizedBox(height: 25),
          ...projects.map((p) => _projectCardNew(
                icon: p['icon'] as IconData,
                title: p['title'] as String,
                description: p['desc'] as String,
                tags: (p['tags'] as List).cast<String>(),
                status: p['status'] as String,
              )),
          const SizedBox(height: 40),
          _footer(),
        ],
      ),
    );
  }

  // =========================
  // TAB 4: CONTACT
  // =========================
  Widget _buildContactTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionTitle('CONNECT WITH ME'),
          const SizedBox(height: 8),
          Text('Klik untuk terhubung langsung',
              style: TextStyle(color: dim, fontSize: 13)),
          const SizedBox(height: 25),
          _contactTile(
            Icons.code_rounded,
            'GitHub',
            'Lihat repository saya',
            githubUrl,
          ),
          const SizedBox(height: 12),
          _contactTile(
            Icons.camera_alt_outlined,
            'Instagram',
            'Follow daily updates',
            instagramUrl,
          ),
          const SizedBox(height: 12),
          _contactTile(
            Icons.work_outline,
            'LinkedIn',
            'Connect professionally',
            linkedinUrl,
          ),
          const SizedBox(height: 12),
          _contactTile(
            Icons.email_outlined,
            'Email',
            'Kirim pesan langsung',
            emailUrl,
          ),
          const SizedBox(height: 12),
          _contactTile(
            Icons.chat_bubble_outline,
            'WhatsApp',
            'Chat dengan saya',
            whatsappUrl,
          ),
          const SizedBox(height: 35),
          _sectionTitle('SEND MESSAGE'),
          const SizedBox(height: 15),
          _inputField('Nama', 'Masukkan nama kamu'),
          const SizedBox(height: 12),
          _inputField('Email', 'Masukkan email kamu'),
          const SizedBox(height: 12),
          _inputField('Pesan', 'Tulis pesan...', maxLines: 4),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      '✓ Pesan terkirim! Terima kasih.',
                      style: TextStyle(color: accent),
                    ),
                    backgroundColor: cardAlt,
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: accent,
                foregroundColor: bg,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                'KIRIM PESAN',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.5,
                ),
              ),
            ),
          ),
          const SizedBox(height: 40),
          _footer(),
        ],
      ),
    );
  }

  // =========================
  // HELPER WIDGETS
  // =========================

  Widget _sectionTitle(String text) {
    return Row(
      children: [
        Container(
          width: 4,
          height: 20,
          decoration: BoxDecoration(
            color: accent,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: 10),
        Text(
          text,
          style: TextStyle(
            color: accent,
            fontWeight: FontWeight.bold,
            letterSpacing: 2,
            fontSize: 14,
          ),
        ),
      ],
    );
  }

  Widget _infoCard(IconData icon, String label, String value) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: card,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: muted, size: 20),
          const SizedBox(height: 10),
          Text(label,
              style:
                  TextStyle(color: dim, fontSize: 11, letterSpacing: 1)),
          const SizedBox(height: 4),
          Text(
            value,
            style: TextStyle(
              color: accent,
              fontSize: 13,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _statItem(String value, String label) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            color: accent,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(label,
            style:
                TextStyle(color: dim, fontSize: 11, letterSpacing: 1)),
      ],
    );
  }

  Widget _skillBar(String name, double level) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                name,
                style: TextStyle(
                  color: accent,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text('${(level * 100).toInt()}%',
                  style: TextStyle(color: dim, fontSize: 12)),
            ],
          ),
          const SizedBox(height: 8),
          TweenAnimationBuilder<double>(
            tween: Tween(begin: 0, end: level),
            duration: const Duration(milliseconds: 1200),
            curve: Curves.easeOutCubic,
            builder: (context, value, child) {
              return Container(
                height: 6,
                decoration: BoxDecoration(
                  color: cardAlt,
                  borderRadius: BorderRadius.circular(3),
                ),
                child: FractionallySizedBox(
                  alignment: Alignment.centerLeft,
                  widthFactor: value,
                  child: Container(
                    decoration: BoxDecoration(
                      color: accent,
                      borderRadius: BorderRadius.circular(3),
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _chip(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 9),
      decoration: BoxDecoration(
        color: card,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: border),
      ),
      child: Text(text,
          style: TextStyle(color: muted, fontSize: 13)),
    );
  }

  Widget _projectCardNew({
    required IconData icon,
    required String title,
    required String description,
    required List<String> tags,
    required String status,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: card,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: cardAlt,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: border),
                ),
                child: Icon(icon, color: accent, size: 26),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: accent,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 3,
                      ),
                      decoration: BoxDecoration(
                        color: cardAlt,
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(color: border),
                      ),
                      child: Text(
                        status,
                        style: TextStyle(
                          color: muted,
                          fontSize: 10,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Text(
            description,
            style: TextStyle(
              color: muted,
              height: 1.6,
              fontSize: 13,
            ),
          ),
          const SizedBox(height: 14),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: tags
                .map((t) => Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 5,
                      ),
                      decoration: BoxDecoration(
                        color: cardAlt,
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(color: border),
                      ),
                      child: Text(
                        t,
                        style: TextStyle(
                          color: dim,
                          fontSize: 11,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ))
                .toList(),
          ),
        ],
      ),
    );
  }

  // 🔗 Contact tile yang bisa diklik
  Widget _contactTile(
    IconData icon,
    String label,
    String value,
    String url,
  ) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => _launchUrl(url),
        borderRadius: BorderRadius.circular(14),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: card,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: border),
          ),
          child: Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: cardAlt,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: border),
                ),
                child: Icon(icon, color: accent, size: 20),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      label,
                      style: TextStyle(
                        color: accent,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      value,
                      style: TextStyle(color: dim, fontSize: 12),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: cardAlt,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: border),
                ),
                child: Icon(
                  Icons.arrow_outward_rounded,
                  color: muted,
                  size: 16,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _inputField(String label, String hint, {int maxLines = 1}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style:
                TextStyle(color: muted, fontSize: 12, letterSpacing: 1)),
        const SizedBox(height: 8),
        TextField(
          maxLines: maxLines,
          style: TextStyle(color: accent, fontSize: 14),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(color: dim, fontSize: 13),
            filled: true,
            fillColor: card,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 14,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: border),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: border),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: accent, width: 1.5),
            ),
          ),
        ),
      ],
    );
  }

  Widget _footer() {
    return Center(
      child: Column(
        children: [
          Container(
            width: 40,
            height: 3,
            decoration: BoxDecoration(
              color: border,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            '© 2026 I Made Oka Wali Putra',
            style:
                TextStyle(color: dim, fontSize: 12, letterSpacing: 0.5),
          ),
        ],
      ),
    );
  }
}

// =========================
// TYPING TEXT ANIMATION
// =========================
class _TypingText extends StatefulWidget {
  final String text;
  final TextStyle style;

  const _TypingText({required this.text, required this.style});

  @override
  State<_TypingText> createState() => _TypingTextState();
}

class _TypingTextState extends State<_TypingText> {
  String _displayed = '';
  int _index = 0;

  @override
  void initState() {
    super.initState();
    _startTyping();
  }

  void _startTyping() async {
    for (int i = 0; i <= widget.text.length; i++) {
      await Future.delayed(const Duration(milliseconds: 60));
      if (!mounted) return;
      setState(() {
        _index = i;
        _displayed = widget.text.substring(0, i);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(_displayed, style: widget.style),
        if (_index < widget.text.length)
          Container(
            margin: const EdgeInsets.only(left: 2),
            width: 2,
            height: 16,
            color: widget.style.color,
          ),
      ],
    );
  }
}