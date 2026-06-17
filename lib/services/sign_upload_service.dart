import 'dart:io';

import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/sign_video.dart';
import 'supabase_service.dart';

class SignUploadService {
  static Future<void> uploadSign({
    required File videoFile,
    required String word,
    required String country,
    required String region,
    required String language,
    required String uploader,
  }) async {
    final fileName =
        '${DateTime.now().millisecondsSinceEpoch}.mp4';

    await SupabaseService.client.storage
        .from('videos')
        .upload(
          fileName,
          videoFile,
        );

    final videoUrl =
        SupabaseService.client.storage
            .from('videos')
            .getPublicUrl(fileName);

    await SupabaseService.client
        .from('signs')
        .insert({
      'word': word,
      'word_key': word.toLowerCase(),
      'country': country,
      'region': region,
      'language': language,
      'uploader': uploader,
      'video_url': videoUrl,
    });
  }

  static Future<List<SignVideo>> searchSigns(
    String query,
  ) async {
    final response =
        await SupabaseService.client
            .from('signs')
            .select()
            .ilike(
              'word_key',
              '%${query.toLowerCase()}%',
            );

    return response.map<SignVideo>((json) {
      return SignVideo(
        id: json['id'],
        word: json['word'],
        wordKey: json['word_key'],
        videoUrl: json['video_url'],
        country: json['country'],
        region: json['region'],
        language: json['language'],
        uploader: json['uploader'],
      );
    }).toList();
  }
}