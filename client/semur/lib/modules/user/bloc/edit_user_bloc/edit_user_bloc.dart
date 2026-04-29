import 'dart:typed_data';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:semur/config/application.dart';
import 'package:semur/global/app_user.dart';
import 'package:semur/global/log/log.dart';
import 'package:semur/models.pb/user/user.pb.dart';
import 'package:semur/services/firebase_analytics_service.dart';

part 'edit_user_event.dart';
part 'edit_user_state.dart';

class EditUserBloc extends Bloc<EditUserEvent, EditUserState> {
  EditUserBloc() : super(EditUserLoading()) {
    on<EditUserEvent>((event, emit) async {
      if (event is EditUser) {
        emit(EditUserLoading());
        try {
          // TODO: Firebase storage should also have its accessor in SemurDev
          if (event.photo != null && event.photoName != null) {
            if (event.user.photo.photoRef.isNotEmpty) {
              await FirebaseStorage.instance
                  .ref()
                  .child(event.user.photo.photoRef)
                  .delete();
            }
            String photoRefStr = "users/${event.user.id}/${event.photoName}";
            Reference makeRef = FirebaseStorage.instance.ref().child(
              photoRefStr,
            );
            await makeRef.putData(event.photo!);
            event.user.photo.photo = await makeRef.getDownloadURL();
            event.user.photo.photoRef = photoRefStr;
          }

          event.user.status = UserStatus.UNVERIFIED;

          await Application.accessors.userAccessor.update(
            user: event.user,
            callerRole: AppUser.currentCallerRole,
          );
          emit(const EditUserSuccess());
        } catch (e) {
          // FirebaseAnalytics log error event
          Application.firebaseAnalyticsService.logEvent(
            FirebaseAnalyticsEvent.errorUserEdit,
            parameters: {"error": e.toString()},
          );
          Log.e("Error edit user", e);
          emit(
            EditUserError(
              errorText: Application.appLocalizations!.errorTryAgainLater,
            ),
          );
        }
      }

      // if (event is DeleteUser) {
      //   emit(EditUserLoading());
      //   try {
      //     await FirebaseStorage.instance
      //         .ref()
      //         .child(event.User.makePhotoRef!)
      //         .delete();
      //     await FirebaseStorage.instance
      //         .ref()
      //         .child(event.User.photoRef!)
      //         .delete();
      //     await Application.firestore
      //         .collection('car_categories')
      //         .doc(event.User.id)
      //         .delete();
      //     bool isSuccess = await AppUser.deleteUser(event.User);
      //     if (!isSuccess) {
      //       Log.e("Error delete car category");
      //       emit(const EditUserError(exception: "Ошибка загрузки"));
      //     } else {
      //       emit(const EditUserSuccess());
      //     }
      //     emit(const EditUserSuccess());
      //   } catch (e) {
      //     Log.e("Error delete car category", e);
      //     emit(const EditUserError(exception: "Ошибка"));
      //   }
      // }

      if (event is EditUserEmit) {
        emit(event.state);
      }
    });
  }
}
