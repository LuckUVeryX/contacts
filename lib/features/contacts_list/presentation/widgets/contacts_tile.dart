import 'package:flutter/material.dart';

import '../../../../core/domain/entities/contact.dart';

class ContactsTile extends StatelessWidget {
  const ContactsTile({
    Key? key,
    required this.contact,
    required this.onDismissed,
  }) : super(key: key);

  final Contact contact;
  final void Function(DismissDirection)? onDismissed;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    return Dismissible(
      key: Key(contact.id.toString()),
      onDismissed: onDismissed,
      background: Container(
        color: colorScheme.error,
        child: Row(
          children: const [
            Spacer(),
            Icon(Icons.delete, color: Colors.white),
            SizedBox(width: 32.0),
          ],
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16.0,
          vertical: 8.0,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 48.0,
              width: 48.0,
              decoration: BoxDecoration(
                color: contact.profileColor,
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
            const SizedBox(width: 32.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    contact.firstName + ' ' + contact.lastName,
                    style: textTheme.bodyText1,
                  ),
                  Text(
                    contact.phoneNumber,
                    style: textTheme.caption,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
