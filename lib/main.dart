import 'package:flutter/material.dart';
import 'package:sample_klip_profile_flutter_app/klip_profile_page.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(context) {
    return GetMaterialApp(
      home: KlipProfilePage(),
    );
  }
}
