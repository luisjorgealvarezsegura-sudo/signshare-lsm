import 'package:flutter/material.dart';

import '../../models/sign_video.dart';

class SignVideoTile extends StatelessWidget {
  const SignVideoTile({
    super.key,
    required this.video,
  });

  final SignVideo video;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(top: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 180,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Center(
                child: Icon(
                  Icons.play_circle_fill_rounded,
                  size: 56,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              video.word,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            Text('Country: ${video.country}'),
            Text('Region: ${video.region}'),
            Text('Language: ${video.language}'),
            Text('Uploader: ${video.uploader}'),
          ],
        ),
      ),
    );
  }
}