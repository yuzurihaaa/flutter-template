import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:{{appName}}/pages/home_page.dart';
import 'package:{{appName}}/pages/signin_page.dart';

final routerProvider = Provider<GoRouter>((ref) => _router);

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorAKey = GlobalKey<NavigatorState>();
final _shellNavigatorBKey = GlobalKey<NavigatorState>();

final _router = GoRouter(
  initialLocation: Routes.home.path,
  navigatorKey: _rootNavigatorKey,
  debugLogDiagnostics: true,
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) => HomePage(navigationShell: navigationShell),
      branches: [
        StatefulShellBranch(
          navigatorKey: _shellNavigatorAKey,
          routes: [
            GoRoute(
              parentNavigatorKey: _shellNavigatorAKey,
              path: Routes.home.path,
              pageBuilder: (context, state) => const NoTransitionPage(
                child: RootScreen(label: 'A', detailsPath: '/a/details'),
              ),
            ),
            GoRoute(
              parentNavigatorKey: _shellNavigatorAKey,
              path: '/a/details',
              pageBuilder: (context, state) => const NoTransitionPage(
                child: DetailsScreen(label: 'A'),
              ),
            ),
          ],
        ),
        StatefulShellBranch(
          navigatorKey: _shellNavigatorBKey,
          routes: [
            GoRoute(
              parentNavigatorKey: _shellNavigatorBKey,
              path: '/b',
              pageBuilder: (context, state) => NoTransitionPage(
                child: RootScreen(label: 'B', detailsName: Routes.signIn.name),
              ),
            ),
          ],
        ),
      ],
    ),
    _rootRoute(
      route: Routes.signIn,
      builder: (context, state) => const SignInPage(),
    ),
  ],
);

GoRoute _rootRoute({
  required Routes route,
  GoRouterWidgetBuilder? builder,
  GoRouterPageBuilder? pageBuilder,
  GoRouterRedirect? redirect,
  List<RouteBase> routes = const <RouteBase>[],
}) =>
    GoRoute(
      path: route.path,
      routes: routes,
      builder: builder,
      name: route.name,
      pageBuilder: pageBuilder,
      redirect: redirect,
      parentNavigatorKey: _rootNavigatorKey,
    );

enum Routes implements Comparable<Routes> {
  home(path: "/", name: "home"),
  signIn(path: "/sign-in", name: "sign-in");

  const Routes({
    required String path,
    required String name,
  })  : _path = path,
        _name = name;

  String get path => _path;

  String get name => _name;

  final String _path;
  final String _name;

  @override
  int compareTo(Routes other) => path.length - other.path.length;
}
