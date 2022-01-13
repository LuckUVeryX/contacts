// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

import 'package:auto_route/auto_route.dart' as _i3;
import 'package:flutter/material.dart' as _i4;

import '../../features/contacts_list/presentation/pages/contacts_list_page.dart'
    as _i1;
import '../../features/edit_contacts/presentation/pages/edit_contacts_page.dart'
    as _i2;

class AppRouter extends _i3.RootStackRouter {
  AppRouter([_i4.GlobalKey<_i4.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i3.PageFactory> pagesMap = {
    ContactsListRoute.name: (routeData) {
      return _i3.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i1.ContactsListPage());
    },
    EditContactsRoute.name: (routeData) {
      return _i3.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i2.EditContactsPage());
    }
  };

  @override
  List<_i3.RouteConfig> get routes => [
        _i3.RouteConfig('/#redirect',
            path: '/', redirectTo: '/contacts', fullMatch: true),
        _i3.RouteConfig(ContactsListRoute.name, path: '/contacts'),
        _i3.RouteConfig(EditContactsRoute.name, path: '/edit')
      ];
}

/// generated route for
/// [_i1.ContactsListPage]
class ContactsListRoute extends _i3.PageRouteInfo<void> {
  const ContactsListRoute() : super(ContactsListRoute.name, path: '/contacts');

  static const String name = 'ContactsListRoute';
}

/// generated route for
/// [_i2.EditContactsPage]
class EditContactsRoute extends _i3.PageRouteInfo<void> {
  const EditContactsRoute() : super(EditContactsRoute.name, path: '/edit');

  static const String name = 'EditContactsRoute';
}
