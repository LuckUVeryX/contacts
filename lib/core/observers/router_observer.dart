import 'package:auto_route/auto_route.dart';
import 'package:flutter/widgets.dart';

import 'logger.dart';

class RouterLoggingObserver extends AutoRouterObserver {
  final _log = getLogger('RouterLoggingObserver');

  @override
  void didPush(Route route, Route? previousRoute) {
    if (_isPage(route)) {
      _log.i('New route pushed: ${route.settings.name}');
    }
  }

  @override
  void didPop(Route route, Route? previousRoute) {
    if (_isPage(route)) {
      _log.i('Route popped: ${route.settings.name}');
    }
  }

  @override
  void didRemove(Route route, Route? previousRoute) {
    if (_isPage(route)) {
      _log.i('Route removed: ${route.settings.name}');
    }
  }

  @override
  void didReplace({Route? newRoute, Route? oldRoute}) {
    if (newRoute != null && _isPage(newRoute)) {
      _log.i(
          'Route replaced: [New] ${newRoute.settings.name} [Old] ${oldRoute?.settings.name}');
    }
  }

  @override
  void didInitTabRoute(TabPageRoute route, TabPageRoute? previousRoute) {
    _log.i('Tab route visited: ${route.name}');
  }

  @override
  void didChangeTabRoute(TabPageRoute route, TabPageRoute previousRoute) {
    _log.i('Tab route re-visited: ${route.name}');
  }

  bool _isPage(Route route) {
    return route.settings.runtimeType == MaterialPageX;
  }
}
