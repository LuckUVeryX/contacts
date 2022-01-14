import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/contact.dart';
import '../../theme/palette.dart';

part 'raw_contacts_model.g.dart';

@JsonSerializable()
class RawContacts extends Equatable {
  final List<RawContact> contacts;

  const RawContacts({
    required this.contacts,
  });

  factory RawContacts.fromJson(Map<String, dynamic> json) =>
      _$RawContactsFromJson(json);
  Map<String, dynamic> toJson() => _$RawContactsToJson(this);

  List<Contact> get contactsList {
    final List<Contact> ls = [];

    for (var rawContact in contacts) {
      final nameSplit = rawContact.name.split(' ');
      ls.add(Contact(
        id: rawContact.id,
        firstName: nameSplit[0],
        lastName: nameSplit[1],
        phoneNumber: rawContact.phone,
        emailAddress: rawContact.email,
        // Generate random color for each profile
        profileColor: PurpleShades.randomColor,
      ));
    }
    return ls;
  }

  @override
  List<Object> get props => [contacts];

  @override
  String toString() => 'RawContacts(contacts: $contacts)';
}

@JsonSerializable()
class RawContact extends Equatable {
  final int id;
  final String name;
  final String email;
  final String phone;

  const RawContact({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
  });

  factory RawContact.fromJson(Map<String, dynamic> json) =>
      _$RawContactFromJson(json);
  Map<String, dynamic> toJson() => _$RawContactToJson(this);

  @override
  List<Object> get props => [id, name, email, phone];

  @override
  String toString() {
    return 'RawContact(id: $id, name: $name, email: $email, phone: $phone)';
  }
}
