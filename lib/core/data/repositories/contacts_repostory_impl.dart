import 'dart:async';

import 'package:rxdart/rxdart.dart';

import '../../constants/app_constants.dart';
import '../../domain/entities/contact.dart';
import '../../domain/repositories/contacts_repository.dart';
import '../../errors/exceptions.dart';
import '../../observers/logger.dart';
import '../datasources/contacts_local_datasource.dart';

class ContactsRepository implements IContactsRepository {
  final log = getLogger('ContactsRepository');
  ContactsRepository(this._dataSource);

  final ContactsLocalDataSource _dataSource;

  @override
  Stream<List<Contact>> get contacts =>
      _contactsStreamController.asBroadcastStream();
  final _contactsStreamController =
      BehaviorSubject<List<Contact>>.seeded(const []);

  @override
  void deleteContact(int id) {
    log.d('deleteContact with id: $id');
    final contacts = [..._contactsStreamController.value];
    final contactIdx = contacts.indexWhere((element) => element.id == id);
    if (contactIdx == AppConstants.kNewContactId) {
      log.e('Invalid contactIdx: $contactIdx');
      throw ContactNotFoundException();
    } else {
      contacts.removeAt(contactIdx);
      _contactsStreamController.add(contacts);
      log.v('removed contact with id $id');
    }
  }

  @override
  void saveContact(Contact contact) {
    log.d('saveContact $contact');
    final contacts = [..._contactsStreamController.value];
    final contactIdx =
        contacts.indexWhere((element) => element.id == contact.id);
    if (contactIdx >= 0) {
      log.d('Editing ${contacts[contactIdx]} to $contact');
      contacts[contactIdx] = contact;
    } else if (contactIdx == AppConstants.kNewContactId) {
      log.d('Adding $contact');
      contacts.add(contact);
    }
    _contactsStreamController.add(contacts);
    log.d('saved contact $contact');
  }

  @override
  Future<void> init() async {
    log.d('initialising...');
    final rawContacts = await _dataSource.fetchContacts();
    _contactsStreamController.add(rawContacts.contactsList);
  }
}
