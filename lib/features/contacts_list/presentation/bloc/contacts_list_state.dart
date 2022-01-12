part of 'contacts_list_bloc.dart';

abstract class ContactsListState extends Equatable {
  const ContactsListState();  

  @override
  List<Object> get props => [];
}
class ContactsListInitial extends ContactsListState {}
