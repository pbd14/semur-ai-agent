part of 'gmail_inbox_bloc.dart';

sealed class GmailInboxEvent extends Equatable {
  const GmailInboxEvent();

  @override
  List<Object> get props => [];
}

class GmailInboxInitialize extends GmailInboxEvent {
  final DocumentSnapshot? lastDocument;
  const GmailInboxInitialize({this.lastDocument});
}