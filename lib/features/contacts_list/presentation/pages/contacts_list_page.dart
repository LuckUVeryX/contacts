import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grouped_list/grouped_list.dart';

import '../../../../core/data/repositories/contacts_repostory_impl.dart';
import '../../../../core/domain/entities/contact.dart';
import '../../../../core/router/router.gr.dart';
import '../bloc/contacts_list_bloc.dart';
import '../widgets/contact_card.dart';

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
                if (state.status == ContactsListStatus.loading ||
                    state.status == ContactsListStatus.initial) {
                  return const Center(
                    child: CircularProgressIndicator.adaptive(),
                  );
                } else if (state.status == ContactsListStatus.failure) {
                  return const Center(
                    child: Text('Uh oh, something has went horribly wrong'),
                  );
                } else {
                  return const _EmptyContactsView();
                }
              }
              return _ContactsListView(state: state);
            },
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            AutoRouter.of(context).push(EditContactsRoute());
          },
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

class _ContactsListView extends StatefulWidget {
  const _ContactsListView({
    Key? key,
    required this.state,
  }) : super(key: key);
  final ContactsListState state;

  @override
  State<_ContactsListView> createState() => _ContactsListViewState();
}

class _ContactsListViewState extends State<_ContactsListView> {
  final ScrollController _scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Scrollbar(
      controller: _scrollController,
      interactive: true,
      child: GroupedListView(
        controller: _scrollController,
        elements: widget.state.contacts,
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
          return ContactCard(
            contact: contact,
            onDismissed: (_) {
              context
                  .read<ContactsListBloc>()
                  .add(ContactsListContactDeleted(contact));
            },
            confirmDismiss: (_) async {
              return await showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text('Delete this contact?'),
                    content: RichText(
                      text: TextSpan(
                        style: textTheme.subtitle1,
                        children: [
                          const TextSpan(
                              text: 'You are about to delete the contact '),
                          TextSpan(
                            text: contact.firstName + ' ' + contact.lastName,
                            style: textTheme.subtitle1?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const TextSpan(text: '.'),
                        ],
                      ),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(false),
                        child: const Text('CANCEL'),
                      ),
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(true),
                        child: const Text('DELETE'),
                      ),
                    ],
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}

class _EmptyContactsView extends StatelessWidget {
  const _EmptyContactsView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const Center(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'You have no contacts... Add one by tapping the add button below!',
              textAlign: TextAlign.center,
            ),
          ),
        ),
        Positioned(
          bottom: 100,
          right: 4,
          child: Icon(
            Icons.arrow_downward,
            size: 80,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
      ],
    );
  }
}
