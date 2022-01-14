import 'package:flutter/material.dart';

import '../../../../core/domain/entities/contact.dart';

class ContactInfoPage extends StatelessWidget {
  const ContactInfoPage({
    Key? key,
    required this.contact,
  }) : super(key: key);

  final Contact contact;

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text(contact.toString())));
  }
}
