import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

final spProvider = Provider<SharedPreferences>((ref) => throw UnimplementedError());

Override overridesSp(SharedPreferences sp) => spProvider.overrideWith((ref) => sp);

enum SpKeys {
  auth
}