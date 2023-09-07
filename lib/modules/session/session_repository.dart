import 'dart:async';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:{{appName}}/modules/session/session_model.dart';
import 'package:{{appName}}/services/shared_pref_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class SessionRepository {
  Future<void> clearUserData();

  Future<void> saveSession();

  Stream<User?> get currentUser;

  Future<bool> get isAuthenticated;
}

final sessionRepositoryProvider = Provider<SessionRepository>((ref) => SessionRepositoryImpl(ref.watch(spProvider)));

class SessionRepositoryImpl implements SessionRepository {
  final SharedPreferences sp;

  SessionRepositoryImpl(this.sp);

  final StreamController<User?> _userProfile = StreamController.broadcast();

  @override
  Future<void> clearUserData() async {
    await sp.clear();
    _userProfile.add(null);
  }

  @override
  Future<void> saveSession() async {
    sp.setString(SpKeys.auth.name, '');
    _userProfile.add(User());
  }

  @override
  Future<bool> get isAuthenticated async {
    return await _userProfile.stream.last != null;
  }

  @override
  Stream<User?> get currentUser => _userProfile.stream;
}
