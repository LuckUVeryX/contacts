import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:formz/formz.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/domain/entities/contact.dart';
import '../../../../core/domain/repositories/contacts_repository.dart';
import '../../../../core/theme/palette.dart';
import '../../domain/entities/email.dart';
import '../../domain/entities/phone_number.dart';

part 'edit_contact_event.dart';
part 'edit_contact_state.dart';

class EditContactBloc extends Bloc<EditContactEvent, EditContactState> {
  EditContactBloc({
    required IContactsRepository repository,
    required Contact? initialContact,
  })  : _repository = repository,
        super(EditContactState(
          initialContact: initialContact,
          firstName: initialContact?.firstName ?? '',
          lastName: initialContact?.lastName ?? '',
          phoneNumber: PhoneNumber.pure(initialContact?.phoneNumber ?? ''),
          emailAddress: Email.pure(initialContact?.emailAddress ?? ''),
        )) {
    on<EditContactFirstNameChanged>(_onFirstNameChanged);
    on<EditContactLastNameChanged>(_onLastNameChanged);
    on<EditContactPhoneNumberChanged>(_onPhoneNumberChanged);
    on<EditContactEmailChanged>(_onEmailChanged);
    on<EditContactSubmitted>(_onSubmitted);
  }

  final IContactsRepository _repository;

  void _onFirstNameChanged(
    EditContactFirstNameChanged event,
    Emitter<EditContactState> emit,
  ) {
    emit(
      state.copyWith(
        firstName: event.firstName,
        formStatus: Formz.validate([state.phoneNumber, state.emailAddress]),
      ),
    );
  }

  void _onLastNameChanged(
    EditContactLastNameChanged event,
    Emitter<EditContactState> emit,
  ) {
    emit(state.copyWith(
      lastName: event.lastName,
      formStatus: Formz.validate([state.phoneNumber, state.emailAddress]),
    ));
  }

  void _onPhoneNumberChanged(
    EditContactPhoneNumberChanged event,
    Emitter<EditContactState> emit,
  ) {
    final phoneNumber = PhoneNumber.dirty(event.phoneNumber);
    emit(state.copyWith(
        phoneNumber: phoneNumber,
        formStatus: Formz.validate([phoneNumber, state.emailAddress])));
  }

  void _onEmailChanged(
    EditContactEmailChanged event,
    Emitter<EditContactState> emit,
  ) {
    final email = Email.dirty(event.email);
    emit(
      state.copyWith(
        emailAddress: email,
        formStatus: Formz.validate([state.phoneNumber, email]),
      ),
    );
  }

  void _onSubmitted(
    EditContactSubmitted event,
    Emitter<EditContactState> emit,
  ) {
    final email = Email.dirty(state.emailAddress.value);
    final phoneNumber = PhoneNumber.dirty(state.phoneNumber.value);

    emit(
      state.copyWith(
        emailAddress: email,
        phoneNumber: phoneNumber,
        formStatus: Formz.validate(
          [phoneNumber, email],
        ),
      ),
    );

    if (state.formStatus.isValidated) {
      emit(state.copyWith(formStatus: FormzStatus.submissionInProgress));
      var contact = state.initialContact ??
          Contact(
            id: AppConstants.kNewContactId,
            firstName: state.firstName,
            lastName: state.lastName,
            emailAddress: state.emailAddress.value,
            phoneNumber: state.phoneNumber.value,
            profileColor: state.profileColor,
          );

      contact = contact.copyWith(
        firstName: state.firstName,
        lastName: state.lastName,
        emailAddress: state.emailAddress.value,
        phoneNumber: state.phoneNumber.value,
      );

      _repository.saveContact(contact);
      emit(state.copyWith(formStatus: FormzStatus.submissionSuccess));
    }
  }
}
