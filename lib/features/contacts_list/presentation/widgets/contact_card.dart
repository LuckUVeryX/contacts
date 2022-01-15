import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/domain/entities/contact.dart';
import '../../../../core/router/router.gr.dart';
import '../bloc/contacts_list_bloc.dart';

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
    return Card(
      child: InkWell(
        onTap: () {
          AutoRouter.of(context).push(ContactInfoRoute(
              id: contact.id, bloc: context.read<ContactsListBloc>()));
        },
        child: Dismissible(
          key: Key(contact.id.toString()),
          direction: DismissDirection.endToStart,
          confirmDismiss: confirmDismiss,
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
                CircleAvatar(
                  radius: 24.0,
                  backgroundColor: contact.profileColor,
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
                IconButton(
                  onPressed: () {
                    AutoRouter.of(context).push(
                      EditContactsRoute(contact: contact),
                    );
                  },
                  icon: const Icon(Icons.more_vert),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
