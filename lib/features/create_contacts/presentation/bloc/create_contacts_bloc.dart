import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'create_contacts_event.dart';
part 'create_contacts_state.dart';

class CreateContactsBloc extends Bloc<CreateContactsEvent, CreateContactsState> {
  CreateContactsBloc() : super(CreateContactsInitial()) {
    on<CreateContactsEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
