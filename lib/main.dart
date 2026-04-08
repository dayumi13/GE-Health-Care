import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gea_health/modul_detail.dart';
import 'package:window_manager/window_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (!kIsWeb && (Platform.isWindows || Platform.isMacOS || Platform.isLinux)) {
    await windowManager.ensureInitialized();

    WindowOptions windowOptions = const WindowOptions(
      size: Size(1280, 720),
      center: true,
      backgroundColor: Colors.transparent,
      skipTaskbar: false,
      titleBarStyle: TitleBarStyle.normal,
      title: 'Gea Health - LearnHub',
    );
    windowManager.waitUntilReadyToShow(windowOptions, () async {
      await windowManager.show();
      await windowManager.focus();
    });
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ge Health',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Inter',
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF6022A6)),
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFF8F9FB),
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  List<Module> get modules => [
        const Module(
          title: 'Module I',
          description: 'Pengenalan CT Scan',
          lessons: [
            Lesson(
                title: 'Pengenalan CT Scan GEHC Revolution Maxima',
                duration: '0:37',
                videoPath: 'assets/Modul-1.mp4'),
            Lesson(
                title: 'Spesifikasi Revolution Maxima',
                duration: '0:59',
                videoPath: 'assets/Modul-1.mp4'),
            Lesson(
                title: 'Fitur Unggulan Revolution Maxima',
                duration: '01:30',
                videoPath: 'assets/Modul-1.mp4'),
            Lesson(
                title: 'Keunggulan CT Scan',
                duration: '04:42',
                videoPath: 'assets/Modul-1.mp4'),
            Lesson(
                title: 'Positioning Pasien',
                duration: '08:46',
                videoPath: 'assets/Modul-1.mp4'),
            Lesson(
                title: 'Aksesoris CT Scan',
                duration: '11:52',
                videoPath: 'assets/Modul-1.mp4'),
            Lesson(
                title: 'Prosedur Menghidupkan CT Scan',
                duration: '12:28',
                videoPath: 'assets/Modul-1.mp4'),
            // Lesson(
            //     title: 'Pengenalan Scan RX',
            //     duration: '13:14',
            //     videoPath: 'assets/Modul-1.mp4'),
          ],
          icon: Icons.video_label,
          color: Color(0xFF45B2C5),
        ),
        const Module(
          title: 'Modul II',
          description: 'Daily Preparation',
          lessons: [
            Lesson(
                title: 'Daily Preparation',
                duration: '00:00',
                videoPath: 'assets/Modul-2.mp4'),
            Lesson(
                title: 'Tube Warm Up',
                duration: '00:26',
                videoPath: 'assets/Modul-2.mp4'),
            Lesson(
                title: 'Fast Calibration',
                duration: '01:10',
                videoPath: 'assets/Modul-2.mp4'),
          ],
          icon: Icons.video_label,
          color: Color(0xFFF37F63),
        ),
        const Module(
          title: 'Modul III',
          description: 'List Data',
          lessons: [
            Lesson(
                title: 'Transfer Data',
                duration: '00:03',
                videoPath: 'assets/Modul-3.mp4'),
            Lesson(
                title: 'Media Creator (CD/DVD/USB)',
                duration: '00:47',
                videoPath: 'assets/Modul-3.mp4'),
            Lesson(
                title: 'Prosedur Konfigurasi Jaringan',
                duration: '01:25',
                videoPath: 'assets/Modul-3.mp4'),
            Lesson(
                title: 'Import Data dari CD/DVD',
                duration: '01:57',
                videoPath: 'assets/Modul-3.mp4'),
            Lesson(
                title: 'Hapus Data Pasien',
                duration: '02:46',
                videoPath: 'assets/Modul-3.mp4'),
            Lesson(
                title:
                    'Penjelasan Aplikasi-aplikasi (Data Apps) di Image Works',
                duration: '04:09',
                videoPath: 'assets/Modul-3.mp4'),
          ],
          icon: Icons.video_label,
          color: Color(0xFFF8D754),
        ),
        const Module(
          title: 'Modul IV',
          description: 'GE Explanation & User Protocol',
          lessons: [
            Lesson(
                title: 'Prosedur Melakukan Scanning',
                duration: '00:03',
                videoPath: 'assets/Modul-4.mp4'),
            Lesson(
                title: 'Penjelasan List User Protokol',
                duration: '02:15',
                videoPath: 'assets/Modul-4.mp4'),
            Lesson(
                title: 'Protokol Anak- anak',
                duration: '09:04',
                videoPath: 'assets/Modul-4.mp4'),
          ],
          icon: Icons.video_label,
          color: Color(0xFFF37F63),
        ),
        const Module(
          title: 'Modul V',
          description: 'Scanning Practice',
          lessons: [
            Lesson(
                title: 'Pemeriksaan CT Kepala Polos dan Kontras',
                duration: '00:04',
                videoPath: 'assets/Modul-5.mp4'),
            Lesson(
                title: 'Pemeriksaan CT Thorax',
                duration: '08:18',
                videoPath: 'assets/Modul-5.mp4'),
            Lesson(
                title: 'Pemeriksaan CT Abdomen Multiphase',
                duration: '12:15',
                videoPath: 'assets/Modul-5.mp4'),
          ],
          icon: Icons.video_label,
          color: Color(0xFF45B2C5),
        ),
        const Module(
          title: 'Modul VI',
          description: 'How to Change Orientation',
          lessons: [
            Lesson(
                title: 'Cara Merubah Orientasi Posisi Pasien',
                duration: '00:02',
                videoPath: 'assets/Modul-6.mp4'),
            Lesson(
                title: 'Reformat',
                duration: '01:41',
                videoPath: 'assets/Modul-6.mp4'),
            Lesson(
                title: '3D',
                duration: '10:42',
                videoPath: 'assets/Modul-6.mp4'),
            Lesson(
                title: 'Filmer',
                duration: '12:45',
                videoPath: 'assets/Modul-6.mp4'),
            Lesson(
                title: 'Manual Film',
                duration: '14:39',
                videoPath: 'assets/Modul-6.mp4'),
            Lesson(
                title: 'Edit Data Pasien',
                duration: '17:24',
                videoPath: 'assets/Modul-6.mp4'),
            Lesson(
                title: 'Hapus Data Pasien',
                duration: '19:06',
                videoPath: 'assets/Modul-6.mp4'),
            Lesson(
                title: 'Prosedur Mematikan Alat CT Scan',
                duration: '20:54',
                videoPath: 'assets/Modul-6.mp4'),
          ],
          icon: Icons.video_label,
          color: Color(0xFF6022A6),
        ),
      ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          _buildHeader(),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 1100),
                  child: Column(
                    children: [
                      const Text(
                        'Video Tutorial Platform',
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF202124),
                        ),
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        'Select a module to start your video tutorial',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black54,
                        ),
                      ),
                      const SizedBox(height: 48),
                      GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount:
                              MediaQuery.of(context).size.width > 900
                                  ? 3
                                  : MediaQuery.of(context).size.width > 600
                                      ? 2
                                      : 1,
                          crossAxisSpacing: 24,
                          mainAxisSpacing: 24,
                          childAspectRatio: 0.85,
                        ),
                        itemCount: modules.length,
                        itemBuilder: (context, index) =>
                            ModuleCard(module: modules[index]),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      height: 100,
      padding: const EdgeInsets.symmetric(horizontal: 40),
      decoration: const BoxDecoration(
        color: Color(0xFF6022A6),
      ),
      child: Row(
        children: [
          Image.asset('assets/Logo-White.png', height: 80),
          // Text(
          //   'Video Tutorial Platform',
          //   style: TextStyle(
          //     color: Colors.white.withOpacity(0.8),
          //     fontSize: 12,
          //   ),
          // ),
        ],
      ),
    );
  }
}

class ModuleCard extends StatelessWidget {
  final Module module;

  const ModuleCard({super.key, required this.module});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => ModuleDetailPage(module: module),
          ),
        );
      },
      borderRadius: BorderRadius.circular(16),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        clipBehavior: Clip.antiAlias,
        child: Stack(
          children: [
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Container(
                height: 4,
                color: module.color,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: module.color.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(module.icon, color: module.color, size: 28),
                  ),
                  const Spacer(),
                  Text(
                    module.title,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF202124),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    module.description,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.black54,
                      height: 1.4,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${module.lessons.length} lessons',
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.black45,
                        ),
                      ),
                      TextButton.icon(
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) =>
                                  ModuleDetailPage(module: module),
                            ),
                          );
                        },
                        icon: const Text(
                          'Start Watching',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        label: Icon(Icons.arrow_forward,
                            color: module.color, size: 16),
                        style: TextButton.styleFrom(
                          foregroundColor: module.color,
                          padding: EdgeInsets.zero,
                        ),
                      ),
                    ],
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
