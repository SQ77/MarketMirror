import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'pages/login_page.dart';

void main() async {
  await Supabase.initialize(
    url: "https://vzomabqwyswafxrjqzmy.supabase.co",
    anonKey:
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InZ6b21hYnF3eXN3YWZ4cmpxem15Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDkwMDQ0MjEsImV4cCI6MjA2NDU4MDQyMX0.i5AEzbXs4bvLSfgZ33aNGKHiNGQlPhribirym8Ahxc8",
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: LoginPage());
  }
}
