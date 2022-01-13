import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/domain/entities/contact.dart';

part 'edit_contact_event.dart';
part 'edit_contact_state.dart';

class EditContactBloc extends Bloc<EditContactEvent, EditContactState> {
  EditContactBloc() : super(const EditContactState()) {
    on<EditContactEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
