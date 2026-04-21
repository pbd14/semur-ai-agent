import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_ru.dart';
import 'app_localizations_uz.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('ru'),
    Locale('uz')
  ];

  /// Welcome
  ///
  /// In en, this message translates to:
  /// **'Welcome'**
  String get welcome;

  /// No description provided for @enterPhoneNo.
  ///
  /// In en, this message translates to:
  /// **'Enter phone number'**
  String get enterPhoneNo;

  /// No description provided for @send.
  ///
  /// In en, this message translates to:
  /// **'Send'**
  String get send;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @sure.
  ///
  /// In en, this message translates to:
  /// **'Are you sure?'**
  String get sure;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @error.
  ///
  /// In en, this message translates to:
  /// **'Error'**
  String get error;

  /// No description provided for @errorTryAgainLater.
  ///
  /// In en, this message translates to:
  /// **'Error. Try again later'**
  String get errorTryAgainLater;

  /// No description provided for @errorAccountBlocked.
  ///
  /// In en, this message translates to:
  /// **'Your account has been blocked. Please contact support'**
  String get errorAccountBlocked;

  /// No description provided for @authWrongCode.
  ///
  /// In en, this message translates to:
  /// **'Wrong Code'**
  String get authWrongCode;

  /// No description provided for @authTimeout.
  ///
  /// In en, this message translates to:
  /// **'Code expired'**
  String get authTimeout;

  /// No description provided for @authAuthorized.
  ///
  /// In en, this message translates to:
  /// **'Authorized'**
  String get authAuthorized;

  /// No description provided for @smsCode.
  ///
  /// In en, this message translates to:
  /// **'SMS Code'**
  String get smsCode;

  /// No description provided for @authEnterSmsCode.
  ///
  /// In en, this message translates to:
  /// **'Enter SMS code'**
  String get authEnterSmsCode;

  /// No description provided for @minCharacters.
  ///
  /// In en, this message translates to:
  /// **'Min characters'**
  String get minCharacters;

  /// No description provided for @authChangePhone.
  ///
  /// In en, this message translates to:
  /// **'Change phone number'**
  String get authChangePhone;

  /// No description provided for @authSmsSentTo.
  ///
  /// In en, this message translates to:
  /// **'SMS was sent to'**
  String get authSmsSentTo;

  /// No description provided for @sendAgain.
  ///
  /// In en, this message translates to:
  /// **'Send again'**
  String get sendAgain;

  /// No description provided for @home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// No description provided for @bookings.
  ///
  /// In en, this message translates to:
  /// **'Bookings'**
  String get bookings;

  /// No description provided for @yes.
  ///
  /// In en, this message translates to:
  /// **'Yes'**
  String get yes;

  /// No description provided for @no.
  ///
  /// In en, this message translates to:
  /// **'No'**
  String get no;

  /// No description provided for @retry.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get retry;

  /// No description provided for @total.
  ///
  /// In en, this message translates to:
  /// **'Total'**
  String get total;

  /// No description provided for @timeout.
  ///
  /// In en, this message translates to:
  /// **'Timeout'**
  String get timeout;

  /// No description provided for @bookingTimeoutText.
  ///
  /// In en, this message translates to:
  /// **'Information about your booking is too old. Choose your car again'**
  String get bookingTimeoutText;

  /// No description provided for @choosePaymentMode.
  ///
  /// In en, this message translates to:
  /// **'Choose payment mode'**
  String get choosePaymentMode;

  /// No description provided for @chooseAddOns.
  ///
  /// In en, this message translates to:
  /// **'Choose Add ons'**
  String get chooseAddOns;

  /// No description provided for @continueText.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get continueText;

  /// No description provided for @search.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get search;

  /// No description provided for @car.
  ///
  /// In en, this message translates to:
  /// **'Car'**
  String get car;

  /// No description provided for @searchByBrand.
  ///
  /// In en, this message translates to:
  /// **'Search by brand'**
  String get searchByBrand;

  /// No description provided for @brand.
  ///
  /// In en, this message translates to:
  /// **'Brand'**
  String get brand;

  /// No description provided for @carBrand.
  ///
  /// In en, this message translates to:
  /// **'Car brand'**
  String get carBrand;

  /// No description provided for @selectCarBrand.
  ///
  /// In en, this message translates to:
  /// **'Select car brand'**
  String get selectCarBrand;

  /// No description provided for @searchType.
  ///
  /// In en, this message translates to:
  /// **'Search type'**
  String get searchType;

  /// No description provided for @carType.
  ///
  /// In en, this message translates to:
  /// **'Car type'**
  String get carType;

  /// No description provided for @selectCarType.
  ///
  /// In en, this message translates to:
  /// **'Select car type'**
  String get selectCarType;

  /// No description provided for @noCarsAvailable.
  ///
  /// In en, this message translates to:
  /// **'No cars available'**
  String get noCarsAvailable;

  /// No description provided for @loadMore.
  ///
  /// In en, this message translates to:
  /// **'Load More'**
  String get loadMore;

  /// No description provided for @locationClosed.
  ///
  /// In en, this message translates to:
  /// **'Location is closed for chosen time'**
  String get locationClosed;

  /// No description provided for @booking.
  ///
  /// In en, this message translates to:
  /// **'Booking'**
  String get booking;

  /// No description provided for @time.
  ///
  /// In en, this message translates to:
  /// **'Time'**
  String get time;

  /// No description provided for @pickUpAndDropAt.
  ///
  /// In en, this message translates to:
  /// **'Pick Up and Drop at'**
  String get pickUpAndDropAt;

  /// No description provided for @changePickUpLocation.
  ///
  /// In en, this message translates to:
  /// **'Change Pick Up Location'**
  String get changePickUpLocation;

  /// No description provided for @changeDropOffLocation.
  ///
  /// In en, this message translates to:
  /// **'Change Drop Off Location'**
  String get changeDropOffLocation;

  /// No description provided for @changeChoiceText.
  ///
  /// In en, this message translates to:
  /// **'You can change your choice later'**
  String get changeChoiceText;

  /// No description provided for @noDifferentLocationText.
  ///
  /// In en, this message translates to:
  /// **'This renter doesn\'t allow drop off at different location'**
  String get noDifferentLocationText;

  /// No description provided for @dropAtDifferentLocation.
  ///
  /// In en, this message translates to:
  /// **'Drop at different location'**
  String get dropAtDifferentLocation;

  /// No description provided for @pickUp.
  ///
  /// In en, this message translates to:
  /// **'Pick Up'**
  String get pickUp;

  /// No description provided for @dropAt.
  ///
  /// In en, this message translates to:
  /// **'Drop at'**
  String get dropAt;

  /// No description provided for @chooseLocation.
  ///
  /// In en, this message translates to:
  /// **'Choose location'**
  String get chooseLocation;

  /// No description provided for @locationClosedForDropTime.
  ///
  /// In en, this message translates to:
  /// **'This location is closed for drop time'**
  String get locationClosedForDropTime;

  /// No description provided for @dropAtTheSameLocation.
  ///
  /// In en, this message translates to:
  /// **'Drop at the same location'**
  String get dropAtTheSameLocation;

  /// No description provided for @choosePickUpLocation.
  ///
  /// In en, this message translates to:
  /// **'Choose Pick Up Location'**
  String get choosePickUpLocation;

  /// No description provided for @chooseDropLocation.
  ///
  /// In en, this message translates to:
  /// **'Choose Drop Location'**
  String get chooseDropLocation;

  /// No description provided for @success.
  ///
  /// In en, this message translates to:
  /// **'Success'**
  String get success;

  /// No description provided for @confirm.
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get confirm;

  /// No description provided for @noBookings.
  ///
  /// In en, this message translates to:
  /// **'No bookings'**
  String get noBookings;

  /// No description provided for @copied.
  ///
  /// In en, this message translates to:
  /// **'Copied'**
  String get copied;

  /// No description provided for @bookingInfo.
  ///
  /// In en, this message translates to:
  /// **'Booking Info'**
  String get bookingInfo;

  /// No description provided for @from.
  ///
  /// In en, this message translates to:
  /// **'From'**
  String get from;

  /// No description provided for @to.
  ///
  /// In en, this message translates to:
  /// **'To'**
  String get to;

  /// No description provided for @info.
  ///
  /// In en, this message translates to:
  /// **'Info'**
  String get info;

  /// No description provided for @payment.
  ///
  /// In en, this message translates to:
  /// **'Payment'**
  String get payment;

  /// No description provided for @status.
  ///
  /// In en, this message translates to:
  /// **'Status'**
  String get status;

  /// No description provided for @contactUs.
  ///
  /// In en, this message translates to:
  /// **'ContactUs'**
  String get contactUs;

  /// No description provided for @pickUpDetails.
  ///
  /// In en, this message translates to:
  /// **'Pick Up Details'**
  String get pickUpDetails;

  /// No description provided for @dropOffDetails.
  ///
  /// In en, this message translates to:
  /// **'Drop Off Details'**
  String get dropOffDetails;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @cancelBookingText.
  ///
  /// In en, this message translates to:
  /// **'Do you want to cancel this booking'**
  String get cancelBookingText;

  /// No description provided for @actionCannotBeUndone.
  ///
  /// In en, this message translates to:
  /// **'This action cannot be undone'**
  String get actionCannotBeUndone;

  /// No description provided for @carRental.
  ///
  /// In en, this message translates to:
  /// **'Car rental'**
  String get carRental;

  /// No description provided for @addOns.
  ///
  /// In en, this message translates to:
  /// **'Add Ons'**
  String get addOns;

  /// No description provided for @makeBookingAtLeast1HourInAdvance.
  ///
  /// In en, this message translates to:
  /// **'Make booking at least 1 hour in advance'**
  String get makeBookingAtLeast1HourInAdvance;

  /// No description provided for @wrongDate.
  ///
  /// In en, this message translates to:
  /// **'Wrong date'**
  String get wrongDate;

  /// No description provided for @wrongTime.
  ///
  /// In en, this message translates to:
  /// **'Wrong time'**
  String get wrongTime;

  /// No description provided for @payNow.
  ///
  /// In en, this message translates to:
  /// **'Pay now'**
  String get payNow;

  /// No description provided for @payNowText.
  ///
  /// In en, this message translates to:
  /// **'Get the best price by paying now. Cancellation fees may apply'**
  String get payNowText;

  /// No description provided for @payLater.
  ///
  /// In en, this message translates to:
  /// **'Pay later'**
  String get payLater;

  /// No description provided for @payLaterText.
  ///
  /// In en, this message translates to:
  /// **'Pay at arrival. Additional fees may apply'**
  String get payLaterText;

  /// No description provided for @location.
  ///
  /// In en, this message translates to:
  /// **'Location'**
  String get location;

  /// No description provided for @hour.
  ///
  /// In en, this message translates to:
  /// **'Hour'**
  String get hour;

  /// No description provided for @chooseCarCategory.
  ///
  /// In en, this message translates to:
  /// **'Choose car category'**
  String get chooseCarCategory;

  /// No description provided for @renter.
  ///
  /// In en, this message translates to:
  /// **'Renter'**
  String get renter;

  /// No description provided for @name.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get name;

  /// No description provided for @firstName.
  ///
  /// In en, this message translates to:
  /// **'First name'**
  String get firstName;

  /// No description provided for @lastName.
  ///
  /// In en, this message translates to:
  /// **'Last name'**
  String get lastName;

  /// No description provided for @birthDate.
  ///
  /// In en, this message translates to:
  /// **'Birth date'**
  String get birthDate;

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// No description provided for @phone.
  ///
  /// In en, this message translates to:
  /// **'Phone'**
  String get phone;

  /// No description provided for @inProgress.
  ///
  /// In en, this message translates to:
  /// **'In progress'**
  String get inProgress;

  /// No description provided for @upcoming.
  ///
  /// In en, this message translates to:
  /// **'Upcoming'**
  String get upcoming;

  /// No description provided for @chooseTime.
  ///
  /// In en, this message translates to:
  /// **'Choose time'**
  String get chooseTime;

  /// No description provided for @account.
  ///
  /// In en, this message translates to:
  /// **'Account'**
  String get account;

  /// No description provided for @logout.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logout;

  /// No description provided for @logoutText.
  ///
  /// In en, this message translates to:
  /// **'Do you want to leave the account?'**
  String get logoutText;

  /// No description provided for @logoutText2.
  ///
  /// In en, this message translates to:
  /// **'You can access it later'**
  String get logoutText2;

  /// No description provided for @whereToRentCar.
  ///
  /// In en, this message translates to:
  /// **'Where do you want to rent car?'**
  String get whereToRentCar;

  /// No description provided for @locationClosedThisDay.
  ///
  /// In en, this message translates to:
  /// **'Location is closed this day'**
  String get locationClosedThisDay;

  /// No description provided for @closed.
  ///
  /// In en, this message translates to:
  /// **'Closed'**
  String get closed;

  /// No description provided for @editAccount.
  ///
  /// In en, this message translates to:
  /// **'Edit account'**
  String get editAccount;

  /// No description provided for @photo.
  ///
  /// In en, this message translates to:
  /// **'Photo'**
  String get photo;

  /// No description provided for @address.
  ///
  /// In en, this message translates to:
  /// **'Address'**
  String get address;

  /// No description provided for @choosePhoto.
  ///
  /// In en, this message translates to:
  /// **'Choose photo'**
  String get choosePhoto;

  /// No description provided for @update.
  ///
  /// In en, this message translates to:
  /// **'Update'**
  String get update;

  /// No description provided for @about.
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get about;

  /// No description provided for @documents.
  ///
  /// In en, this message translates to:
  /// **'Documents'**
  String get documents;

  /// No description provided for @edit.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get edit;

  /// No description provided for @country.
  ///
  /// In en, this message translates to:
  /// **'Country'**
  String get country;

  /// No description provided for @state.
  ///
  /// In en, this message translates to:
  /// **'Region'**
  String get state;

  /// No description provided for @city.
  ///
  /// In en, this message translates to:
  /// **'City'**
  String get city;

  /// No description provided for @paymentModeLater.
  ///
  /// In en, this message translates to:
  /// **'ON PLACE'**
  String get paymentModeLater;

  /// No description provided for @paymentModeOnline.
  ///
  /// In en, this message translates to:
  /// **'ONLINE'**
  String get paymentModeOnline;

  /// No description provided for @bookingStatusActive.
  ///
  /// In en, this message translates to:
  /// **'Active'**
  String get bookingStatusActive;

  /// No description provided for @bookingStatusCanceled.
  ///
  /// In en, this message translates to:
  /// **'Canceled'**
  String get bookingStatusCanceled;

  /// No description provided for @bookingStatusCreating.
  ///
  /// In en, this message translates to:
  /// **'Creating'**
  String get bookingStatusCreating;

  /// No description provided for @bookingStatusFinished.
  ///
  /// In en, this message translates to:
  /// **'Finished'**
  String get bookingStatusFinished;

  /// No description provided for @bookingStatusInProgress.
  ///
  /// In en, this message translates to:
  /// **'In Progress'**
  String get bookingStatusInProgress;

  /// No description provided for @bookingStatusPending.
  ///
  /// In en, this message translates to:
  /// **'Pending'**
  String get bookingStatusPending;

  /// No description provided for @bookingInstuctionTitle1.
  ///
  /// In en, this message translates to:
  /// **'Go to the pick up location'**
  String get bookingInstuctionTitle1;

  /// No description provided for @bookingInstuctionTitle2.
  ///
  /// In en, this message translates to:
  /// **'Find your car'**
  String get bookingInstuctionTitle2;

  /// No description provided for @bookingInstuctionTitle3.
  ///
  /// In en, this message translates to:
  /// **'Enjoy driving'**
  String get bookingInstuctionTitle3;

  /// No description provided for @bookingInstuctionTitle4.
  ///
  /// In en, this message translates to:
  /// **'Thank you!'**
  String get bookingInstuctionTitle4;

  /// No description provided for @bookingInstuctionTitleDefault.
  ///
  /// In en, this message translates to:
  /// **'Enjoy your booking'**
  String get bookingInstuctionTitleDefault;

  /// No description provided for @bookingInstuction1.
  ///
  /// In en, this message translates to:
  /// **'It is better to arrive 15 minutes earlier. When you reach the pick up location, pay for your booking to activate it. Once you have paid, booking status will change to ACTIVE'**
  String get bookingInstuction1;

  /// No description provided for @bookingInstuction2.
  ///
  /// In en, this message translates to:
  /// **'Your booking is paid. Now go to the pick up location and find you car using plate number below'**
  String get bookingInstuction2;

  /// No description provided for @bookingInstuction3.
  ///
  /// In en, this message translates to:
  /// **'Stay safe while driving. Don\'t forget to return the car on time. Make sure booking status is FINISHED after the return'**
  String get bookingInstuction3;

  /// No description provided for @bookingInstuction4.
  ///
  /// In en, this message translates to:
  /// **'If you have any questions, feel free to contact us'**
  String get bookingInstuction4;

  /// No description provided for @payments.
  ///
  /// In en, this message translates to:
  /// **'Payments'**
  String get payments;

  /// No description provided for @paymentInfo.
  ///
  /// In en, this message translates to:
  /// **'Payment Info'**
  String get paymentInfo;

  /// No description provided for @paid.
  ///
  /// In en, this message translates to:
  /// **'Paid'**
  String get paid;

  /// No description provided for @bookingPaymentInstruction1.
  ///
  /// In en, this message translates to:
  /// **'Pay for your booking when you arrive to pick up location'**
  String get bookingPaymentInstruction1;

  /// No description provided for @bookingPaymentInstruction2.
  ///
  /// In en, this message translates to:
  /// **'No payment information is available'**
  String get bookingPaymentInstruction2;

  /// No description provided for @payWithOcto.
  ///
  /// In en, this message translates to:
  /// **'Pay with Octo'**
  String get payWithOcto;

  /// No description provided for @creditCard.
  ///
  /// In en, this message translates to:
  /// **'Credit Card'**
  String get creditCard;

  /// No description provided for @regulaAuthLoading.
  ///
  /// In en, this message translates to:
  /// **'Preparing authentication'**
  String get regulaAuthLoading;

  /// No description provided for @passport.
  ///
  /// In en, this message translates to:
  /// **'Passport'**
  String get passport;

  /// No description provided for @drivingLicense.
  ///
  /// In en, this message translates to:
  /// **'Driving license'**
  String get drivingLicense;

  /// No description provided for @regulaInstruction1.
  ///
  /// In en, this message translates to:
  /// **'Take a photo of your passport or ID card'**
  String get regulaInstruction1;

  /// No description provided for @regulaInstruction2.
  ///
  /// In en, this message translates to:
  /// **'Take a photo of your driving license'**
  String get regulaInstruction2;

  /// No description provided for @cameraAccess.
  ///
  /// In en, this message translates to:
  /// **'Camera access'**
  String get cameraAccess;

  /// No description provided for @cameraAccessInstruction.
  ///
  /// In en, this message translates to:
  /// **'Please provide permission to use camera in order to pass authentication'**
  String get cameraAccessInstruction;

  /// No description provided for @skip.
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get skip;

  /// No description provided for @myDocuments.
  ///
  /// In en, this message translates to:
  /// **'My Documents'**
  String get myDocuments;

  /// No description provided for @validUntil.
  ///
  /// In en, this message translates to:
  /// **'Valid until'**
  String get validUntil;

  /// No description provided for @rules.
  ///
  /// In en, this message translates to:
  /// **'Rules'**
  String get rules;

  /// No description provided for @dob.
  ///
  /// In en, this message translates to:
  /// **'Date of birth'**
  String get dob;

  /// No description provided for @deleteAccount.
  ///
  /// In en, this message translates to:
  /// **'Delete account'**
  String get deleteAccount;

  /// No description provided for @continueAsGuest.
  ///
  /// In en, this message translates to:
  /// **'Continue as guest'**
  String get continueAsGuest;

  /// No description provided for @needToSignIn.
  ///
  /// In en, this message translates to:
  /// **'Need to sign in'**
  String get needToSignIn;

  /// No description provided for @signIn.
  ///
  /// In en, this message translates to:
  /// **'Sign in'**
  String get signIn;

  /// No description provided for @addCard.
  ///
  /// In en, this message translates to:
  /// **'Add card'**
  String get addCard;

  /// No description provided for @cardName.
  ///
  /// In en, this message translates to:
  /// **'Card Name'**
  String get cardName;

  /// No description provided for @cardNumber.
  ///
  /// In en, this message translates to:
  /// **'Card Number'**
  String get cardNumber;

  /// No description provided for @cardNumberValidator.
  ///
  /// In en, this message translates to:
  /// **'Enter 16 digit card number'**
  String get cardNumberValidator;

  /// No description provided for @cardholderName.
  ///
  /// In en, this message translates to:
  /// **'Cardholder Name'**
  String get cardholderName;

  /// No description provided for @enterCardMM.
  ///
  /// In en, this message translates to:
  /// **'Enter card\'s expiration month'**
  String get enterCardMM;

  /// No description provided for @enterCardYY.
  ///
  /// In en, this message translates to:
  /// **'Enter card\'s expiration year'**
  String get enterCardYY;

  /// No description provided for @enterCardCVV.
  ///
  /// In en, this message translates to:
  /// **'Enter card CVV'**
  String get enterCardCVV;

  /// No description provided for @enterCardholderName.
  ///
  /// In en, this message translates to:
  /// **'Enter cardholder name'**
  String get enterCardholderName;

  /// No description provided for @cards.
  ///
  /// In en, this message translates to:
  /// **'Cards'**
  String get cards;

  /// No description provided for @deleteCard.
  ///
  /// In en, this message translates to:
  /// **'Delete card?'**
  String get deleteCard;

  /// No description provided for @deleteCardText.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete your card from this device?'**
  String get deleteCardText;

  /// No description provided for @chooseCard.
  ///
  /// In en, this message translates to:
  /// **'Choose card'**
  String get chooseCard;

  /// No description provided for @service.
  ///
  /// In en, this message translates to:
  /// **'Service'**
  String get service;

  /// No description provided for @findCar.
  ///
  /// In en, this message translates to:
  /// **'Find car'**
  String get findCar;

  /// No description provided for @agreeWithRules.
  ///
  /// In en, this message translates to:
  /// **'You need to agree with rules'**
  String get agreeWithRules;

  /// No description provided for @carColor.
  ///
  /// In en, this message translates to:
  /// **'Car color'**
  String get carColor;

  /// No description provided for @minDeposit.
  ///
  /// In en, this message translates to:
  /// **'Minimum Deposit'**
  String get minDeposit;

  /// No description provided for @deposit.
  ///
  /// In en, this message translates to:
  /// **'Deposit'**
  String get deposit;

  /// No description provided for @distanceLimit.
  ///
  /// In en, this message translates to:
  /// **'Distance limit'**
  String get distanceLimit;

  /// No description provided for @rating.
  ///
  /// In en, this message translates to:
  /// **'Rating'**
  String get rating;

  /// No description provided for @details.
  ///
  /// In en, this message translates to:
  /// **'Details'**
  String get details;

  /// No description provided for @report.
  ///
  /// In en, this message translates to:
  /// **'Report'**
  String get report;

  /// No description provided for @incidents.
  ///
  /// In en, this message translates to:
  /// **'Incidents'**
  String get incidents;

  /// No description provided for @appUnavailableText.
  ///
  /// In en, this message translates to:
  /// **'App is unavailable due to technical works. Try again later'**
  String get appUnavailableText;

  /// No description provided for @updateApp.
  ///
  /// In en, this message translates to:
  /// **'Update app'**
  String get updateApp;

  /// No description provided for @unavailableAtTheMoment.
  ///
  /// In en, this message translates to:
  /// **'Unavailable at the moment. Please try again later'**
  String get unavailableAtTheMoment;

  /// No description provided for @notPaid.
  ///
  /// In en, this message translates to:
  /// **'Not paid'**
  String get notPaid;

  /// No description provided for @sorryThisCarIsAlreadyBooked.
  ///
  /// In en, this message translates to:
  /// **'Sorry this car is already booked'**
  String get sorryThisCarIsAlreadyBooked;

  /// No description provided for @chooseRentType.
  ///
  /// In en, this message translates to:
  /// **'Choose rent type'**
  String get chooseRentType;

  /// No description provided for @unavailableForThisPartner.
  ///
  /// In en, this message translates to:
  /// **'Unavailable for this partner'**
  String get unavailableForThisPartner;

  /// No description provided for @rentType.
  ///
  /// In en, this message translates to:
  /// **'Rent type'**
  String get rentType;

  /// No description provided for @rentTypeLabelSelfDrive.
  ///
  /// In en, this message translates to:
  /// **'Self Drive'**
  String get rentTypeLabelSelfDrive;

  /// No description provided for @rentTypeDescriptionSelfDrive.
  ///
  /// In en, this message translates to:
  /// **'Client is allowed to drive the car. Client takes responsibilty for the vehicle'**
  String get rentTypeDescriptionSelfDrive;

  /// No description provided for @rentTypeLabelWithDriver.
  ///
  /// In en, this message translates to:
  /// **'With Driver'**
  String get rentTypeLabelWithDriver;

  /// No description provided for @rentTypeDescriptionWithDriver.
  ///
  /// In en, this message translates to:
  /// **'Driver is provided with the car. Driver takes responsibilty for the vehicle'**
  String get rentTypeDescriptionWithDriver;

  /// No description provided for @onlyWithDriver.
  ///
  /// In en, this message translates to:
  /// **'Only with driver from renter'**
  String get onlyWithDriver;

  /// No description provided for @contacts.
  ///
  /// In en, this message translates to:
  /// **'Contacts'**
  String get contacts;

  /// No description provided for @sameLocation.
  ///
  /// In en, this message translates to:
  /// **'Same location'**
  String get sameLocation;

  /// No description provided for @differentLocation.
  ///
  /// In en, this message translates to:
  /// **'Different location'**
  String get differentLocation;

  /// No description provided for @delivery.
  ///
  /// In en, this message translates to:
  /// **'Delivery'**
  String get delivery;

  /// No description provided for @longTermRentals.
  ///
  /// In en, this message translates to:
  /// **'Long term rentals'**
  String get longTermRentals;

  /// No description provided for @exploreAllCars.
  ///
  /// In en, this message translates to:
  /// **'Explore all cars'**
  String get exploreAllCars;

  /// No description provided for @increase.
  ///
  /// In en, this message translates to:
  /// **'Increase'**
  String get increase;

  /// No description provided for @model.
  ///
  /// In en, this message translates to:
  /// **'Model'**
  String get model;

  /// No description provided for @carModel.
  ///
  /// In en, this message translates to:
  /// **'Car model'**
  String get carModel;

  /// No description provided for @anyCarModel.
  ///
  /// In en, this message translates to:
  /// **'Any car model'**
  String get anyCarModel;

  /// No description provided for @subscription.
  ///
  /// In en, this message translates to:
  /// **'Subscription'**
  String get subscription;

  /// No description provided for @pricing.
  ///
  /// In en, this message translates to:
  /// **'Pricing'**
  String get pricing;

  /// No description provided for @choosePricing.
  ///
  /// In en, this message translates to:
  /// **'Choose pricing'**
  String get choosePricing;

  /// No description provided for @locationMode.
  ///
  /// In en, this message translates to:
  /// **'Location mode'**
  String get locationMode;

  /// No description provided for @chooseLocationMode.
  ///
  /// In en, this message translates to:
  /// **'Choose location mode'**
  String get chooseLocationMode;

  /// No description provided for @month.
  ///
  /// In en, this message translates to:
  /// **'Month'**
  String get month;

  /// No description provided for @months.
  ///
  /// In en, this message translates to:
  /// **'Months'**
  String get months;

  /// No description provided for @noPayments.
  ///
  /// In en, this message translates to:
  /// **'No payments'**
  String get noPayments;

  /// No description provided for @noChanges.
  ///
  /// In en, this message translates to:
  /// **'No changes'**
  String get noChanges;

  /// No description provided for @rentTypeInstruction.
  ///
  /// In en, this message translates to:
  /// **'There are two types of rent'**
  String get rentTypeInstruction;

  /// No description provided for @rentTypeInstructionSD.
  ///
  /// In en, this message translates to:
  /// **'SELF DRIVE - client will drive the car'**
  String get rentTypeInstructionSD;

  /// No description provided for @rentTypeInstructionWD.
  ///
  /// In en, this message translates to:
  /// **'WITH DRIVER - car will be driven by the driver. Client is a passanger'**
  String get rentTypeInstructionWD;

  /// No description provided for @describeWhatHappened.
  ///
  /// In en, this message translates to:
  /// **'Describe what happened'**
  String get describeWhatHappened;

  /// No description provided for @reportedBy.
  ///
  /// In en, this message translates to:
  /// **'Reported by'**
  String get reportedBy;

  /// No description provided for @required.
  ///
  /// In en, this message translates to:
  /// **'Required'**
  String get required;

  /// No description provided for @writeYourNameAndContacts.
  ///
  /// In en, this message translates to:
  /// **'Write your name and contacts'**
  String get writeYourNameAndContacts;

  /// No description provided for @reports.
  ///
  /// In en, this message translates to:
  /// **'Reports'**
  String get reports;

  /// No description provided for @editBooking.
  ///
  /// In en, this message translates to:
  /// **'Edit booking'**
  String get editBooking;

  /// No description provided for @clientRating.
  ///
  /// In en, this message translates to:
  /// **'Client rating'**
  String get clientRating;

  /// No description provided for @selfDrive.
  ///
  /// In en, this message translates to:
  /// **'Self drive'**
  String get selfDrive;

  /// No description provided for @withDriver.
  ///
  /// In en, this message translates to:
  /// **'With driver'**
  String get withDriver;

  /// No description provided for @selfDriveDescription.
  ///
  /// In en, this message translates to:
  /// **'Client is allowed to drive the car. Client takes responsibilty for the vehicle'**
  String get selfDriveDescription;

  /// No description provided for @withDriverDescription.
  ///
  /// In en, this message translates to:
  /// **'Driver is provided with the car. Driver takes responsibilty for the vehicle'**
  String get withDriverDescription;

  /// No description provided for @deleteReport.
  ///
  /// In en, this message translates to:
  /// **'Delete report'**
  String get deleteReport;

  /// No description provided for @youCannotUndoThisAction.
  ///
  /// In en, this message translates to:
  /// **'You cannot undo this action'**
  String get youCannotUndoThisAction;

  /// No description provided for @carCategoriesLimitText.
  ///
  /// In en, this message translates to:
  /// **'You reached your limit of car categories. To add new car categories, delete other car categories or contact support'**
  String get carCategoriesLimitText;

  /// No description provided for @pricingModeInstruction.
  ///
  /// In en, this message translates to:
  /// **'There are 2 modes of pricing'**
  String get pricingModeInstruction;

  /// No description provided for @pricingModeInstructionPerHour.
  ///
  /// In en, this message translates to:
  /// **'PER HOUR - client pays per hour'**
  String get pricingModeInstructionPerHour;

  /// No description provided for @pricingModeInstructionPerDay.
  ///
  /// In en, this message translates to:
  /// **'PER DAY - client pays per day'**
  String get pricingModeInstructionPerDay;

  /// No description provided for @pricePerDay.
  ///
  /// In en, this message translates to:
  /// **'Price per day'**
  String get pricePerDay;

  /// No description provided for @carsLimitText.
  ///
  /// In en, this message translates to:
  /// **'You reached your limit of cars for this category. To add new cars, delete other cars in this category or contact support'**
  String get carsLimitText;

  /// No description provided for @day.
  ///
  /// In en, this message translates to:
  /// **'Day'**
  String get day;

  /// No description provided for @locationsLimitText.
  ///
  /// In en, this message translates to:
  /// **'You reached your limit of locations. To add new locations, delete other locations or contact support'**
  String get locationsLimitText;

  /// No description provided for @searchForExactCarName.
  ///
  /// In en, this message translates to:
  /// **'Gentra: Search for EXACT car model name'**
  String get searchForExactCarName;

  /// No description provided for @searchForNameOfTheLocation.
  ///
  /// In en, this message translates to:
  /// **'Ozod Rent: Search for name of the location'**
  String get searchForNameOfTheLocation;

  /// No description provided for @terminalsLimitText.
  ///
  /// In en, this message translates to:
  /// **'You reached your limit of terminals for this location. To add new terminals, delete other terminals for this location or contact support'**
  String get terminalsLimitText;

  /// No description provided for @paymentModeInstruction.
  ///
  /// In en, this message translates to:
  /// **'There are two pays to receive payments'**
  String get paymentModeInstruction;

  /// No description provided for @paymentModeInstructionNow.
  ///
  /// In en, this message translates to:
  /// **'NOW - client should pay for service before making a booking'**
  String get paymentModeInstructionNow;

  /// No description provided for @paymentModeInstructionLater.
  ///
  /// In en, this message translates to:
  /// **'LATER - client can make a booking without paying. Payment will be done later'**
  String get paymentModeInstructionLater;

  /// No description provided for @contactSupport.
  ///
  /// In en, this message translates to:
  /// **'Contact support'**
  String get contactSupport;

  /// No description provided for @bookingDetails.
  ///
  /// In en, this message translates to:
  /// **'Booking details'**
  String get bookingDetails;

  /// No description provided for @yourPaymentModes.
  ///
  /// In en, this message translates to:
  /// **'Your payment modes'**
  String get yourPaymentModes;

  /// No description provided for @selectBetweenMinutes.
  ///
  /// In en, this message translates to:
  /// **'Select a duration between these limits'**
  String get selectBetweenMinutes;

  /// No description provided for @minutes.
  ///
  /// In en, this message translates to:
  /// **'minutes'**
  String get minutes;

  /// No description provided for @makeBookingAtLeastInAdvance.
  ///
  /// In en, this message translates to:
  /// **'Make booking in advance at least'**
  String get makeBookingAtLeastInAdvance;

  /// No description provided for @rentCar.
  ///
  /// In en, this message translates to:
  /// **'Rent a car'**
  String get rentCar;

  /// No description provided for @sportsAreas.
  ///
  /// In en, this message translates to:
  /// **'Sports areas'**
  String get sportsAreas;

  /// No description provided for @bookingsOfSportsAreas.
  ///
  /// In en, this message translates to:
  /// **'Bookings of sports areas'**
  String get bookingsOfSportsAreas;

  /// No description provided for @carRentals.
  ///
  /// In en, this message translates to:
  /// **'Car rentals'**
  String get carRentals;

  /// No description provided for @other.
  ///
  /// In en, this message translates to:
  /// **'Other'**
  String get other;

  /// No description provided for @chooseOrderType.
  ///
  /// In en, this message translates to:
  /// **'Choose order type'**
  String get chooseOrderType;

  /// No description provided for @sportsLocations.
  ///
  /// In en, this message translates to:
  /// **'Sports locations'**
  String get sportsLocations;

  /// No description provided for @exploreAllSportsLocations.
  ///
  /// In en, this message translates to:
  /// **'Explore all sports locations'**
  String get exploreAllSportsLocations;

  /// No description provided for @bookingCreated.
  ///
  /// In en, this message translates to:
  /// **'Your booking has been successfully created'**
  String get bookingCreated;

  /// No description provided for @sorryThisLocationIsAlreadyBooked.
  ///
  /// In en, this message translates to:
  /// **'Sorry this location is already booked for this time'**
  String get sorryThisLocationIsAlreadyBooked;

  /// No description provided for @locationClosedForThisTime.
  ///
  /// In en, this message translates to:
  /// **'Location is closed for this time'**
  String get locationClosedForThisTime;

  /// No description provided for @weFoundAnotherBooking.
  ///
  /// In en, this message translates to:
  /// **'We found another booking for this time. Please choose another time or location'**
  String get weFoundAnotherBooking;

  /// No description provided for @locationDetails.
  ///
  /// In en, this message translates to:
  /// **'Location details'**
  String get locationDetails;

  /// No description provided for @rent.
  ///
  /// In en, this message translates to:
  /// **'Rent'**
  String get rent;

  /// No description provided for @prepayment.
  ///
  /// In en, this message translates to:
  /// **'Prepayment'**
  String get prepayment;

  /// No description provided for @notifications.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notifications;

  /// No description provided for @noNotifications.
  ///
  /// In en, this message translates to:
  /// **'No notifications'**
  String get noNotifications;

  /// No description provided for @enterDELETE.
  ///
  /// In en, this message translates to:
  /// **'Enter DELETE'**
  String get enterDELETE;

  /// No description provided for @diesel.
  ///
  /// In en, this message translates to:
  /// **'Diesel'**
  String get diesel;

  /// No description provided for @electric.
  ///
  /// In en, this message translates to:
  /// **'Electric'**
  String get electric;

  /// No description provided for @hybrid.
  ///
  /// In en, this message translates to:
  /// **'Hybrid'**
  String get hybrid;

  /// No description provided for @naturalGas.
  ///
  /// In en, this message translates to:
  /// **'Natural gas'**
  String get naturalGas;

  /// No description provided for @petrol.
  ///
  /// In en, this message translates to:
  /// **'Petrol'**
  String get petrol;

  /// No description provided for @userStatusBlocked.
  ///
  /// In en, this message translates to:
  /// **'Blocked'**
  String get userStatusBlocked;

  /// No description provided for @userStatusCreated.
  ///
  /// In en, this message translates to:
  /// **'Created'**
  String get userStatusCreated;

  /// No description provided for @userStatusUnverified.
  ///
  /// In en, this message translates to:
  /// **'Unverified'**
  String get userStatusUnverified;

  /// No description provided for @userStatusVerified.
  ///
  /// In en, this message translates to:
  /// **'Verified'**
  String get userStatusVerified;

  /// No description provided for @blocked.
  ///
  /// In en, this message translates to:
  /// **'Blocked'**
  String get blocked;

  /// No description provided for @failed.
  ///
  /// In en, this message translates to:
  /// **'Failed'**
  String get failed;

  /// No description provided for @warning.
  ///
  /// In en, this message translates to:
  /// **'Warning'**
  String get warning;

  /// No description provided for @passportWarning.
  ///
  /// In en, this message translates to:
  /// **'If you don\'t verify your passport, many partners might refuse to service you. To be able to get all services, verify your passport.'**
  String get passportWarning;

  /// No description provided for @paymentIsAvailableText.
  ///
  /// In en, this message translates to:
  /// **'Payment is available 27 days before the booking'**
  String get paymentIsAvailableText;

  /// No description provided for @anyFuelType.
  ///
  /// In en, this message translates to:
  /// **'Any fuel type'**
  String get anyFuelType;

  /// No description provided for @iAgreeWithRules.
  ///
  /// In en, this message translates to:
  /// **'I agree with the rules'**
  String get iAgreeWithRules;

  /// No description provided for @yourRatingWillBeLowered.
  ///
  /// In en, this message translates to:
  /// **'Your rating will be lowered'**
  String get yourRatingWillBeLowered;

  /// No description provided for @refund.
  ///
  /// In en, this message translates to:
  /// **'Refund'**
  String get refund;

  /// No description provided for @cancellationFee.
  ///
  /// In en, this message translates to:
  /// **'Cancellation fee'**
  String get cancellationFee;

  /// No description provided for @bookingWasCancelled.
  ///
  /// In en, this message translates to:
  /// **'Booking was cancelled'**
  String get bookingWasCancelled;

  /// No description provided for @reason.
  ///
  /// In en, this message translates to:
  /// **'Reason'**
  String get reason;

  /// No description provided for @refundableAmount.
  ///
  /// In en, this message translates to:
  /// **'Refundable amount'**
  String get refundableAmount;

  /// No description provided for @allSports.
  ///
  /// In en, this message translates to:
  /// **'All sports'**
  String get allSports;

  /// No description provided for @notAvailable.
  ///
  /// In en, this message translates to:
  /// **'Not available'**
  String get notAvailable;

  /// No description provided for @onHold.
  ///
  /// In en, this message translates to:
  /// **'On hold'**
  String get onHold;

  /// No description provided for @threeDSecurity.
  ///
  /// In en, this message translates to:
  /// **'3D Security'**
  String get threeDSecurity;

  /// No description provided for @threeDSecurityText.
  ///
  /// In en, this message translates to:
  /// **'You will be redirected to 3d security page. After that we will perform small amount transaction to tokenize your card. The transaction amount will be refunded 100%.'**
  String get threeDSecurityText;

  /// No description provided for @cardSmsCodeText.
  ///
  /// In en, this message translates to:
  /// **'You will receive an SMS with a code. Please enter the code to verify your card. After that we will perform small amount transaction to tokenize your card. The transaction amount will be refunded 100%.'**
  String get cardSmsCodeText;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @editCard.
  ///
  /// In en, this message translates to:
  /// **'Edit card'**
  String get editCard;

  /// No description provided for @editName.
  ///
  /// In en, this message translates to:
  /// **'Edit name'**
  String get editName;

  /// No description provided for @blockToken.
  ///
  /// In en, this message translates to:
  /// **'Block token'**
  String get blockToken;

  /// No description provided for @cardBlocked.
  ///
  /// In en, this message translates to:
  /// **'Card blocked'**
  String get cardBlocked;

  /// No description provided for @cardDeleted.
  ///
  /// In en, this message translates to:
  /// **'Card deleted'**
  String get cardDeleted;

  /// No description provided for @payWithNewCard.
  ///
  /// In en, this message translates to:
  /// **'Pay with new card'**
  String get payWithNewCard;

  /// No description provided for @selectCard.
  ///
  /// In en, this message translates to:
  /// **'Select card'**
  String get selectCard;

  /// No description provided for @payWithCard.
  ///
  /// In en, this message translates to:
  /// **'Pay with card'**
  String get payWithCard;

  /// No description provided for @payWithSavedCard.
  ///
  /// In en, this message translates to:
  /// **'Pay with saved card'**
  String get payWithSavedCard;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @forgotPassword.
  ///
  /// In en, this message translates to:
  /// **'Forgot password'**
  String get forgotPassword;

  /// No description provided for @changePassword.
  ///
  /// In en, this message translates to:
  /// **'Change password'**
  String get changePassword;

  /// No description provided for @minAge.
  ///
  /// In en, this message translates to:
  /// **'Min age'**
  String get minAge;

  /// No description provided for @minAgeError.
  ///
  /// In en, this message translates to:
  /// **'This location has minimum age requirement'**
  String get minAgeError;

  /// No description provided for @years.
  ///
  /// In en, this message translates to:
  /// **'Years'**
  String get years;

  /// No description provided for @verifyEmail.
  ///
  /// In en, this message translates to:
  /// **'Verify email'**
  String get verifyEmail;

  /// No description provided for @verifyEmailText.
  ///
  /// In en, this message translates to:
  /// **'Email verification link was sent to your email. Please verify your email address.'**
  String get verifyEmailText;

  /// No description provided for @emailSent.
  ///
  /// In en, this message translates to:
  /// **'Email is sent'**
  String get emailSent;

  /// No description provided for @emailSentText.
  ///
  /// In en, this message translates to:
  /// **'We sent you an email to reset your password. Please check your email and follow the instructions.'**
  String get emailSentText;

  /// No description provided for @emailSentText2.
  ///
  /// In en, this message translates to:
  /// **'We sent email to reset password'**
  String get emailSentText2;

  /// No description provided for @emailLinked.
  ///
  /// In en, this message translates to:
  /// **'Email linked'**
  String get emailLinked;

  /// No description provided for @linkEmail.
  ///
  /// In en, this message translates to:
  /// **'Link email'**
  String get linkEmail;

  /// No description provided for @passportLinkedToOtherAccount.
  ///
  /// In en, this message translates to:
  /// **'Passport is linked to other account'**
  String get passportLinkedToOtherAccount;

  /// No description provided for @signInWith.
  ///
  /// In en, this message translates to:
  /// **'Sign in with'**
  String get signInWith;

  /// No description provided for @createAccountWithEmail.
  ///
  /// In en, this message translates to:
  /// **'Create account with email'**
  String get createAccountWithEmail;

  /// No description provided for @back.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get back;

  /// No description provided for @authentication.
  ///
  /// In en, this message translates to:
  /// **'Authentication'**
  String get authentication;

  /// No description provided for @googleLinked.
  ///
  /// In en, this message translates to:
  /// **'Google linked'**
  String get googleLinked;

  /// No description provided for @emailAlreadyExists.
  ///
  /// In en, this message translates to:
  /// **'Email already exists'**
  String get emailAlreadyExists;

  /// No description provided for @invalidCredentials.
  ///
  /// In en, this message translates to:
  /// **'Invalid credentials'**
  String get invalidCredentials;

  /// No description provided for @alreadyLinked.
  ///
  /// In en, this message translates to:
  /// **'Already linked'**
  String get alreadyLinked;

  /// No description provided for @linkGoogleAccount.
  ///
  /// In en, this message translates to:
  /// **'Link Google Account'**
  String get linkGoogleAccount;

  /// No description provided for @appleAccountLinked.
  ///
  /// In en, this message translates to:
  /// **'Apple account linked'**
  String get appleAccountLinked;

  /// No description provided for @linkAppleAccount.
  ///
  /// In en, this message translates to:
  /// **'Link Apple account'**
  String get linkAppleAccount;

  /// No description provided for @chooseNextStep.
  ///
  /// In en, this message translates to:
  /// **'Choose next step'**
  String get chooseNextStep;

  /// No description provided for @chooseCar.
  ///
  /// In en, this message translates to:
  /// **'Choose car'**
  String get chooseCar;

  /// No description provided for @orderPaymentInstruction1.
  ///
  /// In en, this message translates to:
  /// **'Pay for your order when you arrive to location'**
  String get orderPaymentInstruction1;

  /// No description provided for @orderPaymentInstruction2.
  ///
  /// In en, this message translates to:
  /// **'No payment information is available'**
  String get orderPaymentInstruction2;

  /// No description provided for @orderInstuctionTitle1.
  ///
  /// In en, this message translates to:
  /// **'Go to the location'**
  String get orderInstuctionTitle1;

  /// No description provided for @orderInstuctionTitle2.
  ///
  /// In en, this message translates to:
  /// **'Your order is active. Partner will start it at start time'**
  String get orderInstuctionTitle2;

  /// No description provided for @orderInstuctionTitle3.
  ///
  /// In en, this message translates to:
  /// **'Enjoy your service'**
  String get orderInstuctionTitle3;

  /// No description provided for @orderInstuctionTitle4.
  ///
  /// In en, this message translates to:
  /// **'Thank you!'**
  String get orderInstuctionTitle4;

  /// No description provided for @orderInstuctionTitleDefault.
  ///
  /// In en, this message translates to:
  /// **'Enjoy your order'**
  String get orderInstuctionTitleDefault;

  /// No description provided for @orderInstuction1.
  ///
  /// In en, this message translates to:
  /// **'It is better to arrive 5 minutes earlier. When you reach the location, pay for your order to activate it. Once you have paid, order status will change to ACTIVE'**
  String get orderInstuction1;

  /// No description provided for @orderInstuction2.
  ///
  /// In en, this message translates to:
  /// **'Your order is paid. Now go to the location and start the order'**
  String get orderInstuction2;

  /// No description provided for @orderInstuction3.
  ///
  /// In en, this message translates to:
  /// **'Enjoy your order. Make sure order status is FINISHED after the end'**
  String get orderInstuction3;

  /// No description provided for @orderInstuction4.
  ///
  /// In en, this message translates to:
  /// **'If you have any questions, feel free to contact us'**
  String get orderInstuction4;

  /// No description provided for @minute.
  ///
  /// In en, this message translates to:
  /// **'Minute'**
  String get minute;

  /// No description provided for @week.
  ///
  /// In en, this message translates to:
  /// **'Week'**
  String get week;

  /// No description provided for @products.
  ///
  /// In en, this message translates to:
  /// **'Services/Products'**
  String get products;

  /// No description provided for @product.
  ///
  /// In en, this message translates to:
  /// **'Service/Product'**
  String get product;

  /// No description provided for @noProducts.
  ///
  /// In en, this message translates to:
  /// **'No Service/Product'**
  String get noProducts;

  /// No description provided for @chooseProduct.
  ///
  /// In en, this message translates to:
  /// **'Choose Service/Product'**
  String get chooseProduct;

  /// No description provided for @productName.
  ///
  /// In en, this message translates to:
  /// **'Service/Product name'**
  String get productName;

  /// No description provided for @conflictingOrdersInfo.
  ///
  /// In en, this message translates to:
  /// **'We found conflicting orders for this Service/Product. Please choose other time or Service/Product'**
  String get conflictingOrdersInfo;

  /// No description provided for @availableClients.
  ///
  /// In en, this message translates to:
  /// **'Available number of clients'**
  String get availableClients;

  /// No description provided for @searchForNameOfTheProduct.
  ///
  /// In en, this message translates to:
  /// **'Search for name of the Service/Product'**
  String get searchForNameOfTheProduct;

  /// No description provided for @chooseThisProduct.
  ///
  /// In en, this message translates to:
  /// **'Choose this Service/Product'**
  String get chooseThisProduct;

  /// No description provided for @changeProduct.
  ///
  /// In en, this message translates to:
  /// **'Change Service/Product'**
  String get changeProduct;

  /// No description provided for @productNotAvailableAtThisTime.
  ///
  /// In en, this message translates to:
  /// **'Service/Product are not available at this time'**
  String get productNotAvailableAtThisTime;

  /// No description provided for @removeAtThisLocation.
  ///
  /// In en, this message translates to:
  /// **'Remove at this location'**
  String get removeAtThisLocation;

  /// No description provided for @removeAtThisLocationText.
  ///
  /// In en, this message translates to:
  /// **'Remove this Service/Product from this location? You can add this product to other locations'**
  String get removeAtThisLocationText;

  /// No description provided for @productNotFound.
  ///
  /// In en, this message translates to:
  /// **'Service/Product not found'**
  String get productNotFound;

  /// No description provided for @loadAllProducts.
  ///
  /// In en, this message translates to:
  /// **'Load all Services/Products'**
  String get loadAllProducts;

  /// No description provided for @tryAgain.
  ///
  /// In en, this message translates to:
  /// **'Try again'**
  String get tryAgain;

  /// No description provided for @productCategory.
  ///
  /// In en, this message translates to:
  /// **'Service/Product category'**
  String get productCategory;

  /// No description provided for @productCategorySportsLocationRental.
  ///
  /// In en, this message translates to:
  /// **'Sports location rental'**
  String get productCategorySportsLocationRental;

  /// No description provided for @productCategorySportsLocationRentalText.
  ///
  /// In en, this message translates to:
  /// **'Renting sport venues to others'**
  String get productCategorySportsLocationRentalText;

  /// No description provided for @productCategoryBarberService.
  ///
  /// In en, this message translates to:
  /// **'Barber service'**
  String get productCategoryBarberService;

  /// No description provided for @productCategoryBarberServiceText.
  ///
  /// In en, this message translates to:
  /// **'Haircuts, beard trims, and other beauty services'**
  String get productCategoryBarberServiceText;

  /// No description provided for @productCategoryEquipmentRental.
  ///
  /// In en, this message translates to:
  /// **'Equipment rental'**
  String get productCategoryEquipmentRental;

  /// No description provided for @productCategoryEquipmentRentalText.
  ///
  /// In en, this message translates to:
  /// **'Renting equipment to others'**
  String get productCategoryEquipmentRentalText;

  /// No description provided for @productCategoryCarRental.
  ///
  /// In en, this message translates to:
  /// **'Car rental'**
  String get productCategoryCarRental;

  /// No description provided for @productCategoryCarRentalText.
  ///
  /// In en, this message translates to:
  /// **'Renting cars to others'**
  String get productCategoryCarRentalText;

  /// No description provided for @productCategoryEventLocationRental.
  ///
  /// In en, this message translates to:
  /// **'Event location rental'**
  String get productCategoryEventLocationRental;

  /// No description provided for @productCategoryEventLocationRentalText.
  ///
  /// In en, this message translates to:
  /// **'Renting event venues to others (arena, hall, etc.)'**
  String get productCategoryEventLocationRentalText;

  /// No description provided for @productCategoryHousingRental.
  ///
  /// In en, this message translates to:
  /// **'Housing rental'**
  String get productCategoryHousingRental;

  /// No description provided for @productCategoryHousingRentalText.
  ///
  /// In en, this message translates to:
  /// **'Renting houses, apartments, rooms to others'**
  String get productCategoryHousingRentalText;

  /// No description provided for @productCategoryPhotoStudioRental.
  ///
  /// In en, this message translates to:
  /// **'Photo studio rental'**
  String get productCategoryPhotoStudioRental;

  /// No description provided for @productCategoryPhotoStudioRentalText.
  ///
  /// In en, this message translates to:
  /// **'Renting photo studios to others'**
  String get productCategoryPhotoStudioRentalText;

  /// No description provided for @productCategoryTutorService.
  ///
  /// In en, this message translates to:
  /// **'Tutor service'**
  String get productCategoryTutorService;

  /// No description provided for @productCategoryTutorServiceText.
  ///
  /// In en, this message translates to:
  /// **'Teaching others'**
  String get productCategoryTutorServiceText;

  /// No description provided for @productCategoryPcGaming.
  ///
  /// In en, this message translates to:
  /// **'PC gaming'**
  String get productCategoryPcGaming;

  /// No description provided for @productCategoryPcGamingText.
  ///
  /// In en, this message translates to:
  /// **'Renting PC and computers to others'**
  String get productCategoryPcGamingText;

  /// No description provided for @productCategoryConsoleGaming.
  ///
  /// In en, this message translates to:
  /// **'Console gaming'**
  String get productCategoryConsoleGaming;

  /// No description provided for @productCategoryConsoleGamingText.
  ///
  /// In en, this message translates to:
  /// **'Renting consoles to others'**
  String get productCategoryConsoleGamingText;

  /// No description provided for @productCategoryGamingCabinRental.
  ///
  /// In en, this message translates to:
  /// **'Gaming cabin rental'**
  String get productCategoryGamingCabinRental;

  /// No description provided for @productCategoryGamingCabinRentalText.
  ///
  /// In en, this message translates to:
  /// **'Renting gaming cabins to others'**
  String get productCategoryGamingCabinRentalText;

  /// No description provided for @productCategoryRestaurant.
  ///
  /// In en, this message translates to:
  /// **'Restaurant booking'**
  String get productCategoryRestaurant;

  /// No description provided for @productCategoryRestaurantText.
  ///
  /// In en, this message translates to:
  /// **'Booking restaurant tables to others'**
  String get productCategoryRestaurantText;

  /// No description provided for @productCategoryPrivateDining.
  ///
  /// In en, this message translates to:
  /// **'Private dining'**
  String get productCategoryPrivateDining;

  /// No description provided for @productCategoryPrivateDiningText.
  ///
  /// In en, this message translates to:
  /// **'Booking private dining rooms'**
  String get productCategoryPrivateDiningText;

  /// No description provided for @productCategoryEventOrganization.
  ///
  /// In en, this message translates to:
  /// **'Event organization'**
  String get productCategoryEventOrganization;

  /// No description provided for @productCategoryEventOrganizationText.
  ///
  /// In en, this message translates to:
  /// **'Organizing events'**
  String get productCategoryEventOrganizationText;

  /// No description provided for @blacklist.
  ///
  /// In en, this message translates to:
  /// **'Blacklist'**
  String get blacklist;

  /// No description provided for @blacklistText.
  ///
  /// In en, this message translates to:
  /// **'Semur found similar accounts with the same passport number in the black list. We suspect that client was black listed. Please contact client. Below are suspected records'**
  String get blacklistText;

  /// No description provided for @cancelClientsFault.
  ///
  /// In en, this message translates to:
  /// **'Cancel (Client\'s fault)'**
  String get cancelClientsFault;

  /// No description provided for @tags.
  ///
  /// In en, this message translates to:
  /// **'Tags'**
  String get tags;

  /// No description provided for @tagsText.
  ///
  /// In en, this message translates to:
  /// **'Tags help clients find you'**
  String get tagsText;

  /// No description provided for @basicInfo.
  ///
  /// In en, this message translates to:
  /// **'Basic info'**
  String get basicInfo;

  /// No description provided for @addProduct.
  ///
  /// In en, this message translates to:
  /// **'Add Service/Product'**
  String get addProduct;

  /// No description provided for @editProduct.
  ///
  /// In en, this message translates to:
  /// **'Edit Service/Product'**
  String get editProduct;

  /// No description provided for @addProductLocationLink.
  ///
  /// In en, this message translates to:
  /// **'Add Service/Product to this location'**
  String get addProductLocationLink;

  /// No description provided for @maxCharacters.
  ///
  /// In en, this message translates to:
  /// **'Max characters'**
  String get maxCharacters;

  /// No description provided for @chooseLocationType.
  ///
  /// In en, this message translates to:
  /// **'Choose location type'**
  String get chooseLocationType;

  /// No description provided for @duration.
  ///
  /// In en, this message translates to:
  /// **'Duration'**
  String get duration;

  /// No description provided for @durationUnit.
  ///
  /// In en, this message translates to:
  /// **'Duration unit'**
  String get durationUnit;

  /// No description provided for @invalid.
  ///
  /// In en, this message translates to:
  /// **'Invalid'**
  String get invalid;

  /// No description provided for @pricingModeInstructionFixed.
  ///
  /// In en, this message translates to:
  /// **'FIXED - price is fixed for all clients'**
  String get pricingModeInstructionFixed;

  /// No description provided for @pricingModeInstructionPerTimeUnit.
  ///
  /// In en, this message translates to:
  /// **'PER TIME UNIT - price is calculated per time unit'**
  String get pricingModeInstructionPerTimeUnit;

  /// No description provided for @productPricingInstructionPrepayment.
  ///
  /// In en, this message translates to:
  /// **'PREPAYMENT PERCENTAGE - part of price which is NON-REFUNDABLE'**
  String get productPricingInstructionPrepayment;

  /// No description provided for @productPricingInstructionLatepayment.
  ///
  /// In en, this message translates to:
  /// **'LATE PAYMENT PERCENTAGE - service fee which is added when user pays later in person, instead of paying online. RECOMMENDED to be 0'**
  String get productPricingInstructionLatepayment;

  /// No description provided for @productPricingInstructionDeposit.
  ///
  /// In en, this message translates to:
  /// **'DEPOSIT - money YOU keep while providing service / product'**
  String get productPricingInstructionDeposit;

  /// No description provided for @prepaymentPercentage.
  ///
  /// In en, this message translates to:
  /// **'Prepayment percentage'**
  String get prepaymentPercentage;

  /// No description provided for @latePaymentPercentage.
  ///
  /// In en, this message translates to:
  /// **'Late payment percentage'**
  String get latePaymentPercentage;

  /// No description provided for @minAgeText.
  ///
  /// In en, this message translates to:
  /// **'Minimum age in years'**
  String get minAgeText;

  /// No description provided for @minClientsPerOrder.
  ///
  /// In en, this message translates to:
  /// **'Min clients per order'**
  String get minClientsPerOrder;

  /// No description provided for @minClientsPerOrderText.
  ///
  /// In en, this message translates to:
  /// **'Minimum number of clients for one order'**
  String get minClientsPerOrderText;

  /// No description provided for @maxClientsPerOrder.
  ///
  /// In en, this message translates to:
  /// **'Max clients per order'**
  String get maxClientsPerOrder;

  /// No description provided for @maxClientsPerOrderText.
  ///
  /// In en, this message translates to:
  /// **'Maximum number of clients for one order'**
  String get maxClientsPerOrderText;

  /// No description provided for @maxOrders.
  ///
  /// In en, this message translates to:
  /// **'Max orders'**
  String get maxOrders;

  /// No description provided for @maxOrdersText.
  ///
  /// In en, this message translates to:
  /// **'Maximum number of orders at the same time'**
  String get maxOrdersText;

  /// No description provided for @maxClients.
  ///
  /// In en, this message translates to:
  /// **'Max clients'**
  String get maxClients;

  /// No description provided for @maxClientsText.
  ///
  /// In en, this message translates to:
  /// **'Max clients for all orders at the same time'**
  String get maxClientsText;

  /// No description provided for @maxClientsForAllOrders.
  ///
  /// In en, this message translates to:
  /// **'Max clients for all orders'**
  String get maxClientsForAllOrders;

  /// No description provided for @numberOfClients.
  ///
  /// In en, this message translates to:
  /// **'Number of clients'**
  String get numberOfClients;

  /// No description provided for @numberOfClientsText.
  ///
  /// In en, this message translates to:
  /// **'Number of clients for this order'**
  String get numberOfClientsText;

  /// No description provided for @minDurationOfOrders.
  ///
  /// In en, this message translates to:
  /// **'Min duration of orders'**
  String get minDurationOfOrders;

  /// No description provided for @maxDurationOfOrders.
  ///
  /// In en, this message translates to:
  /// **'Max duration of orders'**
  String get maxDurationOfOrders;

  /// No description provided for @durationTypeClientBased.
  ///
  /// In en, this message translates to:
  /// **'Client based'**
  String get durationTypeClientBased;

  /// No description provided for @durationTypeClientBasedText.
  ///
  /// In en, this message translates to:
  /// **'CLIENT chooses duration of the service'**
  String get durationTypeClientBasedText;

  /// No description provided for @durationTypeFixed.
  ///
  /// In en, this message translates to:
  /// **'Fixed'**
  String get durationTypeFixed;

  /// No description provided for @durationTypeFixedText.
  ///
  /// In en, this message translates to:
  /// **'Service/Product has FIXED duration for all clients'**
  String get durationTypeFixedText;

  /// No description provided for @productLocationTypeClientBased.
  ///
  /// In en, this message translates to:
  /// **'Client based'**
  String get productLocationTypeClientBased;

  /// No description provided for @productLocationTypeClientBasedText.
  ///
  /// In en, this message translates to:
  /// **'CLIENT chooses on which location Service/Product will be delivered. Example: Client\'s home'**
  String get productLocationTypeClientBasedText;

  /// No description provided for @productLocationTypeHostBased.
  ///
  /// In en, this message translates to:
  /// **'Host based'**
  String get productLocationTypeHostBased;

  /// No description provided for @productLocationTypeHostBasedText.
  ///
  /// In en, this message translates to:
  /// **'HOST chooses on which location Service/Product will be prodvided. Product will be prodvided at the host\'s location'**
  String get productLocationTypeHostBasedText;

  /// No description provided for @hostUserTypeSports.
  ///
  /// In en, this message translates to:
  /// **'Sports'**
  String get hostUserTypeSports;

  /// No description provided for @hostUserTypeGaming.
  ///
  /// In en, this message translates to:
  /// **'Gaming'**
  String get hostUserTypeGaming;

  /// No description provided for @hostUserTypeRestaurant.
  ///
  /// In en, this message translates to:
  /// **'Restaurant'**
  String get hostUserTypeRestaurant;

  /// No description provided for @businessInfo.
  ///
  /// In en, this message translates to:
  /// **'Business information'**
  String get businessInfo;

  /// No description provided for @giveNameToYourBusiness.
  ///
  /// In en, this message translates to:
  /// **'Give a name to your business'**
  String get giveNameToYourBusiness;

  /// No description provided for @businessCategory.
  ///
  /// In en, this message translates to:
  /// **'Business category'**
  String get businessCategory;

  /// No description provided for @chooseBusinessCategory.
  ///
  /// In en, this message translates to:
  /// **'Choose business category'**
  String get chooseBusinessCategory;

  /// No description provided for @productNotAvailable.
  ///
  /// In en, this message translates to:
  /// **'Service/Product not available'**
  String get productNotAvailable;

  /// No description provided for @emailNotVerified.
  ///
  /// In en, this message translates to:
  /// **'Email not verified'**
  String get emailNotVerified;

  /// No description provided for @authError.
  ///
  /// In en, this message translates to:
  /// **'Authentication error'**
  String get authError;

  /// No description provided for @emailNoUserFound.
  ///
  /// In en, this message translates to:
  /// **'No user found with this email'**
  String get emailNoUserFound;

  /// No description provided for @wrongEmailOrPassword.
  ///
  /// In en, this message translates to:
  /// **'Wrong email or password'**
  String get wrongEmailOrPassword;

  /// No description provided for @invalidEmail.
  ///
  /// In en, this message translates to:
  /// **'Invalid email'**
  String get invalidEmail;

  /// No description provided for @weakPassword.
  ///
  /// In en, this message translates to:
  /// **'Weak password'**
  String get weakPassword;

  /// No description provided for @partner.
  ///
  /// In en, this message translates to:
  /// **'Partner'**
  String get partner;

  /// No description provided for @sorryThisProductIsAlreadyBooked.
  ///
  /// In en, this message translates to:
  /// **'Sorry this Service/Product is already booked'**
  String get sorryThisProductIsAlreadyBooked;

  /// No description provided for @sorryThisProductIsNotAvailableForSelectedTimes.
  ///
  /// In en, this message translates to:
  /// **'Sorry this Service/Product is not available for selected times'**
  String get sorryThisProductIsNotAvailableForSelectedTimes;

  /// No description provided for @basketball.
  ///
  /// In en, this message translates to:
  /// **'Basketball'**
  String get basketball;

  /// No description provided for @billiards.
  ///
  /// In en, this message translates to:
  /// **'Billiards'**
  String get billiards;

  /// No description provided for @boxing.
  ///
  /// In en, this message translates to:
  /// **'Boxing'**
  String get boxing;

  /// No description provided for @football.
  ///
  /// In en, this message translates to:
  /// **'Football'**
  String get football;

  /// No description provided for @golf.
  ///
  /// In en, this message translates to:
  /// **'Golf'**
  String get golf;

  /// No description provided for @mma.
  ///
  /// In en, this message translates to:
  /// **'MMA'**
  String get mma;

  /// No description provided for @swimming.
  ///
  /// In en, this message translates to:
  /// **'Swimming'**
  String get swimming;

  /// No description provided for @tableTennis.
  ///
  /// In en, this message translates to:
  /// **'Table tennis'**
  String get tableTennis;

  /// No description provided for @tennis.
  ///
  /// In en, this message translates to:
  /// **'Tennis'**
  String get tennis;

  /// No description provided for @volleyball.
  ///
  /// In en, this message translates to:
  /// **'Volleyball'**
  String get volleyball;

  /// No description provided for @allCategories.
  ///
  /// In en, this message translates to:
  /// **'All categories'**
  String get allCategories;

  /// No description provided for @openLocation.
  ///
  /// In en, this message translates to:
  /// **'Open location'**
  String get openLocation;

  /// No description provided for @makeOrder.
  ///
  /// In en, this message translates to:
  /// **'Make order'**
  String get makeOrder;

  /// No description provided for @map.
  ///
  /// In en, this message translates to:
  /// **'Map'**
  String get map;

  /// No description provided for @needUserVerification.
  ///
  /// In en, this message translates to:
  /// **'Your status is unverified'**
  String get needUserVerification;

  /// No description provided for @needUserVerificationText.
  ///
  /// In en, this message translates to:
  /// **'We recommend to pass verification before booking car rental'**
  String get needUserVerificationText;

  /// No description provided for @verify.
  ///
  /// In en, this message translates to:
  /// **'Verify'**
  String get verify;

  /// No description provided for @gamingClubs.
  ///
  /// In en, this message translates to:
  /// **'Gaming clubs'**
  String get gamingClubs;

  /// No description provided for @exploreAllLocations.
  ///
  /// In en, this message translates to:
  /// **'Explore all locations'**
  String get exploreAllLocations;

  /// No description provided for @gamingTagPlaystation.
  ///
  /// In en, this message translates to:
  /// **'Playstation'**
  String get gamingTagPlaystation;

  /// No description provided for @gamingTagXbox.
  ///
  /// In en, this message translates to:
  /// **'Xbox'**
  String get gamingTagXbox;

  /// No description provided for @gamingTagNintendo.
  ///
  /// In en, this message translates to:
  /// **'Nintendo'**
  String get gamingTagNintendo;

  /// No description provided for @gamingTagPc.
  ///
  /// In en, this message translates to:
  /// **'PC'**
  String get gamingTagPc;

  /// No description provided for @gamingTagCabin.
  ///
  /// In en, this message translates to:
  /// **'Gaming booth/cabin'**
  String get gamingTagCabin;

  /// No description provided for @gamingTagVr.
  ///
  /// In en, this message translates to:
  /// **'VR'**
  String get gamingTagVr;

  /// No description provided for @gamingTagArcade.
  ///
  /// In en, this message translates to:
  /// **'Arcade'**
  String get gamingTagArcade;

  /// No description provided for @gamingTagBoardGames.
  ///
  /// In en, this message translates to:
  /// **'Board games'**
  String get gamingTagBoardGames;

  /// No description provided for @gamingTagCardGames.
  ///
  /// In en, this message translates to:
  /// **'Card games'**
  String get gamingTagCardGames;

  /// No description provided for @viewDocument.
  ///
  /// In en, this message translates to:
  /// **'View document'**
  String get viewDocument;

  /// No description provided for @repeatPassword.
  ///
  /// In en, this message translates to:
  /// **'Repeat password'**
  String get repeatPassword;

  /// No description provided for @passwordsDoNotMatch.
  ///
  /// In en, this message translates to:
  /// **'Passwords do not match'**
  String get passwordsDoNotMatch;

  /// No description provided for @cuisineType.
  ///
  /// In en, this message translates to:
  /// **'Cuisine type'**
  String get cuisineType;

  /// No description provided for @cuisineTypeText.
  ///
  /// In en, this message translates to:
  /// **'Cuisine type of the restaurant'**
  String get cuisineTypeText;

  /// No description provided for @menuLink.
  ///
  /// In en, this message translates to:
  /// **'Menu link'**
  String get menuLink;

  /// No description provided for @averageBill.
  ///
  /// In en, this message translates to:
  /// **'Average bill'**
  String get averageBill;

  /// No description provided for @dressCode.
  ///
  /// In en, this message translates to:
  /// **'Dress code'**
  String get dressCode;

  /// No description provided for @gracePeriod.
  ///
  /// In en, this message translates to:
  /// **'Client Grace period'**
  String get gracePeriod;

  /// No description provided for @restaurants.
  ///
  /// In en, this message translates to:
  /// **'Restaurants'**
  String get restaurants;

  /// No description provided for @restaurantTagOutdoor.
  ///
  /// In en, this message translates to:
  /// **'Outdoor'**
  String get restaurantTagOutdoor;

  /// No description provided for @restaurantTagIndoor.
  ///
  /// In en, this message translates to:
  /// **'Indoor'**
  String get restaurantTagIndoor;

  /// No description provided for @restaurantTagFamily.
  ///
  /// In en, this message translates to:
  /// **'Family'**
  String get restaurantTagFamily;

  /// No description provided for @restaurantTagRomantic.
  ///
  /// In en, this message translates to:
  /// **'Romantic'**
  String get restaurantTagRomantic;

  /// No description provided for @restaurantTagPrivate.
  ///
  /// In en, this message translates to:
  /// **'Private'**
  String get restaurantTagPrivate;

  /// No description provided for @restaurantTagRooftop.
  ///
  /// In en, this message translates to:
  /// **'Rooftop'**
  String get restaurantTagRooftop;

  /// No description provided for @restaurantTagNational.
  ///
  /// In en, this message translates to:
  /// **'National'**
  String get restaurantTagNational;

  /// No description provided for @restaurantTagHalal.
  ///
  /// In en, this message translates to:
  /// **'Halal'**
  String get restaurantTagHalal;

  /// No description provided for @restaurantTagPizza.
  ///
  /// In en, this message translates to:
  /// **'Pizza'**
  String get restaurantTagPizza;

  /// No description provided for @restaurantTagBarbecue.
  ///
  /// In en, this message translates to:
  /// **'Barbecue'**
  String get restaurantTagBarbecue;

  /// No description provided for @restaurantTagSushi.
  ///
  /// In en, this message translates to:
  /// **'Sushi'**
  String get restaurantTagSushi;

  /// No description provided for @restaurantTagGrill.
  ///
  /// In en, this message translates to:
  /// **'Grill'**
  String get restaurantTagGrill;

  /// No description provided for @restaurantTagBurger.
  ///
  /// In en, this message translates to:
  /// **'Burger'**
  String get restaurantTagBurger;

  /// No description provided for @restaurantTagRussian.
  ///
  /// In en, this message translates to:
  /// **'Russian'**
  String get restaurantTagRussian;

  /// No description provided for @restaurantTagMeat.
  ///
  /// In en, this message translates to:
  /// **'Meat'**
  String get restaurantTagMeat;

  /// No description provided for @restaurantTagBistro.
  ///
  /// In en, this message translates to:
  /// **'Bistro'**
  String get restaurantTagBistro;

  /// No description provided for @restaurantTagCafe.
  ///
  /// In en, this message translates to:
  /// **'Cafe'**
  String get restaurantTagCafe;

  /// No description provided for @restaurantTagUzbek.
  ///
  /// In en, this message translates to:
  /// **'Uzbek'**
  String get restaurantTagUzbek;

  /// No description provided for @restaurantTagItalian.
  ///
  /// In en, this message translates to:
  /// **'Italian'**
  String get restaurantTagItalian;

  /// No description provided for @restaurantTagJapanese.
  ///
  /// In en, this message translates to:
  /// **'Japanese'**
  String get restaurantTagJapanese;

  /// No description provided for @restaurantTagChinese.
  ///
  /// In en, this message translates to:
  /// **'Chinese'**
  String get restaurantTagChinese;

  /// No description provided for @restaurantTagIndian.
  ///
  /// In en, this message translates to:
  /// **'Indian'**
  String get restaurantTagIndian;

  /// No description provided for @restaurantTagMexican.
  ///
  /// In en, this message translates to:
  /// **'Mexican'**
  String get restaurantTagMexican;

  /// No description provided for @restaurantTagFrench.
  ///
  /// In en, this message translates to:
  /// **'French'**
  String get restaurantTagFrench;

  /// No description provided for @restaurantTagGreek.
  ///
  /// In en, this message translates to:
  /// **'Greek'**
  String get restaurantTagGreek;

  /// No description provided for @restaurantTagThai.
  ///
  /// In en, this message translates to:
  /// **'Thai'**
  String get restaurantTagThai;

  /// No description provided for @restaurantTagKorean.
  ///
  /// In en, this message translates to:
  /// **'Korean'**
  String get restaurantTagKorean;

  /// No description provided for @restaurantTagSpanish.
  ///
  /// In en, this message translates to:
  /// **'Spanish'**
  String get restaurantTagSpanish;

  /// No description provided for @restaurantTagTurkish.
  ///
  /// In en, this message translates to:
  /// **'Turkish'**
  String get restaurantTagTurkish;

  /// No description provided for @restaurantTagVietnamese.
  ///
  /// In en, this message translates to:
  /// **'Vietnamese'**
  String get restaurantTagVietnamese;

  /// No description provided for @restaurantTagMiddleEastern.
  ///
  /// In en, this message translates to:
  /// **'Middle Eastern'**
  String get restaurantTagMiddleEastern;

  /// No description provided for @restaurantTagEuropean.
  ///
  /// In en, this message translates to:
  /// **'European'**
  String get restaurantTagEuropean;

  /// No description provided for @restaurantTagAmerican.
  ///
  /// In en, this message translates to:
  /// **'American'**
  String get restaurantTagAmerican;

  /// No description provided for @restaurantTagFastFood.
  ///
  /// In en, this message translates to:
  /// **'Fast food'**
  String get restaurantTagFastFood;

  /// No description provided for @restaurantTagSeafood.
  ///
  /// In en, this message translates to:
  /// **'Seafood'**
  String get restaurantTagSeafood;

  /// No description provided for @restaurantTagVegetarian.
  ///
  /// In en, this message translates to:
  /// **'Vegetarian'**
  String get restaurantTagVegetarian;

  /// No description provided for @restaurantTagVegan.
  ///
  /// In en, this message translates to:
  /// **'Vegan'**
  String get restaurantTagVegan;

  /// No description provided for @viewAllProducts.
  ///
  /// In en, this message translates to:
  /// **'View all Services/Products'**
  String get viewAllProducts;

  /// No description provided for @menu.
  ///
  /// In en, this message translates to:
  /// **'Menu'**
  String get menu;

  /// No description provided for @openMenuLink.
  ///
  /// In en, this message translates to:
  /// **'Open menu link'**
  String get openMenuLink;

  /// No description provided for @mon.
  ///
  /// In en, this message translates to:
  /// **'Mon'**
  String get mon;

  /// No description provided for @tue.
  ///
  /// In en, this message translates to:
  /// **'Tue'**
  String get tue;

  /// No description provided for @wed.
  ///
  /// In en, this message translates to:
  /// **'Wed'**
  String get wed;

  /// No description provided for @thu.
  ///
  /// In en, this message translates to:
  /// **'Thu'**
  String get thu;

  /// No description provided for @fri.
  ///
  /// In en, this message translates to:
  /// **'Fri'**
  String get fri;

  /// No description provided for @sat.
  ///
  /// In en, this message translates to:
  /// **'Sat'**
  String get sat;

  /// No description provided for @sun.
  ///
  /// In en, this message translates to:
  /// **'Sun'**
  String get sun;

  /// No description provided for @contactInfo.
  ///
  /// In en, this message translates to:
  /// **'Contact info'**
  String get contactInfo;

  /// No description provided for @unverified.
  ///
  /// In en, this message translates to:
  /// **'Unverified'**
  String get unverified;

  /// No description provided for @verified.
  ///
  /// In en, this message translates to:
  /// **'Verified'**
  String get verified;

  /// No description provided for @deleted.
  ///
  /// In en, this message translates to:
  /// **'Deleted'**
  String get deleted;

  /// No description provided for @filter.
  ///
  /// In en, this message translates to:
  /// **'Filter'**
  String get filter;

  /// No description provided for @bookRestaurantTable.
  ///
  /// In en, this message translates to:
  /// **'Book restaurant table'**
  String get bookRestaurantTable;

  /// No description provided for @nationalFood.
  ///
  /// In en, this message translates to:
  /// **'National food'**
  String get nationalFood;

  /// No description provided for @gamingCabin.
  ///
  /// In en, this message translates to:
  /// **'Gaming cabin'**
  String get gamingCabin;

  /// No description provided for @tryTheBestRestaurantsIn.
  ///
  /// In en, this message translates to:
  /// **'Try the best restaurants in'**
  String get tryTheBestRestaurantsIn;

  /// No description provided for @nearYou.
  ///
  /// In en, this message translates to:
  /// **'Near you'**
  String get nearYou;

  /// No description provided for @locationPermissionNeeded.
  ///
  /// In en, this message translates to:
  /// **'Location permission needed'**
  String get locationPermissionNeeded;

  /// No description provided for @addFloorPlan.
  ///
  /// In en, this message translates to:
  /// **'Add floor plan'**
  String get addFloorPlan;

  /// No description provided for @floorPlan.
  ///
  /// In en, this message translates to:
  /// **'Floor plan'**
  String get floorPlan;

  /// No description provided for @floorPlans.
  ///
  /// In en, this message translates to:
  /// **'Floor plans'**
  String get floorPlans;

  /// No description provided for @addFloorPlanPlace.
  ///
  /// In en, this message translates to:
  /// **'Add floor plan place'**
  String get addFloorPlanPlace;

  /// No description provided for @floorPlanPlace.
  ///
  /// In en, this message translates to:
  /// **'Floor plan place (Table, sofa, etc.)'**
  String get floorPlanPlace;

  /// No description provided for @floorPlanPlaces.
  ///
  /// In en, this message translates to:
  /// **'Floor plan places'**
  String get floorPlanPlaces;

  /// No description provided for @chooseFloorPlanPlace.
  ///
  /// In en, this message translates to:
  /// **'Choose floor plan place'**
  String get chooseFloorPlanPlace;

  /// No description provided for @floorPlanPlaneNotAvailable.
  ///
  /// In en, this message translates to:
  /// **'This floor plan place is not available'**
  String get floorPlanPlaneNotAvailable;

  /// No description provided for @floorPlanPlaneNotAvailableAtThisTime.
  ///
  /// In en, this message translates to:
  /// **'This place is not available at this time'**
  String get floorPlanPlaneNotAvailableAtThisTime;

  /// No description provided for @floorPlanPlaceNotEnoughCapacity.
  ///
  /// In en, this message translates to:
  /// **'This place is too small for this number of clients'**
  String get floorPlanPlaceNotEnoughCapacity;

  /// No description provided for @table.
  ///
  /// In en, this message translates to:
  /// **'Table'**
  String get table;

  /// No description provided for @tables.
  ///
  /// In en, this message translates to:
  /// **'Tables'**
  String get tables;

  /// No description provided for @imageSizeTooLarge.
  ///
  /// In en, this message translates to:
  /// **'Image size is too large'**
  String get imageSizeTooLarge;

  /// No description provided for @youCanZoomInAndOut.
  ///
  /// In en, this message translates to:
  /// **'You can zoom in and out'**
  String get youCanZoomInAndOut;

  /// No description provided for @filters.
  ///
  /// In en, this message translates to:
  /// **'Filters'**
  String get filters;

  /// No description provided for @expandToFullScreen.
  ///
  /// In en, this message translates to:
  /// **'Expand to full screen'**
  String get expandToFullScreen;

  /// No description provided for @yourLink.
  ///
  /// In en, this message translates to:
  /// **'Your link'**
  String get yourLink;

  /// No description provided for @optional.
  ///
  /// In en, this message translates to:
  /// **'Optional'**
  String get optional;

  /// No description provided for @list.
  ///
  /// In en, this message translates to:
  /// **'List'**
  String get list;

  /// No description provided for @locations.
  ///
  /// In en, this message translates to:
  /// **'Locations'**
  String get locations;

  /// No description provided for @description.
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get description;

  /// No description provided for @orderQrInstruction.
  ///
  /// In en, this message translates to:
  /// **'Show this QR code to the employee / partner'**
  String get orderQrInstruction;

  /// No description provided for @pleaseConfirmYourPhone.
  ///
  /// In en, this message translates to:
  /// **'Please confirm your phone number'**
  String get pleaseConfirmYourPhone;

  /// No description provided for @check.
  ///
  /// In en, this message translates to:
  /// **'Check'**
  String get check;

  /// No description provided for @returnBack.
  ///
  /// In en, this message translates to:
  /// **'Return back'**
  String get returnBack;

  /// No description provided for @noMoreLocations.
  ///
  /// In en, this message translates to:
  /// **'No more locations'**
  String get noMoreLocations;

  /// No description provided for @numberOfClientsExceedsTheMaximumAllowedClientsPerOrder.
  ///
  /// In en, this message translates to:
  /// **'Number of clients exceeds the maximum allowed clients per order'**
  String get numberOfClientsExceedsTheMaximumAllowedClientsPerOrder;

  /// No description provided for @numberOfClientsIsLessThanTheMinimumAllowedClientsPerOrder.
  ///
  /// In en, this message translates to:
  /// **'Number of clients is less than the minimum allowed clients per order'**
  String get numberOfClientsIsLessThanTheMinimumAllowedClientsPerOrder;

  /// No description provided for @pleaseChooseAnotherOne.
  ///
  /// In en, this message translates to:
  /// **'Please choose another one'**
  String get pleaseChooseAnotherOne;

  /// No description provided for @whatIsRating.
  ///
  /// In en, this message translates to:
  /// **'What is rating?'**
  String get whatIsRating;

  /// No description provided for @ratingExplanation.
  ///
  /// In en, this message translates to:
  /// **'Rating is a score from 1 to 100, which is given to clients based on their behavior during bookings. Higher rating clients are prioritized by partners when accepting bookings. To increase your rating, make more bookings, avoid cancellations, late arrivals, and any violations of rules during bookings.'**
  String get ratingExplanation;

  /// No description provided for @close.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get close;

  /// No description provided for @userInfo.
  ///
  /// In en, this message translates to:
  /// **'User info'**
  String get userInfo;

  /// No description provided for @category.
  ///
  /// In en, this message translates to:
  /// **'Category'**
  String get category;

  /// No description provided for @workingHours.
  ///
  /// In en, this message translates to:
  /// **'Working hours'**
  String get workingHours;

  /// No description provided for @noError.
  ///
  /// In en, this message translates to:
  /// **'No error'**
  String get noError;

  /// No description provided for @errorBadRequest.
  ///
  /// In en, this message translates to:
  /// **'Wrong request'**
  String get errorBadRequest;

  /// No description provided for @errorUnauthorized.
  ///
  /// In en, this message translates to:
  /// **'You are not authorized to perform this action'**
  String get errorUnauthorized;

  /// No description provided for @errorNotFound.
  ///
  /// In en, this message translates to:
  /// **'Not found'**
  String get errorNotFound;

  /// No description provided for @errorMethodNotAllowed.
  ///
  /// In en, this message translates to:
  /// **'Method not allowed'**
  String get errorMethodNotAllowed;

  /// No description provided for @errorConflict.
  ///
  /// In en, this message translates to:
  /// **'Conflict. Try again later'**
  String get errorConflict;

  /// No description provided for @errorTooManyRequests.
  ///
  /// In en, this message translates to:
  /// **'Too many requests. Try again later'**
  String get errorTooManyRequests;

  /// No description provided for @errorUnavailable.
  ///
  /// In en, this message translates to:
  /// **'Service is unavailable. Try again later'**
  String get errorUnavailable;

  /// No description provided for @errorPermissionDenied.
  ///
  /// In en, this message translates to:
  /// **'Permission denied'**
  String get errorPermissionDenied;

  /// No description provided for @errorUserRatingError.
  ///
  /// In en, this message translates to:
  /// **'Error updating user rating'**
  String get errorUserRatingError;

  /// No description provided for @errorWrongOrderStatus.
  ///
  /// In en, this message translates to:
  /// **'Wrong order status'**
  String get errorWrongOrderStatus;

  /// No description provided for @errorOrderWrongPaymentStatus.
  ///
  /// In en, this message translates to:
  /// **'Wrong order payment status'**
  String get errorOrderWrongPaymentStatus;

  /// No description provided for @errorOrderPaymentNotFound.
  ///
  /// In en, this message translates to:
  /// **'Order payment not found'**
  String get errorOrderPaymentNotFound;

  /// No description provided for @errorOrderNotFound.
  ///
  /// In en, this message translates to:
  /// **'Order not found'**
  String get errorOrderNotFound;

  /// No description provided for @errorOrderPaymentError.
  ///
  /// In en, this message translates to:
  /// **'Order payment error'**
  String get errorOrderPaymentError;

  /// No description provided for @errorProductPricingNotFound.
  ///
  /// In en, this message translates to:
  /// **'Product pricing not found. Try different product'**
  String get errorProductPricingNotFound;

  /// No description provided for @errorProductClientsNumberExceedsMaximumPerOrder.
  ///
  /// In en, this message translates to:
  /// **'Number of clients exceeds the maximum allowed clients for this product'**
  String get errorProductClientsNumberExceedsMaximumPerOrder;

  /// No description provided for @errorProductClientsNumberLessThanMinimumPerOrder.
  ///
  /// In en, this message translates to:
  /// **'Number of clients is less than the minimum required clients for this product'**
  String get errorProductClientsNumberLessThanMinimumPerOrder;

  /// No description provided for @errorProductNotAvailable.
  ///
  /// In en, this message translates to:
  /// **'Product is not available or already booked for chosen time'**
  String get errorProductNotAvailable;

  /// No description provided for @errorProductClientsNumberExceedsAvailable.
  ///
  /// In en, this message translates to:
  /// **'Number of clients exceeds the available spaces for this product. Try reducing the number of clients'**
  String get errorProductClientsNumberExceedsAvailable;

  /// No description provided for @errorProductFloorPlanPlaceNotAvailable.
  ///
  /// In en, this message translates to:
  /// **'Floor plan place is not available or already booked for chosen time'**
  String get errorProductFloorPlanPlaceNotAvailable;

  /// No description provided for @errorProductFloorPlanPlaceNotEnoughCapacity.
  ///
  /// In en, this message translates to:
  /// **'Floor plan place is too small for this number of clients'**
  String get errorProductFloorPlanPlaceNotEnoughCapacity;

  /// No description provided for @errorHostUserUpdateBalanceError.
  ///
  /// In en, this message translates to:
  /// **'Error updating host user balance'**
  String get errorHostUserUpdateBalanceError;

  /// No description provided for @client.
  ///
  /// In en, this message translates to:
  /// **'Client'**
  String get client;

  /// No description provided for @unknown.
  ///
  /// In en, this message translates to:
  /// **'Unknown'**
  String get unknown;

  /// No description provided for @userNotFound.
  ///
  /// In en, this message translates to:
  /// **'User not found'**
  String get userNotFound;

  /// No description provided for @wrongEmail.
  ///
  /// In en, this message translates to:
  /// **'Wrong email'**
  String get wrongEmail;

  /// No description provided for @expiredActionCode.
  ///
  /// In en, this message translates to:
  /// **'Code expired try again'**
  String get expiredActionCode;

  /// No description provided for @invalidActionCode.
  ///
  /// In en, this message translates to:
  /// **'Invalid code'**
  String get invalidActionCode;

  /// No description provided for @hi.
  ///
  /// In en, this message translates to:
  /// **'Hi'**
  String get hi;

  /// No description provided for @searchById.
  ///
  /// In en, this message translates to:
  /// **'Search by ID'**
  String get searchById;

  /// No description provided for @chooseCategory.
  ///
  /// In en, this message translates to:
  /// **'Choose category'**
  String get chooseCategory;

  /// No description provided for @integrations.
  ///
  /// In en, this message translates to:
  /// **'Integrations'**
  String get integrations;

  /// No description provided for @noUserConnections.
  ///
  /// In en, this message translates to:
  /// **'No user connections found'**
  String get noUserConnections;

  /// No description provided for @availableIntegrations.
  ///
  /// In en, this message translates to:
  /// **'Available integrations'**
  String get availableIntegrations;

  /// No description provided for @integrationGmailDescription.
  ///
  /// In en, this message translates to:
  /// **'Read your emails and manage your inbox'**
  String get integrationGmailDescription;

  /// No description provided for @integrationGoogleCalendarDescription.
  ///
  /// In en, this message translates to:
  /// **'View and manage your Google Calendar events'**
  String get integrationGoogleCalendarDescription;

  /// No description provided for @addIntegration.
  ///
  /// In en, this message translates to:
  /// **'Add Integration'**
  String get addIntegration;

  /// No description provided for @terms.
  ///
  /// In en, this message translates to:
  /// **'By continuing, you accept all terms of use of the app and the Privacy Policy'**
  String get terms;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en', 'ru', 'uz'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en': return AppLocalizationsEn();
    case 'ru': return AppLocalizationsRu();
    case 'uz': return AppLocalizationsUz();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
