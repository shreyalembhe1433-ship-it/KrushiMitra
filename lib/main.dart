import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:krushimitra/Auth/AuthWrapper.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: 'https://dofrscsilsggxwlaizdg.supabase.co',
    anonKey: 'sb_publishable_Zkzmxjd3sR7vvaIFx6rxfw_xtOSwS5i',
  );
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const KrushiMitraApp());
}

class KrushiMitraApp extends StatelessWidget {
  const KrushiMitraApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'KrushiMitra',
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: const Color(0xFF087F5B),
        scaffoldBackgroundColor: const Color(0xFFF8FAF9),
      ),
      home: const Authwrapper(),
    );
  }
}