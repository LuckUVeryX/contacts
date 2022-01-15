import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../../core/domain/entities/contact.dart';
import '../../../../core/router/router.gr.dart';
import '../widgets/profile_picture_with_initials.dart';

class ContactInfoPage extends StatelessWidget {
  const ContactInfoPage({
    Key? key,
    required this.contact,
  }) : super(key: key);

  final Contact contact;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              AutoRouter.of(context).push(EditContactsRoute(contact: contact));
            },
            icon: const Icon(Icons.edit),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            const Spacer(flex: 2),
            ProfilePictureWithTextWidget(contact: contact, radius: 32.0),
            const SizedBox(height: 16.0),
            Text(
              contact.firstName + ' ' + contact.lastName,
              textAlign: TextAlign.center,
              style: textTheme.headline5?.copyWith(fontWeight: FontWeight.bold),
            ),
            const Spacer(),
            Card(
              child: ListTile(
                title: const Text('Phone Number'),
                subtitle: Text(contact.phoneNumber),
              ),
            ),
            Card(
              child: ListTile(
                title: const Text('Email Address'),
                subtitle: Text(contact.emailAddress),
              ),
            ),
            const Spacer(flex: 2),
          ],
        ),
      ),
    );
  }
}
