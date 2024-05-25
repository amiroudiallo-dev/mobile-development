import 'dart:convert';

import 'package:coincap/models/AppConfig.dart';
import 'package:coincap/pages/HomePage.dart';
import 'package:coincap/services/HttpService.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await loadConfig();
  registerHttpService();
  await GetIt.instance.get<HttpService>().get("/coins/bitcoin");
  runApp(const MyApp());
}

Future<void> loadConfig() async {
  String configContent = await rootBundle.loadString(
      "/Users/user/mobile-development/flutter-learning/coincap/assets/config/main.json");
  Map configData = jsonDecode(configContent);
  GetIt.instance.registerSingleton<AppConfig>(
    AppConfig(COIN_API_BASE_URL: configData['COIN_API_BASE_URL']),
  );
}

void registerHttpService() {
    GetIt.instance.registerSingleton<HttpService>(HttpService());
  }

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CoinCap',
      theme: ThemeData(
          primarySwatch: Colors.blue,
          useMaterial3: true,
          scaffoldBackgroundColor: Colors.amberAccent),
      home: Homepage(),
    );
  }
}
