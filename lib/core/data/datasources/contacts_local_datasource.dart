import 'dart:convert';

import 'package:flutter/services.dart';

import '../../errors/exceptions.dart';
import '../models/raw_contacts_model.dart';

/// Parses local contacts.json to get initial contacts list
class ContactsLocalDataSource {
  static const String _kContactsJsonPath = 'assets/json/contacts.json';

  Future<String> _getContactsFromJson() async {
    try {
      return await rootBundle.loadString(_kContactsJsonPath);
    } on Exception {
      throw AssetNotFoundException;
    }
  }

  Future<RawContacts> fetchContacts() async {
    final jsonMap = jsonDecode(await _getContactsFromJson());
    return RawContacts.fromJson(jsonMap);
  }
}
