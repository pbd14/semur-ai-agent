part of 'edit_user_bloc.dart';

sealed class EditUserEvent extends Equatable {
  const EditUserEvent();

  @override
  List<Object> get props => [];
}

class EditUser extends EditUserEvent {
  final SemurUser user;
  final Uint8List? photo;
  final String? photoName;

  const EditUser({
    required this.user,
    this.photo,
    this.photoName,
  });
}

class DeleteUser extends EditUserEvent {
  final SemurUser user;

  const DeleteUser({
    required this.user,
  });
}

class EditUserEmit extends EditUserEvent {
  final EditUserState state;

  const EditUserEmit({
    required this.state,
  });
}
