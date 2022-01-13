import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/data/repositories/contacts_repostory_impl.dart';
import '../../../../core/domain/entities/contact.dart';
import '../../../../core/errors/exceptions.dart';

part 'contacts_list_event.dart';
part 'contacts_list_state.dart';

class ContactsListBloc extends Bloc<ContactsListEvent, ContactsListState> {
  ContactsListBloc(this._repository) : super(const ContactsListState()) {
    on<ContactsListSubscriptionRequested>(_onSubcriptionRequested);
    on<ContactsListContactSaved>(_onContactsSaved);
    on<ContactsListContactDeleted>(_onContactDeleted);
    on<ContactsListUndoDeletionRequested>(_onUndoDeletionRequested);
  }

  final ContactsRepository _repository;

  Future<void> _onSubcriptionRequested(
    ContactsListSubscriptionRequested event,
    Emitter<ContactsListState> emit,
  ) async {
    emit(state.copyWith(status: ContactsListStatus.loading));

    await emit.forEach<List<Contact>>(
      _repository.contacts,
      onData: (contacts) => state.copyWith(
        status: ContactsListStatus.success,
        contacts: contacts,
      ),
      onError: (_, __) => state.copyWith(
        status: ContactsListStatus.failure,
      ),
    );
  }

  void _onContactsSaved(
    ContactsListContactSaved event,
    Emitter<ContactsListState> emit,
  ) async {
    _repository.saveContact(event.contact);
  }

  void _onContactDeleted(
    ContactsListContactDeleted event,
    Emitter<ContactsListState> emit,
  ) {
    {
      emit(state.copyWith(lastDeletedContact: () => event.contact));
      _repository.deleteContact(event.contact.id);
    }
  }

  void _onUndoDeletionRequested(
    ContactsListUndoDeletionRequested event,
    Emitter<ContactsListState> emit,
  ) {
    if (state.lastDeletedContact == null) {
      throw LastDeletedContactNotFoundException();
    }

    final contact = state.lastDeletedContact!;
    emit(state.copyWith(lastDeletedContact: () => null));
    _repository.saveContact(contact);
  }
}
