import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'contacts_list_event.dart';
part 'contacts_list_state.dart';

class ContactsListBloc extends Bloc<ContactsListEvent, ContactsListState> {
  ContactsListBloc() : super(ContactsListInitial()) {
    on<ContactsListEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
