import 'package:flutter/material.dart';

import '../../../../core/domain/entities/contact.dart';

class EditContactsPage extends StatelessWidget {
  const EditContactsPage({Key? key, this.contact}) : super(key: key);

  final Contact? contact;

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text(contact.toString())));
  }
}
