import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grouped_list/grouped_list.dart';

import '../../../../core/data/repositories/contacts_repostory_impl.dart';
import '../../../../core/domain/entities/contact.dart';
import '../bloc/contacts_list_bloc.dart';
import '../widgets/contacts_tile.dart';

class ContactsListPage extends StatelessWidget {
  const ContactsListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                  _showErrorSnackBar(context);
                }
              },
            ),
            BlocListener<ContactsListBloc, ContactsListState>(
              listenWhen: (previous, current) =>
                  previous.lastDeletedContact != current.lastDeletedContact &&
                  current.lastDeletedContact != null,
              listener: (context, state) {
                final deletedContact = state.lastDeletedContact!;
                _deleteContactSnackbar(context, deletedContact);
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
              return _ContactsListView(state: state);
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

  void _showErrorSnackBar(BuildContext context) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        const SnackBar(content: Text('Failed to fetch contacts')),
      );
  }

  void _deleteContactSnackbar(BuildContext context, Contact deletedContact) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
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
  }
}

class _ContactsListView extends StatelessWidget {
  const _ContactsListView({
    Key? key,
    required this.state,
  }) : super(key: key);
  final ContactsListState state;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

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
          color: Colors.grey[700],
          padding: const EdgeInsets.symmetric(
            horizontal: 16.0,
            vertical: 4.0,
          ),
          child: Text(
            value,
            style: textTheme.bodyText1?.copyWith(
              color: colorScheme.onSurface,
            ),
          ),
        );
      },
      itemBuilder: (context, Contact contact) {
        return ContactsTile(
          contact: contact,
          onDismissed: (_) {
            context
                .read<ContactsListBloc>()
                .add(ContactsListContactDeleted(contact));
          },
        );
      },
    );
  }
}
