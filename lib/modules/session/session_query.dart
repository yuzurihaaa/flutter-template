import 'package:{{appName}}/modules/session/session_model.dart';
import 'package:{{appName}}/modules/session/session_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

final getUserAuthenticatedProvider =
    FutureProvider.autoDispose<bool>((ref) => ref.watch(sessionRepositoryProvider).isAuthenticated);

final getSessionProfileQueryListenerProvider =
    StreamProvider<User?>((ref) => ref.watch(sessionRepositoryProvider).currentUser);
