import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

import '../../services/sign_upload_service.dart';

class UploadScreen extends StatefulWidget {
  const UploadScreen({super.key});

  @override
  State<UploadScreen> createState() =>
      _UploadScreenState();
}

class _UploadScreenState
    extends State<UploadScreen> {
  final _wordController =
      TextEditingController();

  final _countryController =
      TextEditingController();

  final _regionController =
      TextEditingController();

  final _uploaderController =
      TextEditingController();

  String _language = 'LSM';

  File? _video;

  bool _uploading = false;

  Future<void> pickVideo() async {
    final result =
        await FilePicker.platform.pickFiles(
      type: FileType.video,
    );

    if (result == null) return;

    setState(() {
      _video =
          File(result.files.single.path!);
    });
  }

  Future<void> upload() async {
    if (_video == null) return;

    setState(() {
      _uploading = true;
    });

    try {
      await SignUploadService.uploadSign(
        videoFile: _video!,
        word: _wordController.text,
        country: _countryController.text,
        region: _regionController.text,
        language: _language,
        uploader: _uploaderController.text,
      );

      if (!mounted) return;

      ScaffoldMessenger.of(context)
          .showSnackBar(
        const SnackBar(
          content:
              Text('Sign uploaded successfully'),
        ),
      );
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context)
          .showSnackBar(
        SnackBar(
          content: Text(e.toString()),
        ),
      );
    }

    setState(() {
      _uploading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Upload Sign'),
      ),
      body: ListView(
        padding:
            const EdgeInsets.all(20),
        children: [
          TextField(
            controller: _wordController,
            decoration:
                const InputDecoration(
              labelText: 'Word',
            ),
          ),
          const SizedBox(height: 12),

          TextField(
            controller:
                _countryController,
            decoration:
                const InputDecoration(
              labelText: 'Country',
            ),
          ),

          const SizedBox(height: 12),

          TextField(
            controller:
                _regionController,
            decoration:
                const InputDecoration(
              labelText: 'Region',
            ),
          ),

          const SizedBox(height: 12),

          TextField(
            controller:
                _uploaderController,
            decoration:
                const InputDecoration(
              labelText: 'Uploader',
            ),
          ),

          const SizedBox(height: 12),

          DropdownButtonFormField<String>(
          initialValue: _language,
          items: const [
            DropdownMenuItem(
              value: 'LSM',
              child: Text('LSM'),
            ),
          ],
          onChanged: (value) {
            setState(() {
              _language = value!;
            });
          },
        ),

          const SizedBox(height: 20),

          ElevatedButton.icon(
            onPressed: pickVideo,
            icon:
                const Icon(Icons.video_file),
            label:
                const Text('Choose Video'),
          ),

          if (_video != null)
            Padding(
              padding:
                  const EdgeInsets.only(
                top: 12,
              ),
              child: Text(
                _video!.path,
              ),
            ),

          const SizedBox(height: 24),

          FilledButton(
            onPressed:
                _uploading ? null : upload,
            child: Text(
              _uploading
                  ? 'Uploading...'
                  : 'Upload Sign',
            ),
          ),
        ],
      ),
    );
  }
}