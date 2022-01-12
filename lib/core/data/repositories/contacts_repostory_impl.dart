import 'dart:async';

import 'package:rxdart/rxdart.dart';

import '../../domain/entities/contact.dart';
import '../../domain/repositories/contacts_repository.dart';
import '../../errors/exceptions.dart';
import '../datasources/contacts_local_datasource.dart';

class ContactsRepository implements IContactsRepository {
  ContactsRepository(this._dataSource);

  final ContactsLocalDataSource _dataSource;

  @override
  Stream<List<Contact>> get contacts =>
      _contactsStreamController.asBroadcastStream();
  final _contactsStreamController =
      BehaviorSubject<List<Contact>>.seeded(const []);

  @override
  void deleteContact(int id) {
    final contacts = [..._contactsStreamController.value];
    final contactIdx = contacts.indexWhere((element) => element.id == id);
    if (contactIdx == -1) {
      throw ContactNotFoundException();
    } else {
      contacts.removeAt(contactIdx);
      _contactsStreamController.add(contacts);
    }
  }

  @override
  void saveContact(int id, Contact contact) {
    final contacts = [..._contactsStreamController.value];
    final contactIdx = contacts.indexWhere((element) => element.id == id);
    if (contactIdx >= 0) {
      contacts[contactIdx] = contact;
    } else {
      contacts.add(contact);
    }
  }

  Future<void> init() async {
    final rawContacts = await _dataSource.fetchContacts();
    _contactsStreamController.add(rawContacts.contactsList);
  }
}
