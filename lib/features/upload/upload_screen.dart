import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

import '../../core/routes/app_routes.dart';
import '../../data/sign_repository.dart';
import '../../models/sign_video.dart';

class UploadScreen extends StatefulWidget {
  const UploadScreen({super.key});

  @override
  State<UploadScreen> createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {
  final _formKey = GlobalKey<FormState>();

  final _wordController = TextEditingController();
  final _countryController = TextEditingController(text: 'Mexico');
  final _regionController = TextEditingController();
  final _uploaderController = TextEditingController();

  String _language = 'LSM';
  String? _selectedVideoPath;
  String? _selectedVideoName;
  bool _saving = false;

  @override
  void dispose() {
    _wordController.dispose();
    _countryController.dispose();
    _regionController.dispose();
    _uploaderController.dispose();
    super.dispose();
  }

  Future<void> _pickVideo() async {
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.video,
        allowMultiple: false,
        withData: false,
      );

      if (!mounted || result == null) {
        return;
      }

      final pickedFile = result.files.single;
      final pickedPath = pickedFile.path;

      if (pickedPath == null || pickedPath.isEmpty) {
        _showMessage('Could not read the selected video path.');
        return;
      }

      setState(() {
        _selectedVideoPath = pickedPath;
        _selectedVideoName = pickedFile.name;
      });
    } catch (error) {
      if (!mounted) {
        return;
      }

      _showMessage('Could not select video: $error');
    }
  }

  Future<void> _saveSign() async {
    FocusScope.of(context).unfocus();

    if (!_formKey.currentState!.validate()) {
      return;
    }

    if (_selectedVideoPath == null) {
      _showMessage('Please select a video first.');
      return;
    }

    setState(() {
      _saving = true;
    });

    try {
      final id = SignRepository.createId();

      final savedVideoPath = await SignRepository.copyVideoToAppStorage(
        sourcePath: _selectedVideoPath!,
        signId: id,
      );

      final cleanWord = _cleanText(_wordController.text);

      final sign = SignVideo(
        id: id,
        word: _displayWord(cleanWord),
        wordKey: SignRepository.createWordKey(cleanWord),
        videoUrl: savedVideoPath,
        country: _cleanText(_countryController.text),
        region: _cleanText(_regionController.text),
        language: _language,
        uploader: _cleanText(_uploaderController.text),
      );

      await SignRepository.addUploadedSign(sign);

      if (!mounted) {
        return;
      }

      _clearForm();
      await _showSavedDialog(sign.word);
    } catch (error) {
      if (!mounted) {
        return;
      }

      _showMessage('Could not save sign: $error');
    } finally {
      if (mounted) {
        setState(() {
          _saving = false;
        });
      }
    }
  }

  void _clearForm() {
    setState(() {
      _wordController.clear();
      _countryController.text = 'Mexico';
      _regionController.clear();
      _uploaderController.clear();
      _language = 'LSM';
      _selectedVideoPath = null;
      _selectedVideoName = null;
    });
  }

  Future<void> _showSavedDialog(String word) async {
    await showDialog<void>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Sign saved'),
          content: Text(
            '"$word" is now saved and searchable on this device.',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(dialogContext).pop();
              },
              child: const Text('Stay Here'),
            ),
            FilledButton(
              onPressed: () {
                Navigator.of(dialogContext).pop();
                Navigator.pushNamed(context, AppRoutes.search);
              },
              child: const Text('Open Search'),
            ),
          ],
        );
      },
    );
  }

  String? _requiredValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Required';
    }

    return null;
  }

  String _cleanText(String value) {
    return value.trim();
  }

  String _displayWord(String word) {
    final clean = word.trim();

    if (clean.isEmpty) {
      return clean;
    }

    return clean[0].toUpperCase() + clean.substring(1).toLowerCase();
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Upload a Sign'),
      ),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 680),
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: AbsorbPointer(
                absorbing: _saving,
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        'Contribute a sign video',
                        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                              fontWeight: FontWeight.w800,
                            ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Select a video from your Android gallery and add the word, region, language, and uploader name.',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      const SizedBox(height: 24),
                      TextFormField(
                        controller: _wordController,
                        textInputAction: TextInputAction.next,
                        decoration: const InputDecoration(
                          labelText: 'Word',
                          hintText: 'Example: hola',
                          border: OutlineInputBorder(),
                        ),
                        validator: _requiredValidator,
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _countryController,
                        textInputAction: TextInputAction.next,
                        decoration: const InputDecoration(
                          labelText: 'Country',
                          hintText: 'Example: Mexico',
                          border: OutlineInputBorder(),
                        ),
                        validator: _requiredValidator,
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _regionController,
                        textInputAction: TextInputAction.next,
                        decoration: const InputDecoration(
                          labelText: 'Region',
                          hintText: 'Example: Colima',
                          border: OutlineInputBorder(),
                        ),
                        validator: _requiredValidator,
                      ),
                      const SizedBox(height: 16),
                      DropdownButtonFormField<String>(
                        initialValue: _language,
                        decoration: const InputDecoration(
                          labelText: 'Sign Language',
                          border: OutlineInputBorder(),
                        ),
                        items: const [
                          DropdownMenuItem(
                            value: 'LSM',
                            child: Text('LSM'),
                          ),
                        ],
                        onChanged: (value) {
                          if (value == null) {
                            return;
                          }

                          setState(() {
                            _language = value;
                          });
                        },
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _uploaderController,
                        textInputAction: TextInputAction.done,
                        decoration: const InputDecoration(
                          labelText: 'Uploader Name',
                          hintText: 'Example: Luis',
                          border: OutlineInputBorder(),
                        ),
                        validator: _requiredValidator,
                      ),
                      const SizedBox(height: 24),
                      OutlinedButton.icon(
                        onPressed: _saving ? null : _pickVideo,
                        icon: const Icon(Icons.video_library_rounded),
                        label: const Text('Select Video from Gallery'),
                      ),
                      if (_selectedVideoName != null) ...[
                        const SizedBox(height: 12),
                        Card(
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Row(
                              children: [
                                const Icon(Icons.check_circle_rounded),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Text(
                                    _selectedVideoName!,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                      const SizedBox(height: 24),
                      FilledButton.icon(
                        onPressed: _saving ? null : _saveSign,
                        icon: _saving
                            ? const SizedBox(
                                width: 18,
                                height: 18,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                ),
                              )
                            : const Icon(Icons.cloud_upload_rounded),
                        label: Text(_saving ? 'Saving...' : 'Save Sign'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}