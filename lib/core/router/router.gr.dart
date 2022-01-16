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
import '../../features/edit_contact/presentation/pages/edit_contact_page.dart'
    as _i2;
import '../domain/entities/contact.dart' as _i5;

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
      final args = routeData.argsAs<EditContactsRouteArgs>(
          orElse: () => const EditContactsRouteArgs());
      return _i3.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i2.EditContactsPage(key: args.key, contact: args.contact));
    }
  };

  @override
  List<_i3.RouteConfig> get routes => [
        _i3.RouteConfig(ContactsListRoute.name, path: '/'),
        _i3.RouteConfig(EditContactsRoute.name, path: '/edit-contacts-page')
      ];
}

/// generated route for
/// [_i1.ContactsListPage]
class ContactsListRoute extends _i3.PageRouteInfo<void> {
  const ContactsListRoute() : super(ContactsListRoute.name, path: '/');

  static const String name = 'ContactsListRoute';
}

/// generated route for
/// [_i2.EditContactsPage]
class EditContactsRoute extends _i3.PageRouteInfo<EditContactsRouteArgs> {
  EditContactsRoute({_i4.Key? key, _i5.Contact? contact})
      : super(EditContactsRoute.name,
            path: '/edit-contacts-page',
            args: EditContactsRouteArgs(key: key, contact: contact));

  static const String name = 'EditContactsRoute';
}

class EditContactsRouteArgs {
  const EditContactsRouteArgs({this.key, this.contact});

  final _i4.Key? key;

  final _i5.Contact? contact;

  @override
  String toString() {
    return 'EditContactsRouteArgs{key: $key, contact: $contact}';
  }
}
