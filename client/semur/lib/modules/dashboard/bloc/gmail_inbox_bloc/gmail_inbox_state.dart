part of 'gmail_inbox_bloc.dart';

sealed class GmailInboxState extends Equatable {
  const GmailInboxState();

  @override
  List<Object> get props => [];
}

class GmailInboxInitial extends GmailInboxState {
  final List<SyncGoogleMailEmail> emails;
  final DocumentSnapshot? lastDocument;

  const GmailInboxInitial({required this.emails, required this.lastDocument});
}

final class GmailInboxLoading extends GmailInboxState {}

class GmailInboxError extends GmailInboxState {
  final String errorText;

  const GmailInboxError({required this.errorText});
}
