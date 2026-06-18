import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';

import '../models/sign_video.dart';

class SignRepository {
  const SignRepository._();

  static const _uploadedSignsFileName = 'uploaded_signs.json';
  static const _videosDirectoryName = 'sign_videos';

  static String createId() {
    return DateTime.now().microsecondsSinceEpoch.toString();
  }

  static String createWordKey(String word) {
    return word.trim().toLowerCase();
  }

  static Future<List<SignVideo>> loadUploadedSigns() async {
    try {
      final file = await _uploadedSignsFile();

      if (!await file.exists()) {
        return const <SignVideo>[];
      }

      final rawJson = await file.readAsString();

      if (rawJson.trim().isEmpty) {
        return const <SignVideo>[];
      }

      final decoded = jsonDecode(rawJson);

      if (decoded is! List) {
        return const <SignVideo>[];
      }

      return decoded
          .whereType<Map<String, dynamic>>()
          .map(SignVideo.fromJson)
          .toList();
    } catch (_) {
      return const <SignVideo>[];
    }
  }

  static Future<void> addUploadedSign(SignVideo sign) async {
    final signs = await loadUploadedSigns();
    final updatedSigns = [...signs, sign];

    await _saveUploadedSigns(updatedSigns);
  }

  static Future<String> copyVideoToAppStorage({
    required String sourcePath,
    required String signId,
  }) async {
    final sourceFile = File(sourcePath);

    if (!await sourceFile.exists()) {
      throw Exception('Selected video file was not found.');
    }

    final documentsDirectory = await getApplicationDocumentsDirectory();

    final videosDirectory = Directory(
      '${documentsDirectory.path}${Platform.pathSeparator}$_videosDirectoryName',
    );

    if (!await videosDirectory.exists()) {
      await videosDirectory.create(recursive: true);
    }

    final extension = _safeExtension(sourcePath);

    final destinationFile = File(
      '${videosDirectory.path}${Platform.pathSeparator}$signId$extension',
    );

    final copiedFile = await sourceFile.copy(destinationFile.path);

    return copiedFile.path;
  }

  static Future<File> _uploadedSignsFile() async {
    final documentsDirectory = await getApplicationDocumentsDirectory();

    return File(
      '${documentsDirectory.path}${Platform.pathSeparator}$_uploadedSignsFileName',
    );
  }

  static Future<void> _saveUploadedSigns(List<SignVideo> signs) async {
    final file = await _uploadedSignsFile();

    final encoded = const JsonEncoder.withIndent('  ').convert(
      signs.map((sign) => sign.toJson()).toList(),
    );

    await file.writeAsString(encoded);
  }

  static String _safeExtension(String sourcePath) {
    final normalizedPath = sourcePath.replaceAll('\\', '/');
    final fileName = normalizedPath.split('/').last;
    final dotIndex = fileName.lastIndexOf('.');

    if (dotIndex == -1) {
      return '.mp4';
    }

    final extension = fileName.substring(dotIndex).toLowerCase();

    if (extension.length < 2 || extension.length > 10) {
      return '.mp4';
    }

    return extension;
  }
}