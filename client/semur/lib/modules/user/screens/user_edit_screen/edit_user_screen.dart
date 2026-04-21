import 'package:auto_route/auto_route.dart';
import 'package:csc_picker_plus/csc_picker_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:semur/config/application.dart';
import 'package:semur/global/adaptive_layout_manager.dart';
import 'package:semur/global/app_user.dart';
import 'package:semur/config/routing/router.dart';
import 'package:semur/global/screens/loading_screen.dart';
import 'package:semur/config/shared_preferences_keys.dart';
import 'package:semur/global/widgets/default_text_form_field.dart';
import 'package:semur/global/app_colors.dart';
import 'package:semur/global/log/log.dart';
import 'package:semur/models.pb/google/protobuf/timestamp.pb.dart';
import 'package:semur/services/firebase_analytics_service.dart';
import 'package:semur/services/notification_service.dart';
import 'package:semur/global/widgets/default_app_bar.dart';
import 'package:semur/global/widgets/default_rounded_button.dart';
import 'package:semur/modules/user/bloc/edit_user_bloc/edit_user_bloc.dart';

@RoutePage()
// ignore: must_be_immutable
class EditUserScreen extends StatefulWidget {
  bool isSetup;
  EditUserScreen({super.key, this.isSetup = false});

  @override
  State<EditUserScreen> createState() => _EditUserScreenState();
}

class _EditUserScreenState extends State<EditUserScreen> {
  EditUserBloc bloc = EditUserBloc();
  Widget loadingScreen = const LoadingScreen();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // TODO: Default values
  String country = CscCountry.Uzbekistan.name;
  String stateStr = 'Tashkent';
  String city = 'Tashkent';

  Uint8List? photo;
  String? photoName;
  late FirebaseAuthProviders authProvider;

