import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:{{appName}}/app.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'services/shared_pref_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final sp = await SharedPreferences.getInstance();
  runApp(ProviderScope(
    overrides: [overridesSp(sp)],
    child: const MyApp(),
  ));
}
