import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseService {
  static const supabaseUrl =
      'https://ytfwhtmcmsryyvrdtfrf.supabase.co';

  static const supabaseAnonKey =
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Inl0ZndodG1jbXNyeXl2cmR0ZnJmIiwicm9sZSI6ImFub24iLCJpYXQiOjE3ODE2MTk2MjYsImV4cCI6MjA5NzE5NTYyNn0.sRJhUmCTb_pFDmIHKxDJxBdkvcuQ5r_I8yeX4uYp9K0';

  static Future<void> initialize() async {
    await Supabase.initialize(
      url: supabaseUrl,
      anonKey: supabaseAnonKey,
    );
  }

  static SupabaseClient get client =>
      Supabase.instance.client;
}