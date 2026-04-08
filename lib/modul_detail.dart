import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';

class Lesson {
  final String title;
  final String duration;
  final String videoPath;

  const Lesson({
    required this.title,
    required this.duration,
    required this.videoPath,
  });
}

class Module {
  final String title;
  final String description;
  final List<Lesson> lessons;
  final IconData icon;
  final Color color;

  const Module({
    required this.title,
    required this.description,
    required this.lessons,
    required this.icon,
    required this.color,
  });
}

class ModuleDetailPage extends StatefulWidget {
  final Module module;

  const ModuleDetailPage({super.key, required this.module});

  @override
  State<ModuleDetailPage> createState() => _ModuleDetailPageState();
}

class _ModuleDetailPageState extends State<ModuleDetailPage> {
  late VideoPlayerController _videoPlayerController;
  ChewieController? _chewieController;
  int _currentLessonIndex = 0;

  @override
  void initState() {
    super.initState();
    _initializePlayer();
  }

  Duration _parseDuration(String durationString) {
    try {
      final parts = durationString.split(':');
      if (parts.length == 2) {
        final minutes = int.parse(parts[0]);
        final seconds = int.parse(parts[1]);
        return Duration(minutes: minutes, seconds: seconds);
      } else if (parts.length == 3) {
        final hours = int.parse(parts[0]);
        final minutes = int.parse(parts[1]);
        final seconds = int.parse(parts[2]);
        return Duration(hours: hours, minutes: minutes, seconds: seconds);
      }
    } catch (e) {
      debugPrint('Error parsing duration: $e');
    }
    return Duration.zero;
  }

  Future<void> _initializePlayer() async {
    final lesson = widget.module.lessons[_currentLessonIndex];
    _videoPlayerController = VideoPlayerController.asset(lesson.videoPath);

    try {
      await _videoPlayerController.initialize();

      // Seek to the specified start duration
      final startTime = _parseDuration(lesson.duration);
      if (startTime != Duration.zero) {
        await _videoPlayerController.seekTo(startTime);
      }

      _chewieController = ChewieController(
        videoPlayerController: _videoPlayerController,
        autoPlay: true,
        looping: false,
        aspectRatio: _videoPlayerController.value.aspectRatio,
        materialProgressColors: ChewieProgressColors(
          playedColor: widget.module.color,
          handleColor: widget.module.color,
          backgroundColor: Colors.grey,
        ),
        placeholder: Container(
          color: Colors.black,
          child: const Center(child: CircularProgressIndicator()),
        ),
        errorBuilder: (context, errorMessage) {
          return const Center(
            child: Text(
              'Error loading video. Please make sure the asset exists.',
              style: TextStyle(color: Colors.white),
            ),
          );
        },
      );
    } catch (e) {
      debugPrint('Error initializing video player: $e');
    }

    if (mounted) setState(() {});
  }

  void _switchLesson(int index) {
    if (_currentLessonIndex == index) return;

    _chewieController?.dispose();
    _videoPlayerController.dispose();

    setState(() {
      _currentLessonIndex = index;
      _chewieController = null;
    });

    _initializePlayer();
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    _chewieController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isMobile = MediaQuery.of(context).size.width < 900;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          _buildTopBar(),
          _buildModuleTitleBar(),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (!isMobile) _buildSidebar(),
                Expanded(
                  child: Container(
                    color: const Color(0xFFF1F3F4),
                    child: Column(
                      children: [
                        Expanded(
                          child: Center(
                            child: AspectRatio(
                              aspectRatio: 16 / 9,
                              child: _chewieController != null &&
                                      _chewieController!.videoPlayerController
                                          .value.isInitialized
                                  ? Chewie(controller: _chewieController!)
                                  : Container(
                                      color: Colors.black,
                                      child: const Center(
                                          child: CircularProgressIndicator()),
                                    ),
                            ),
                          ),
                        ),
                        if (isMobile) _buildMobileLessonList(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTopBar() {
    return Container(
      height: 70,
      padding: const EdgeInsets.symmetric(horizontal: 24),
      decoration: const BoxDecoration(
        color: Color(0xFF6022A6),
      ),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
          const SizedBox(width: 8),
          Image.asset('assets/Logo-White.png', height: 80),
        ],
      ),
    );
  }

  Widget _buildModuleTitleBar() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(color: Colors.grey.shade200)),
      ),
      child: Row(
        children: [
          const Icon(Icons.grid_view, size: 20, color: Colors.black54),
          const SizedBox(width: 12),
          Text(
            "${widget.module.title} - ${widget.module.description}",
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget _buildSidebar() {
    return Container(
      width: 300,
      decoration: BoxDecoration(
        border: Border(right: BorderSide(color: Colors.grey.shade200)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(24),
            child: Row(
              children: [
                Icon(Icons.play_circle_outline,
                    color: Color(0xFF6200EE), size: 20),
                SizedBox(width: 12),
                Text(
                  'COURSE CONTENT',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.2,
                    color: Color(0xFF6200EE),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: widget.module.lessons.length,
              itemBuilder: (context, index) {
                final lesson = widget.module.lessons[index];
                final isSelected = _currentLessonIndex == index;
                return _buildLessonTile(lesson, index, isSelected);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMobileLessonList() {
    return Container(
      height: 200,
      color: Colors.white,
      child: ListView.builder(
        itemCount: widget.module.lessons.length,
        itemBuilder: (context, index) {
          final lesson = widget.module.lessons[index];
          final isSelected = _currentLessonIndex == index;
          return _buildLessonTile(lesson, index, isSelected);
        },
      ),
    );
  }

  Widget _buildLessonTile(Lesson lesson, int index, bool isSelected) {
    return InkWell(
      onTap: () => _switchLesson(index),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        color: isSelected ? const Color(0xFF6200EE).withOpacity(0.05) : null,
        child: Row(
          children: [
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: isSelected
                    ? const Color(0xFF6200EE).withOpacity(0.1)
                    : Colors.grey.shade100,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  '${index + 1}',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color:
                        isSelected ? const Color(0xFF6200EE) : Colors.black38,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    lesson.title,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight:
                          isSelected ? FontWeight.bold : FontWeight.normal,
                      color: isSelected ? Colors.black : Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    lesson.duration,
                    style: const TextStyle(fontSize: 12, color: Colors.black38),
                  ),
                ],
              ),
            ),
            if (isSelected)
              const Icon(Icons.play_arrow, color: Color(0xFF6200EE), size: 16),
          ],
        ),
      ),
    );
  }
}
