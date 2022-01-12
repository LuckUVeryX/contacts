// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

import 'package:auto_route/auto_route.dart' as _i4;
import 'package:flutter/material.dart' as _i5;

import '../../features/contacts_list/presentation/pages/contacts_list_page.dart'
    as _i1;
import '../../features/create_contacts/presentation/pages/create_contacts_page.dart'
    as _i3;
import '../../features/edit_contacts/presentation/pages/edit_contacts_page.dart'
    as _i2;

class AppRouter extends _i4.RootStackRouter {
  AppRouter([_i5.GlobalKey<_i5.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i4.PageFactory> pagesMap = {
    ContactsListRoute.name: (routeData) {
      return _i4.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i1.ContactsListPage());
    },
    EditContactsRoute.name: (routeData) {
      return _i4.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i2.EditContactsPage());
    },
    CreateContactsRoute.name: (routeData) {
      return _i4.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i3.CreateContactsPage());
    }
  };

  @override
  List<_i4.RouteConfig> get routes => [
        _i4.RouteConfig('/#redirect',
            path: '/', redirectTo: '/contacts', fullMatch: true),
        _i4.RouteConfig(ContactsListRoute.name, path: '/contacts'),
        _i4.RouteConfig(EditContactsRoute.name, path: '/edit'),
        _i4.RouteConfig(CreateContactsRoute.name, path: '/create')
      ];
}

/// generated route for
/// [_i1.ContactsListPage]
class ContactsListRoute extends _i4.PageRouteInfo<void> {
  const ContactsListRoute() : super(ContactsListRoute.name, path: '/contacts');

  static const String name = 'ContactsListRoute';
}

/// generated route for
/// [_i2.EditContactsPage]
class EditContactsRoute extends _i4.PageRouteInfo<void> {
  const EditContactsRoute() : super(EditContactsRoute.name, path: '/edit');

  static const String name = 'EditContactsRoute';
}

/// generated route for
/// [_i3.CreateContactsPage]
class CreateContactsRoute extends _i4.PageRouteInfo<void> {
  const CreateContactsRoute()
      : super(CreateContactsRoute.name, path: '/create');

  static const String name = 'CreateContactsRoute';
}
