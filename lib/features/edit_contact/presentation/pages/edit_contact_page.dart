import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/data/repositories/contacts_repostory_impl.dart';
import '../../../../core/domain/entities/contact.dart';
import '../../../../core/theme/palette.dart';
import '../../../contact_info/presentation/widgets/profile_picture_with_initials.dart';
import '../bloc/edit_contact_bloc.dart';

class EditContactsPage extends StatelessWidget {
  const EditContactsPage({Key? key, this.contact}) : super(key: key);

  final Contact? contact;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return BlocProvider(
      create: (context) => EditContactBloc(
        initialContact: contact,
        repository: context.read<ContactsRepository>(),
      ),
      child: BlocListener<EditContactBloc, EditContactState>(
        listenWhen: (prev, curr) {
          return prev.status != curr.status &&
              curr.status == EditContactStatus.done;
        },
        listener: (context, _) {
          Navigator.of(context).pop();
        },
        child: Scaffold(
          appBar: AppBar(
            title: BlocBuilder<EditContactBloc, EditContactState>(
              buildWhen: (prev, curr) => prev.isNewContact != curr.isNewContact,
              builder: (context, state) {
                return Text(
                  state.isNewContact ? 'New Contact' : 'Edit Contact',
                );
              },
            ),
            actions: [
              Builder(builder: (context) {
                // wrap with builder to provide context with Bloc
                return IconButton(
                  onPressed: () {
                    context.read<EditContactBloc>().add(EditContactSubmitted());
                  },
                  icon: const Icon(Icons.done),
                );
              }),
            ],
          ),
          body: Column(
            children: [
              const Spacer(flex: 2),
              BlocBuilder<EditContactBloc, EditContactState>(
                builder: (context, state) {
                  return ProfilePictureWithTextWidget(
                    radius: 48.0,
                    initials: state.initials,
                    textStyle: textTheme.headline5
                        ?.copyWith(fontWeight: FontWeight.bold),
                    backgroundColor: state.initialContact?.profileColor ??
                        PurpleShades.randomColor,
                  );
                },
              ),
              const Spacer(flex: 2),
              Card(
                child: Column(
                  children: [
                    BlocBuilder<EditContactBloc, EditContactState>(
                      buildWhen: (prev, curr) =>
                          prev.firstName != curr.firstName,
                      builder: (context, state) {
                        return TextFormField(
                          initialValue: state.initialContact?.firstName,
                          textInputAction: TextInputAction.next,
                          textCapitalization: TextCapitalization.words,
                          decoration: const InputDecoration(
                            labelText: 'First Name',
                            errorText: null,
                          ),
                          onChanged: (value) {
                            context
                                .read<EditContactBloc>()
                                .add(EditContactFirstNameChanged(value));
                          },
                        );
                      },
                    ),
                    BlocBuilder<EditContactBloc, EditContactState>(
                      buildWhen: (prev, curr) => prev.lastName != curr.lastName,
                      builder: (context, state) {
                        return TextFormField(
                          initialValue: state.initialContact?.lastName,
                          textInputAction: TextInputAction.next,
                          textCapitalization: TextCapitalization.words,
                          decoration: const InputDecoration(
                            labelText: 'Last Name',
                            errorText: null,
                          ),
                          onChanged: (value) {
                            context
                                .read<EditContactBloc>()
                                .add(EditContactLastNameChanged(value));
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
              const Spacer(flex: 2),
              Card(
                child: BlocBuilder<EditContactBloc, EditContactState>(
                  buildWhen: (prev, curr) =>
                      prev.phoneNumber != curr.phoneNumber,
                  builder: (context, state) {
                    return TextFormField(
                      initialValue: state.initialContact?.phoneNumber,
                      decoration: const InputDecoration(
                        labelText: 'Phone Number',
                        errorText: null,
                      ),
                      onChanged: (value) {
                        context
                            .read<EditContactBloc>()
                            .add(EditContactPhoneNumberChanged(value));
                      },
                    );
                  },
                ),
              ),
              const Spacer(),
              Card(
                child: BlocBuilder<EditContactBloc, EditContactState>(
                  buildWhen: (prev, curr) =>
                      prev.emailAddress != curr.emailAddress,
                  builder: (context, state) {
                    return TextFormField(
                      initialValue: state.initialContact?.emailAddress,
                      decoration: const InputDecoration(
                        labelText: 'Email Address',
                        errorText: null,
                      ),
                      onChanged: (value) {
                        context
                            .read<EditContactBloc>()
                            .add(EditContactEmailChanged(value));
                      },
                    );
                  },
                ),
              ),
              const Spacer(flex: 2),
            ],
          ),
        ),
      ),
    );
  }
}
