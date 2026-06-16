class SignVideo {
  const SignVideo({
    required this.id,
    required this.word,
    required this.wordKey,
    required this.videoUrl,
    required this.country,
    required this.region,
    required this.language,
    required this.uploader,
  });

  final String id;
  final String word;
  final String wordKey;
  final String videoUrl;
  final String country;
  final String region;
  final String language;
  final String uploader;

  factory SignVideo.fromJson(Map<String, dynamic> json) {
    final word = (json['word'] ?? '').toString();

    return SignVideo(
      id: (json['id'] ?? '').toString(),
      word: word,
      wordKey: (json['wordKey'] ?? json['word_key'] ?? word)
          .toString()
          .trim()
          .toLowerCase(),
      videoUrl: (json['videoUrl'] ?? json['video_url'] ?? '').toString(),
      country: (json['country'] ?? '').toString(),
      region: (json['region'] ?? '').toString(),
      language: (json['language'] ?? 'LSM').toString(),
      uploader: (json['uploader'] ?? '').toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'word': word,
      'wordKey': wordKey,
      'videoUrl': videoUrl,
      'country': country,
      'region': region,
      'language': language,
      'uploader': uploader,
    };
  }
}