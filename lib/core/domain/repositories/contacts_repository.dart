import '../../errors/exceptions.dart';
import '../entities/contact.dart';

abstract class IContactsRepository {
  Future<void> init();

  /// Provides a [Stream] of all contacts
  Stream<List<Contact>> get contacts;

  /// Adds a new [Contact].
  ///
  /// If a [Contact] with the same id already exists, then it will replace it.
  void saveContact(Contact contact);

  /// Deletes the contact with the given id.
  ///
  /// If no [Contact] with the given id exists, throw a [ContactNotFoundException].
  void deleteContact(int id);
}
