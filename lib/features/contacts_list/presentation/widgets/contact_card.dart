import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../../core/domain/entities/contact.dart';
import '../../../../core/router/router.gr.dart';
import 'profile_picture_with_initials.dart';

class ContactCard extends StatelessWidget {
  const ContactCard({
    Key? key,
    required this.contact,
    required this.onDismissed,
    required this.confirmDismiss,
  }) : super(key: key);

  final Contact contact;
  final void Function(DismissDirection direction)? onDismissed;
  final Future<bool?> Function(DismissDirection direction)? confirmDismiss;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    return Dismissible(
      key: Key(contact.id.toString()),
      direction: DismissDirection.endToStart,
      confirmDismiss: confirmDismiss,
      onDismissed: onDismissed,
      background: Container(
        color: colorScheme.primary,
        child: Row(
          children: const [
            Spacer(),
            Icon(Icons.delete, color: Colors.white),
            SizedBox(width: 32.0),
          ],
        ),
      ),
      child: ExpansionTile(
        title: Text(
          contact.firstName + ' ' + contact.lastName,
          style: textTheme.bodyText1,
        ),
        subtitle: Text(
          contact.phoneNumber,
          style: textTheme.caption,
        ),
        leading: ProfilePictureWithTextWidget(
          radius: 24.0,
          initials: contact.initials,
          backgroundColor: contact.profileColor,
        ),
        children: [
          ListTile(
            title: Text(
              contact.emailAddress,
              style: textTheme.caption,
            ),
            trailing: IconButton(
              onPressed: () {
                AutoRouter.of(context).push(
                  EditContactsRoute(contact: contact),
                );
              },
              icon: const Icon(Icons.edit, size: 20.0),
            ),
          ),
        ],
      ),
    );
  }
}
