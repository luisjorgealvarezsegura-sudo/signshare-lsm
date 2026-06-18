import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import '../../models/sign_video.dart';

class SignVideoTile extends StatefulWidget {
  const SignVideoTile({
    super.key,
    required this.video,
  });

  final SignVideo video;

  @override
  State<SignVideoTile> createState() => _SignVideoTileState();
}

class _SignVideoTileState extends State<SignVideoTile> {
  VideoPlayerController? _controller;
  bool _loading = true;
  bool _hasError = false;

  @override
  void initState() {
    super.initState();
    _initializeVideo();
  }

  Future<void> _initializeVideo() async {
    try {
      if (widget.video.videoUrl.isEmpty) {
        setState(() {
          _hasError = true;
          _loading = false;
        });
        return;
      }

      _controller = VideoPlayerController.networkUrl(
        Uri.parse(widget.video.videoUrl),
      );

      await _controller!.initialize();

      setState(() {
        _loading = false;
      });
    } catch (e) {
      setState(() {
        _loading = false;
        _hasError = true;
      });
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  void _togglePlayPause() {
    if (_controller == null) return;

    setState(() {
      if (_controller!.value.isPlaying) {
        _controller!.pause();
      } else {
        _controller!.play();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(top: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (_loading)
              const SizedBox(
                height: 220,
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              )
            else if (_hasError)
              Container(
                height: 220,
                width: double.infinity,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.red.shade100,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Text(
                  'Could not load video',
                ),
              )
            else
              Column(
                children: [
                  AspectRatio(
                    aspectRatio:
                        _controller!.value.aspectRatio,
                    child: VideoPlayer(_controller!),
                  ),
                  const SizedBox(height: 8),
                  IconButton(
                    icon: Icon(
                      _controller!.value.isPlaying
                          ? Icons.pause
                          : Icons.play_arrow,
                    ),
                    onPressed: _togglePlayPause,
                  ),
                ],
              ),

            const SizedBox(height: 16),

            Text(
              widget.video.word,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 12),

            Text('Country: ${widget.video.country}'),
            Text('Region: ${widget.video.region}'),
            Text('Language: ${widget.video.language}'),
            Text('Uploader: ${widget.video.uploader}'),
          ],
        ),
      ),
    );
  }
}