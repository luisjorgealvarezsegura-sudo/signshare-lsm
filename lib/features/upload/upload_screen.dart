import 'package:flutter/material.dart';

class UploadScreen extends StatelessWidget {
  const UploadScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Upload a Sign'),
      ),
      body: const SafeArea(
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.video_call_rounded,
                  size: 80,
                ),
                SizedBox(height: 24),
                Text(
                  'Upload a Sign',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  'Video uploads will be enabled in the next version.\n\nFor now, use the Search feature to explore the community dictionary.',
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}