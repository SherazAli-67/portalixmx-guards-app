import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_es.dart';

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
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

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
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('es'),
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'Portalixmx'**
  String get appTitle;

  /// No description provided for @residentLogin.
  ///
  /// In en, this message translates to:
  /// **'Resident Login'**
  String get residentLogin;

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @login.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get login;

  /// No description provided for @forgetPassword.
  ///
  /// In en, this message translates to:
  /// **'Forget your password'**
  String get forgetPassword;

  /// No description provided for @welcomeMessage.
  ///
  /// In en, this message translates to:
  /// **'Welcome {name}'**
  String welcomeMessage(Object name);

  /// No description provided for @regularVisitors.
  ///
  /// In en, this message translates to:
  /// **'Regular Visitors'**
  String get regularVisitors;

  /// No description provided for @guest.
  ///
  /// In en, this message translates to:
  /// **'Guest'**
  String get guest;

  /// No description provided for @accessRequests.
  ///
  /// In en, this message translates to:
  /// **'Access Requests'**
  String get accessRequests;

  /// No description provided for @poolAccess.
  ///
  /// In en, this message translates to:
  /// **'Pool Access'**
  String get poolAccess;

  /// No description provided for @add.
  ///
  /// In en, this message translates to:
  /// **'Add'**
  String get add;

  /// No description provided for @twoStepVerification.
  ///
  /// In en, this message translates to:
  /// **'2 Step Verification'**
  String get twoStepVerification;

  /// No description provided for @twoStepVerificationDescription.
  ///
  /// In en, this message translates to:
  /// **'Enter the 2 step verification code sent on your email address'**
  String get twoStepVerificationDescription;

  /// No description provided for @otp.
  ///
  /// In en, this message translates to:
  /// **'OTP'**
  String get otp;

  /// No description provided for @submit.
  ///
  /// In en, this message translates to:
  /// **'Submit'**
  String get submit;

  /// No description provided for @needHelp.
  ///
  /// In en, this message translates to:
  /// **'Need Help'**
  String get needHelp;

  /// No description provided for @home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// No description provided for @payments.
  ///
  /// In en, this message translates to:
  /// **'Payments'**
  String get payments;

  /// No description provided for @maintenance.
  ///
  /// In en, this message translates to:
  /// **'Maintenance'**
  String get maintenance;

  /// No description provided for @access.
  ///
  /// In en, this message translates to:
  /// **'Access'**
  String get access;

  /// No description provided for @menu.
  ///
  /// In en, this message translates to:
  /// **'Menu'**
  String get menu;

  /// No description provided for @regularVisitor.
  ///
  /// In en, this message translates to:
  /// **'Regular Visitor'**
  String get regularVisitor;

  /// No description provided for @requestedTime.
  ///
  /// In en, this message translates to:
  /// **'REQUESTED TIME'**
  String get requestedTime;

  /// No description provided for @accessFor.
  ///
  /// In en, this message translates to:
  /// **'Access For'**
  String get accessFor;

  /// No description provided for @teacher.
  ///
  /// In en, this message translates to:
  /// **'Teacher'**
  String get teacher;

  /// No description provided for @accessApprovedDate.
  ///
  /// In en, this message translates to:
  /// **'Access Approved Date'**
  String get accessApprovedDate;

  /// No description provided for @contactNum.
  ///
  /// In en, this message translates to:
  /// **'Contact No'**
  String get contactNum;

  /// No description provided for @edit.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get edit;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

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

  /// No description provided for @shareKey.
  ///
  /// In en, this message translates to:
  /// **'Share Key'**
  String get shareKey;

  /// No description provided for @qrCode.
  ///
  /// In en, this message translates to:
  /// **'QR CODE'**
  String get qrCode;

  /// No description provided for @paymentsAndBilling.
  ///
  /// In en, this message translates to:
  /// **'Payments & Billing'**
  String get paymentsAndBilling;

  /// No description provided for @currentService.
  ///
  /// In en, this message translates to:
  /// **'Current Service'**
  String get currentService;

  /// No description provided for @otherServices.
  ///
  /// In en, this message translates to:
  /// **'Other Services'**
  String get otherServices;

  /// No description provided for @serviceName.
  ///
  /// In en, this message translates to:
  /// **'Service Name'**
  String get serviceName;

  /// No description provided for @cleaningOfCommonAreas.
  ///
  /// In en, this message translates to:
  /// **'Cleaning of common areas'**
  String get cleaningOfCommonAreas;

  /// No description provided for @garbageCollection.
  ///
  /// In en, this message translates to:
  /// **'Garbage Collection'**
  String get garbageCollection;

  /// No description provided for @complaint.
  ///
  /// In en, this message translates to:
  /// **'Complaint'**
  String get complaint;

  /// No description provided for @uploadPhotos.
  ///
  /// In en, this message translates to:
  /// **'Upload Photos'**
  String get uploadPhotos;

  /// No description provided for @openCamera.
  ///
  /// In en, this message translates to:
  /// **'Open Camera'**
  String get openCamera;

  /// No description provided for @requestAccess.
  ///
  /// In en, this message translates to:
  /// **'Request Access'**
  String get requestAccess;

  /// No description provided for @viewProfile.
  ///
  /// In en, this message translates to:
  /// **'View Profile'**
  String get viewProfile;

  /// No description provided for @directory.
  ///
  /// In en, this message translates to:
  /// **'Directory'**
  String get directory;

  /// No description provided for @communityCalendar.
  ///
  /// In en, this message translates to:
  /// **'Community Calendar'**
  String get communityCalendar;

  /// No description provided for @communityPolls.
  ///
  /// In en, this message translates to:
  /// **'Community Polls'**
  String get communityPolls;

  /// No description provided for @guards.
  ///
  /// In en, this message translates to:
  /// **'Guards'**
  String get guards;

  /// No description provided for @carPooling.
  ///
  /// In en, this message translates to:
  /// **'Car Pooling'**
  String get carPooling;

  /// No description provided for @emergencyCalls.
  ///
  /// In en, this message translates to:
  /// **'Emergency Calls'**
  String get emergencyCalls;

  /// No description provided for @privacyPolicy.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get privacyPolicy;

  /// No description provided for @logout.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logout;

  /// No description provided for @search.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get search;

  /// No description provided for @guardTracking.
  ///
  /// In en, this message translates to:
  /// **'Guard Tracking'**
  String get guardTracking;

  /// No description provided for @name.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get name;

  /// No description provided for @phone.
  ///
  /// In en, this message translates to:
  /// **'Phone'**
  String get phone;

  /// No description provided for @emergencyContacts.
  ///
  /// In en, this message translates to:
  /// **'Emergency Contacts'**
  String get emergencyContacts;

  /// No description provided for @vehicleInformation.
  ///
  /// In en, this message translates to:
  /// **'Vehicle Information'**
  String get vehicleInformation;

  /// No description provided for @vehicleName.
  ///
  /// In en, this message translates to:
  /// **'Vehicle Name'**
  String get vehicleName;

  /// No description provided for @licensePlateNumber.
  ///
  /// In en, this message translates to:
  /// **'License Plate Number'**
  String get licensePlateNumber;

  /// No description provided for @registrationNumber.
  ///
  /// In en, this message translates to:
  /// **'Registration Number'**
  String get registrationNumber;

  /// No description provided for @update.
  ///
  /// In en, this message translates to:
  /// **'Update'**
  String get update;

  /// No description provided for @color.
  ///
  /// In en, this message translates to:
  /// **'Color'**
  String get color;

  /// No description provided for @profile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile;

  /// No description provided for @editProfile.
  ///
  /// In en, this message translates to:
  /// **'Edit Profile'**
  String get editProfile;

  /// No description provided for @updateYour.
  ///
  /// In en, this message translates to:
  /// **'Update your {userInfo}'**
  String updateYour(Object userInfo);

  /// No description provided for @addGuest.
  ///
  /// In en, this message translates to:
  /// **'Add Guest'**
  String get addGuest;

  /// No description provided for @deleteComplaint.
  ///
  /// In en, this message translates to:
  /// **'Delete Complaint'**
  String get deleteComplaint;

  /// No description provided for @profileInfoUpdated.
  ///
  /// In en, this message translates to:
  /// **'Profile information updated'**
  String get profileInfoUpdated;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'es'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
