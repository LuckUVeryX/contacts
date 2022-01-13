import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/data/repositories/contacts_repostory_impl.dart';
import '../bloc/contacts_list_bloc.dart';

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
                        'Deleted Contact ${deletedContact.firstName} ${deletedContact.lastName}',
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

              return ListView.builder(
                itemCount: state.contacts.length,
                itemBuilder: (context, index) {
                  return Text(state.contacts[index].emailAddress);
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
