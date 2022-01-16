import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

import '../../../../core/data/repositories/contacts_repostory_impl.dart';
import '../../../../core/domain/entities/contact.dart';
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
      child: MultiBlocListener(
        listeners: [
          BlocListener<EditContactBloc, EditContactState>(
            listenWhen: (prev, curr) {
              return prev.formStatus != curr.formStatus &&
                  curr.formStatus == FormzStatus.submissionSuccess;
            },
            listener: (context, _) {
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
              Navigator.of(context).pop();
            },
          ),
          BlocListener<EditContactBloc, EditContactState>(
            listenWhen: (previous, current) {
              return previous.formStatus != current.formStatus &&
                  current.formStatus == FormzStatus.submissionInProgress;
            },
            listener: (context, _) {
              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(
                    const SnackBar(content: Text('Saving contact...')));
            },
          ),
        ],
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
              BlocBuilder<EditContactBloc, EditContactState>(
                  builder: (context, state) {
                return IconButton(
                  onPressed:
                      state.formStatus.isValidated || state.formStatus.isPure
                          ? () {
                              context
                                  .read<EditContactBloc>()
                                  .add(EditContactSubmitted());
                            }
                          : null,
                  icon: const Icon(Icons.done),
                );
              }),
            ],
          ),
          body: GestureDetector(
            onTap: FocusScope.of(context).unfocus,
            child: SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
              child: SizedBox(
                height:
                    MediaQuery.of(context).size.height - kToolbarHeight - 24,
                child: Column(
                  children: [
                    const Spacer(flex: 2),
                    BlocBuilder<EditContactBloc, EditContactState>(
                      builder: (context, state) {
                        return ProfilePictureWithTextWidget(
                          radius: 48.0,
                          initials: state.initials,
                          textStyle: textTheme.headline5
                              ?.copyWith(fontWeight: FontWeight.bold),
                          backgroundColor: state.profileColor,
                        );
                      },
                    ),
                    const Spacer(flex: 2),
                    _buildNameFields(),
                    const Spacer(flex: 2),
                    _buildPhoneNumberField(),
                    const Spacer(),
                    _buildEmailAddressField(),
                    const Spacer(flex: 2),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Card _buildEmailAddressField() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<EditContactBloc, EditContactState>(
          buildWhen: (prev, curr) => prev.emailAddress != curr.emailAddress,
          builder: (context, state) {
            return TextFormField(
              initialValue: state.initialContact?.emailAddress,
              textInputAction: TextInputAction.done,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                labelText: 'Email Address',
                errorText: state.emailAddress.valid || state.emailAddress.pure
                    ? null
                    : 'Please ensure that email entered is valid',
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
    );
  }

  Card _buildPhoneNumberField() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<EditContactBloc, EditContactState>(
          buildWhen: (prev, curr) => prev.phoneNumber != curr.phoneNumber,
          builder: (context, state) {
            return TextFormField(
              initialValue: state.initialContact?.phoneNumber,
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                labelText: 'Phone Number',
                errorText: state.phoneNumber.valid || state.phoneNumber.pure
                    ? null
                    : 'Please ensure that phone number entered is valid',
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
    );
  }

  Card _buildNameFields() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            BlocBuilder<EditContactBloc, EditContactState>(
              buildWhen: (prev, curr) => prev.firstName != curr.firstName,
              builder: (context, state) {
                return TextFormField(
                  initialValue: state.initialContact?.firstName,
                  textInputAction: TextInputAction.next,
                  textCapitalization: TextCapitalization.words,
                  keyboardType: TextInputType.name,
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
                  keyboardType: TextInputType.name,
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
    );
  }
}