  @override
  void initState() {
    Application.firebaseAnalyticsService.logEvent(
      FirebaseAnalyticsEvent.openScreen,
      parameters: {"screen_name": "EditUserScreen"},
    );

    if (Application.sharedPreferences!.containsKey(
      SharedPreferencesKeys.userCountry,
    )) {
      country =
          Application.sharedPreferences!.getString(
            SharedPreferencesKeys.userCountry,
          )!;
    }
    if (Application.sharedPreferences!.containsKey(
      SharedPreferencesKeys.userState,
    )) {
      stateStr =
          Application.sharedPreferences!.getString(
            SharedPreferencesKeys.userState,
          )!;
    }
    if (Application.sharedPreferences!.containsKey(
      SharedPreferencesKeys.userCity,
    )) {
      city =
          Application.sharedPreferences!.getString(
            SharedPreferencesKeys.userCity,
          )!;
    }
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      if (!AppUser.user.hasId()) {
        bloc.add(
          EditUserEmit(
            state: EditUserError(
              errorText: Application.appLocalizations!.errorNotFound,
            ),
          ),
        );
      } else {
        try {
          authProvider = await AppUser.getAuthProvider();
          bloc.add(EditUserEmit(state: EditUserInitial()));
        } catch (e) {
          Log.e("EditUserScreen initState error", e);
          bloc.add(
            EditUserEmit(
              state: EditUserError(
                errorText: Application.appLocalizations!.errorTryAgainLater,
              ),
            ),
          );
        }
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: widget.isSetup ? false : true,
      child: Scaffold(
        extendBodyBehindAppBar: false,
        appBar: PreferredSize(
          preferredSize: const Size(double.infinity, 56),
          child: DefaultAppBar(),
        ),
        body: Form(
          key: _formKey,
          child: BlocListener(
            bloc: bloc,
            listener: blocListener,
            child: BlocBuilder(
              bloc: bloc,
              builder: (context, state) {
                if (state is EditUserLoading) {
                  return const LoadingScreen();
                }
                return AdaptiveLayoutManager(
                  config: AdaptiveLayoutConfig.allOneColumn().copyWith(
                    maxContentWidth: 800,
                  ),
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        Application.appLocalizations!.editAccount,
                        maxLines: 2,
                        style: Theme.of(context).textTheme.headlineMedium!
                            .copyWith(fontFamily: 'Default'),
                      ),
                    ),
                    DefaultTextFormField(
                      initialValue: AppUser.user.firstName,
                      maxLength: 20,
                      validator:
                          (val) =>
                              val!.isEmpty
                                  ? "${Application.appLocalizations!.minCharacters} 1"
                                  : null,
                      onChanged: (val) {
                        if (val.isNotEmpty) {
                          setState(() {
                            AppUser.user.firstName = val.trim();
                          });
                        }
                      },
                      keyboardType: TextInputType.name,
                      hintText: Application.appLocalizations!.firstName,
                      labelText: Application.appLocalizations!.firstName,
                    ),
                    DefaultTextFormField(
                      initialValue: AppUser.user.lastName,
                      maxLength: 40,
                      validator:
                          (val) =>
                              val!.isEmpty
                                  ? "${Application.appLocalizations!.minCharacters} 1"
                                  : null,
                      onChanged: (val) {
                        if (val.isNotEmpty) {
                          setState(() {
                            AppUser.user.lastName = val.trim();
                          });
                        }
                      },
                      keyboardType: TextInputType.name,
                      hintText: Application.appLocalizations!.lastName,
                      labelText: Application.appLocalizations!.lastName,
                    ),
                    if ([
                      FirebaseAuthProviders.apple,
                    ].contains(authProvider)) ...[
                      DefaultTextFormField(
                        initialValue: AppUser.user.email,
                        maxLength: 100,
                        validator: (val) {
                          if (val == null || val.isEmpty) {
                            return null;
                          }
                          // Email validation
                          if (!RegExp(
                            r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                          ).hasMatch(val)) {
                            return Application.appLocalizations!.invalidEmail;
                          }
                          return null;
                        },
                        onChanged: (val) {
                          setState(() {
                            AppUser.user.email = val;
                          });
                        },
                        keyboardType: TextInputType.emailAddress,
                        hintText: "admin@semur.com",
                        labelText: Application.appLocalizations!.email,
                      ),
                    ], // Birth Date
                    Container(
                      margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            Application.appLocalizations!.birthDate,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.bodyLarge!
                                .copyWith(color: AppColors.primaryColor),
                          ),
                          CupertinoButton(
                            onPressed: () async {
                              final DateTime? picked = await showDatePicker(
                                context: context,
                                initialDate:
                                    AppUser.user.birthDate.toDateTime(),
                                initialDatePickerMode: DatePickerMode.day,
                                firstDate: DateTime(1900),
                                lastDate: DateTime(
                                  Application.dateTime.now().year + 1,
                                ),
                              );
                              if (picked != null) {
                                setState(() {
                                  AppUser
                                      .user
                                      .birthDate = Timestamp.fromDateTime(
                                    picked.copyWith(
                                      hour: 0,
                                      minute: 0,
                                      second: 0,
                                      millisecond: 0,
                                      microsecond: 0,
                                      isUtc: false,
                                    ),
                                  );
                                });
                              }
                            },
                            padding: EdgeInsets.zero,
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                border: Border.all(
                                  color: AppColors.primaryColor,
                                  width: 2.0,
                                ),
                                color: Colors.transparent,
                              ),
                              child: Text(
                                DateFormat.yMMMd().format(
                                  AppUser.user.birthDate.toDateTime(),
                                ),
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context).textTheme.bodyMedium!
                                    .copyWith(color: AppColors.primaryColor),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // const SizedBox(
                    //   height: 20,
                    // ),
                    // InputRow(
                    //   title: Application.appLocalizations!.address,
                    //   initialValue: AppUser.user.address,
                    //   maxLength: 200,
                    //   validator: (val) => val!.length <= 3
                    //       ? "${Application.appLocalizations!.minCharacters} 3"
                    //       : null,
                    //   onChanged: (val) {
                    //     setState(() {
                    //       AppUser.user.address = val!;
                    //     });
                    //   },
                    //   keyboardType: TextInputType.streetAddress,
                    //   hintText: "2510 W Ivy Street, 33607",
                    // ),
                    // CSCPicker(
                    //   defaultCountry: CscCountry.Uzbekistan,
                    //   flagState: CountryFlag.DISABLE,
                    //   selectedItemStyle:
                    //       Theme.of(context).textTheme.bodyLarge,
                    //   currentCountry:
                    //       country.isNotEmpty ? country : null,
                    //   currentState:
                    //       stateStr.isNotEmpty ? stateStr : null,
                    //   currentCity: city.isNotEmpty ? city : null,
                    //   onCountryChanged: (value) {
                    //     setState(() {
                    //       country = value;
                    //     });
                    //   },
                    //   onStateChanged: (value) {
                    //     if (value != null) {
                    //       setState(() {
                    //         stateStr = value;
                    //       });
                    //     }
                    //   },
                    //   onCityChanged: (value) {
                    //     if (value != null) {
                    //       setState(() {
                    //         city = value;
                    //       });
                    //     }
                    //   },
                    //   countryFilter: const [CscCountry.Uzbekistan],
                    // ),
                    // const SizedBox(
                    //   height: 20,
                    // ),
                    Center(
                      child: DefaultRoundedButton(
                        color: AppColors.primaryColor,
                        textColor: AppColors.lightSecondaryColor,
                        text: Application.appLocalizations!.update,
                        press: () async {
                          // TODO: Remove
                          if (_formKey.currentState!.validate()) {
                            bloc.add(
                              EditUser(
                                user: AppUser.user,
                                photo: photo,
                                photoName: photoName,
                              ),
                            );
                            await Application.sharedPreferences!.setString(
                              SharedPreferencesKeys.userCountry,
                              country,
                            );
                            await Application.sharedPreferences!.setString(
                              SharedPreferencesKeys.userState,
                              stateStr,
                            );
                            await Application.sharedPreferences!.setString(
                              SharedPreferencesKeys.userCity,
                              city,
                            );
                          }
                        },
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  void blocListener(BuildContext context, state) {
    if (state is EditUserError) {
      showNotification(state.errorText, NotificationType.error);
    }

    if (state is EditUserSuccess) {
      showNotification(
        Application.appLocalizations!.success,
        NotificationType.success,
      );
      // TODO: DocumentAuth on setup
      // bool isSetup = widget.isSetup;
      // setState(() => widget.isSetup = false);
      // if (isSetup) {
      //   context.router.replace(DocumentRoute(isSetup: true));
      // } else {
      //   context.router.maybePop();
      // }
      context.router.navigate(MainRoute());
    }
  }
}
