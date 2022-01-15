import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/domain/entities/contact.dart';
import '../../../../core/domain/repositories/contacts_repository.dart';

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
          phoneNumber: initialContact?.phoneNumber ?? '',
          emailAddress: initialContact?.emailAddress ?? '',
        )) {
    on<EditContactFirstNameChanged>(_onFirstNameChanged);
    on<EditContactLastNameChanged>(_onLastNameChanged);
    on<EditContactPhoneNumberChanged>(_onPhoneNumberchanged);
    on<EditContactEmailChanged>(_onEmailChanged);
    on<EditContactSubmitted>(_onSubmitted);
  }

  final IContactsRepository _repository;

  void _onFirstNameChanged(
    EditContactFirstNameChanged event,
    Emitter<EditContactState> emit,
  ) {
    emit(state.copyWith(firstName: event.firstName));
  }

  void _onLastNameChanged(
    EditContactLastNameChanged event,
    Emitter<EditContactState> emit,
  ) {
    emit(state.copyWith(lastName: event.lastName));
  }

  void _onPhoneNumberchanged(
    EditContactPhoneNumberChanged event,
    Emitter<EditContactState> emit,
  ) {
    emit(state.copyWith(phoneNumber: event.phoneNumber));
  }

  void _onEmailChanged(
    EditContactEmailChanged event,
    Emitter<EditContactState> emit,
  ) {
    emit(state.copyWith(emailAddress: event.email));
  }

  void _onSubmitted(
    EditContactSubmitted event,
    Emitter<EditContactState> emit,
  ) {
    emit(state.copyWith(status: EditContactStatus.loading));
    var contact = state.initialContact ??
        Contact(
          id: AppConstants.kNewContactId,
          firstName: state.firstName,
          lastName: state.lastName,
          emailAddress: state.emailAddress,
          phoneNumber: state.phoneNumber,
          profileColor: Color(
            (Random().nextDouble() * 0xFFFFFF).toInt(),
          ).withOpacity(1.0),
        );

    contact = contact.copyWith(
      firstName: state.firstName,
      lastName: state.lastName,
      emailAddress: state.emailAddress,
      phoneNumber: state.phoneNumber,
    );

    _repository.saveContact(contact);
    emit(state.copyWith(status: EditContactStatus.done));
  }
}
