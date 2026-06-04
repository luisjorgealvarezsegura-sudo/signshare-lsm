import 'package:flutter/material.dart';

import '../../features/about/about_screen.dart';
import '../../features/home/home_screen.dart';
import '../../features/recognition/recognition_screen.dart';
import '../../features/search/search_screen.dart';
import '../../features/upload/upload_screen.dart';

class AppRoutes {
  static const home = '/';
  static const search = '/search';
  static const upload = '/upload';
  static const recognition = '/recognition';
  static const about = '/about';

  static Map<String, WidgetBuilder> get routes {
    return {
      home: (_) => const HomeScreen(),
      search: (_) => const SearchScreen(),
      upload: (_) => const UploadScreen(),
      recognition: (_) => const RecognitionScreen(),
      about: (_) => const AboutScreen(),
    };
  }
}
