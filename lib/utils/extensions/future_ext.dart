import 'package:{{appName}}/utils/error.dart';

extension FutureExt<T> on Future<T> {
  Future<(AppError?, T?)> resolveFuture() => then<(AppError?, T?)>((value) => (null, value))
      .onError((error, stackTrace) => (AppError(error, stackTrace: stackTrace), null));
}
