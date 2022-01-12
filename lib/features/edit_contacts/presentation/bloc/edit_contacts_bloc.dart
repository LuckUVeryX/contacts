import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'edit_contacts_event.dart';
part 'edit_contacts_state.dart';

class EditContactsBloc extends Bloc<EditContactsEvent, EditContactsState> {
  EditContactsBloc() : super(EditContactsInitial()) {
    on<EditContactsEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
