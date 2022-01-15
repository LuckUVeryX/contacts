part of 'contacts_list_bloc.dart';

enum ContactsListStatus { initial, loading, success, failure }

/// Keeps track of list of `contacts`, the `lastDeletedContact`, and the `status` of the contacts list page.
class ContactsListState extends Equatable {
  const ContactsListState({
    this.status = ContactsListStatus.initial,
    this.contacts = const [],
    this.lastDeletedContact,
  });

  final ContactsListStatus status;
  final List<Contact> contacts;
  final Contact? lastDeletedContact;

  Contact fromContactId(int id) {
    return contacts.firstWhere((element) => element.id == id);
  }

  @override
  List<Object?> get props => [status, contacts, lastDeletedContact];

  ContactsListState copyWith({
    ContactsListStatus? status,
    List<Contact>? contacts,
    Contact? Function()? lastDeletedContact,
  }) {
    return ContactsListState(
      status: status ?? this.status,
      contacts: contacts ?? this.contacts,
      lastDeletedContact: lastDeletedContact != null
          ? lastDeletedContact()
          : this.lastDeletedContact,
    );
  }
}
