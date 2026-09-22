import 'package:flutter/material.dart';

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
        scaffoldBackgroundColor: const Color(0xFF0B0F14),
        fontFamily: 'Arial',
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.cyan,
          brightness: Brightness.dark,
        ),
      ),
      home: const PortfolioPage(),
    );
  }
}

class PortfolioPage extends StatelessWidget {
  const PortfolioPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF0B0F14),
        elevation: 0,
        title: const Row(
          children: [
            Icon(
              Icons.code_rounded,
              color: Colors.cyanAccent,
            ),
            SizedBox(width: 10),
            Text(
              'OKA.DEV',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                letterSpacing: 1.5,
              ),
            ),
          ],
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // =========================
            // PROFILE
            // =========================
            Center(
              child: Column(
                children: [
                  Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.cyanAccent,
                        width: 3,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.cyanAccent.withOpacity(0.25),
                          blurRadius: 25,
                          spreadRadius: 5,
                        ),
                      ],
                    ),
                    child: const CircleAvatar(
                      backgroundColor: Color(0xFF151B23),
                      child: Icon(
                        Icons.person_rounded,
                        size: 70,
                        color: Colors.cyanAccent,
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),

                  const Text(
                    'I MADE OKA WALI PUTRA',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1,
                    ),
                  ),

                  const SizedBox(height: 8),

                  const Text(
                    'Computer Engineering Student',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.cyanAccent,
                    ),
                  ),

                  const SizedBox(height: 12),

                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFF151B23),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: Colors.white12,
                      ),
                    ),
                    child: const Text(
                      'NIM • 202463121004',
                      style: TextStyle(
                        color: Colors.white70,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 45),

            // =========================
            // ABOUT
            // =========================
            const Text(
              'ABOUT ME',
              style: TextStyle(
                color: Colors.cyanAccent,
                fontWeight: FontWeight.bold,
                letterSpacing: 2,
              ),
            ),

            const SizedBox(height: 12),

            const Text(
              'Halo! Saya Oka, mahasiswa Teknik Komputer yang '
              'tertarik pada pengembangan website, mobile application, '
              'IoT, dan teknologi digital. Saya senang membuat project '
              'yang sederhana, modern, dan dapat digunakan secara nyata.',
              style: TextStyle(
                fontSize: 15,
                height: 1.7,
                color: Colors.white70,
              ),
            ),

            const SizedBox(height: 35),

            // =========================
            // SKILLS
            // =========================
            const Text(
              'MY SKILLS',
              style: TextStyle(
                color: Colors.cyanAccent,
                fontWeight: FontWeight.bold,
                letterSpacing: 2,
              ),
            ),

            const SizedBox(height: 15),

            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: [
                _skill('Flutter'),
                _skill('Dart'),
                _skill('Laravel'),
                _skill('PHP'),
                _skill('MySQL'),
                _skill('IoT'),
                _skill('ESP32'),
                _skill('GitHub'),
              ],
            ),

            const SizedBox(height: 35),

            // =========================
            // PROJECT
            // =========================
            const Text(
              'FEATURED PROJECT',
              style: TextStyle(
                color: Colors.cyanAccent,
                fontWeight: FontWeight.bold,
                letterSpacing: 2,
              ),
            ),

            const SizedBox(height: 15),

            _projectCard(
              icon: Icons.library_books_rounded,
              title: 'SiPerpus',
              description:
                  'Website sistem informasi manajemen perpustakaan '
                  'berbasis Laravel dengan fitur buku, anggota, '
                  'peminjaman dan booking.',
            ),

            const SizedBox(height: 15),

            _projectCard(
              icon: Icons.water_drop_rounded,
              title: 'Smart Water Monitoring',
              description:
                  'Konsep sistem monitoring penggunaan air berbasis '
                  'IoT dengan ESP32, sensor dan dashboard web.',
            ),

            const SizedBox(height: 35),

            // =========================
            // CONTACT
            // =========================
            const Text(
              'CONNECT WITH ME',
              style: TextStyle(
                color: Colors.cyanAccent,
                fontWeight: FontWeight.bold,
                letterSpacing: 2,
              ),
            ),

            const SizedBox(height: 15),

            Row(
              children: [
                _socialButton(
                  Icons.code,
                  'GitHub',
                ),
                const SizedBox(width: 12),
                _socialButton(
                  Icons.camera_alt_outlined,
                  'Instagram',
                ),
                const SizedBox(width: 12),
                _socialButton(
                  Icons.email_outlined,
                  'Email',
                ),
              ],
            ),

            const SizedBox(height: 40),

            // =========================
            // FOOTER
            // =========================
            Center(
              child: Text(
                '© 2026 I Made Oka Wali Putra',
                style: TextStyle(
                  color: Colors.white38,
                  fontSize: 13,
                ),
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  // =========================
  // SKILL WIDGET
  // =========================

  static Widget _skill(String name) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 14,
        vertical: 9,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFF151B23),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Colors.white12,
        ),
      ),
      child: Text(
        name,
        style: const TextStyle(
          color: Colors.white70,
          fontSize: 13,
        ),
      ),
    );
  }

  // =========================
  // PROJECT CARD
  // =========================

  static Widget _projectCard({
    required IconData icon,
    required String title,
    required String description,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF111720),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: Colors.white10,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: Colors.cyanAccent.withOpacity(0.1),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(
              icon,
              color: Colors.cyanAccent,
              size: 27,
            ),
          ),

          const SizedBox(width: 15),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 8),

                Text(
                  description,
                  style: const TextStyle(
                    color: Colors.white60,
                    height: 1.5,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // =========================
  // SOCIAL BUTTON
  // =========================

  static Widget _socialButton(
    IconData icon,
    String name,
  ) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 14,
        ),
        decoration: BoxDecoration(
          color: const Color(0xFF151B23),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: Colors.white10,
          ),
        ),
        child: Column(
          children: [
            Icon(
              icon,
              color: Colors.cyanAccent,
              size: 22,
            ),

            const SizedBox(height: 6),

            Text(
              name,
              style: const TextStyle(
                fontSize: 11,
                color: Colors.white60,
              ),
            ),
          ],
        ),
      ),
    );
  }
}