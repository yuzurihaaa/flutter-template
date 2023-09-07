import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:{{appName}}/modules/session/session_query.dart';
import 'package:{{appName}}/pages/routes.dart';
import 'package:{{appName}}/utils/hooks.dart';

class SessionGuard extends HookConsumerWidget {
  final Widget child;

  const SessionGuard({super.key, required this.child});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final firstLaunch = useRef(true);
    final profileListener = ref.watch(getSessionProfileQueryListenerProvider);
    final isValidSession = ref.watch(getUserAuthenticatedProvider);
    useAsyncEffect(() async {
      if (firstLaunch.value) {
        firstLaunch.value = false;
        return;
      }
      final router = ref.read(routerProvider);
      final lastMatch = router.routerDelegate.currentConfiguration.last;
      final matchList = lastMatch is ImperativeRouteMatch ? lastMatch.matches : router.routerDelegate.currentConfiguration;
      final String location = matchList.uri.toString();

      if (location == Routes.signIn.path && isValidSession.value == true) {
        router.go(Routes.home.name);
        return;
      }

      if (isValidSession.value == false) {
        router.go(Routes.signIn.name);
      }
    }, [firstLaunch.value, profileListener, isValidSession]);
    return child;
  }
}
