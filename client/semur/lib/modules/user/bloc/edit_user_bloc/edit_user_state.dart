part of 'edit_user_bloc.dart';

sealed class EditUserState extends Equatable {
  const EditUserState();

  @override
  List<Object> get props => [];
}

final class EditUserInitial extends EditUserState {}

final class EditUserLoading extends EditUserState {}

class EditUserError extends EditUserState {
  final String errorText;

  const EditUserError({
    required this.errorText,
  });
}

class EditUserSuccess extends EditUserState {
  const EditUserSuccess();
}
