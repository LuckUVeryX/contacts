// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'raw_contacts_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RawContacts _$RawContactsFromJson(Map<String, dynamic> json) => RawContacts(
      contacts: (json['contacts'] as List<dynamic>)
          .map((e) => RawContact.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$RawContactsToJson(RawContacts instance) =>
    <String, dynamic>{
      'contacts': instance.contacts,
    };

RawContact _$RawContactFromJson(Map<String, dynamic> json) => RawContact(
      id: json['id'] as int,
      name: json['name'] as String,
      email: json['email'] as String,
      phone: json['phone'] as String,
    );

Map<String, dynamic> _$RawContactToJson(RawContact instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'email': instance.email,
      'phone': instance.phone,
    };
