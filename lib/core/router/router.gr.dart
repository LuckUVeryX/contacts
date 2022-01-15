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

import '../../features/contact_info/presentation/pages/contact_info_page.dart'
    as _i2;
import '../../features/contacts_list/presentation/bloc/contacts_list_bloc.dart'
    as _i6;
import '../../features/contacts_list/presentation/pages/contacts_list_page.dart'
    as _i1;
import '../../features/edit_contact/presentation/pages/edit_contact_page.dart'
    as _i3;
import '../domain/entities/contact.dart' as _i7;

class AppRouter extends _i4.RootStackRouter {
  AppRouter([_i5.GlobalKey<_i5.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i4.PageFactory> pagesMap = {
    ContactsListRoute.name: (routeData) {
      return _i4.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i1.ContactsListPage());
    },
    ContactInfoRoute.name: (routeData) {
      final args = routeData.argsAs<ContactInfoRouteArgs>();
      return _i4.MaterialPageX<dynamic>(
          routeData: routeData,
          child:
              _i2.ContactInfoPage(key: args.key, id: args.id, bloc: args.bloc));
    },
    EditContactsRoute.name: (routeData) {
      final args = routeData.argsAs<EditContactsRouteArgs>(
          orElse: () => const EditContactsRouteArgs());
      return _i4.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i3.EditContactsPage(key: args.key, contact: args.contact));
    }
  };

  @override
  List<_i4.RouteConfig> get routes => [
        _i4.RouteConfig(ContactsListRoute.name, path: '/'),
        _i4.RouteConfig(ContactInfoRoute.name, path: '/contact-info-page'),
        _i4.RouteConfig(EditContactsRoute.name, path: '/edit-contacts-page')
      ];
}

/// generated route for
/// [_i1.ContactsListPage]
class ContactsListRoute extends _i4.PageRouteInfo<void> {
  const ContactsListRoute() : super(ContactsListRoute.name, path: '/');

  static const String name = 'ContactsListRoute';
}

/// generated route for
/// [_i2.ContactInfoPage]
class ContactInfoRoute extends _i4.PageRouteInfo<ContactInfoRouteArgs> {
  ContactInfoRoute(
      {_i5.Key? key, required int id, required _i6.ContactsListBloc bloc})
      : super(ContactInfoRoute.name,
            path: '/contact-info-page',
            args: ContactInfoRouteArgs(key: key, id: id, bloc: bloc));

  static const String name = 'ContactInfoRoute';
}

class ContactInfoRouteArgs {
  const ContactInfoRouteArgs({this.key, required this.id, required this.bloc});

  final _i5.Key? key;

  final int id;

  final _i6.ContactsListBloc bloc;

  @override
  String toString() {
    return 'ContactInfoRouteArgs{key: $key, id: $id, bloc: $bloc}';
  }
}

/// generated route for
/// [_i3.EditContactsPage]
class EditContactsRoute extends _i4.PageRouteInfo<EditContactsRouteArgs> {
  EditContactsRoute({_i5.Key? key, _i7.Contact? contact})
      : super(EditContactsRoute.name,
            path: '/edit-contacts-page',
            args: EditContactsRouteArgs(key: key, contact: contact));

  static const String name = 'EditContactsRoute';
}

class EditContactsRouteArgs {
  const EditContactsRouteArgs({this.key, this.contact});

  final _i5.Key? key;

  final _i7.Contact? contact;

  @override
  String toString() {
    return 'EditContactsRouteArgs{key: $key, contact: $contact}';
  }
}
