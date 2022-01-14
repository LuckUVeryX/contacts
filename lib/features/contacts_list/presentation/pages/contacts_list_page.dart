import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grouped_list/grouped_list.dart';

import '../../../../core/data/repositories/contacts_repostory_impl.dart';
import '../../../../core/domain/entities/contact.dart';
import '../bloc/contacts_list_bloc.dart';

class ContactsListPage extends StatelessWidget {
  const ContactsListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    return BlocProvider(
      create: (context) => ContactsListBloc(context.read<ContactsRepository>())
        ..add(ContactsListSubscriptionRequested()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Contacts'),
        ),
        body: MultiBlocListener(
          listeners: [
            BlocListener<ContactsListBloc, ContactsListState>(
              listenWhen: (prev, curr) => prev.status != curr.status,
              listener: (context, state) {
                if (state.status == ContactsListStatus.failure) {
                  ScaffoldMessenger.of(context)
                    ..hideCurrentSnackBar()
                    ..showSnackBar(
                      // TODO: Refactor Snackbars
                      const SnackBar(content: Text('Failed to fetch contacts')),
                    );
                }
              },
            ),
            BlocListener<ContactsListBloc, ContactsListState>(
              listenWhen: (previous, current) =>
                  previous.lastDeletedContact != current.lastDeletedContact &&
                  current.lastDeletedContact != null,
              listener: (context, state) {
                final deletedContact = state.lastDeletedContact!;
                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(
                    // TODO: Refactor Snackbars
                    SnackBar(
                      content: Text(
                        'Deleted ${deletedContact.firstName} ${deletedContact.lastName}',
                      ),
                      action: SnackBarAction(
                        label: 'Undo',
                        onPressed: () {
                          ScaffoldMessenger.of(context).hideCurrentSnackBar();
                          context
                              .read<ContactsListBloc>()
                              .add(ContactsListUndoDeletionRequested());
                        },
                      ),
                    ),
                  );
              },
            )
          ],
          child: BlocBuilder<ContactsListBloc, ContactsListState>(
            builder: (context, state) {
              if (state.contacts.isEmpty) {
                if (state.status == ContactsListStatus.loading) {
                  return const Center(
                    child: CircularProgressIndicator.adaptive(),
                  );
                } else if (state.status != ContactsListStatus.success) {
                  return const Center(
                    child: Text('Uh oh, something has went horribly wrong'),
                  );
                } else {
                  // TODO: Add arrow to point to floating action button.
                  return const Center(
                    child: Text(
                        'You have no contacts! Add one by tapping the add button'),
                  );
                }
              }
              return GroupedListView(
                elements: state.contacts,
                groupBy: (Contact element) => element.lastName[0],
                itemComparator: (Contact a, Contact b) {
                  // Orders by lastName then by firstName
                  return a.lastName.compareTo(b.lastName) * 10 +
                      a.firstName.compareTo(b.firstName);
                },
                groupSeparatorBuilder: (String value) {
                  return Container(
                    color: Colors.grey[50],
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    margin: const EdgeInsets.symmetric(vertical: 4.0),
                    child: Text(
                      value,
                      style: textTheme.bodyText1?.copyWith(
                        color: colorScheme.onSurface,
                      ),
                    ),
                  );
                },
                itemBuilder: (context, Contact contact) {
                  return Dismissible(
                    key: Key(contact.id.toString()),
                    onDismissed: (_) => context
                        .read<ContactsListBloc>()
                        .add(ContactsListContactDeleted(contact)),
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
                          const CircleAvatar(radius: 24.0),
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
                },
              );
            },
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
