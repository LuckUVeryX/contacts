import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

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

  @override
  List<Object> get props => [contacts];
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
}
