// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Portalixmx';

  @override
  String get guardLogin => 'Guard Login';

  @override
  String get email => 'Email';

  @override
  String get password => 'Password';

  @override
  String get login => 'Login';

  @override
  String get forgetPassword => 'Forget your password';

  @override
  String welcomeMessage(Object name) {
    return 'Welcome $name!';
  }

  @override
  String get visitors => 'Visitors';

  @override
  String get logs => 'Logs';

  @override
  String get accessRequests => 'Access Requests';

  @override
  String get poolAccess => 'Pool Access';

  @override
  String get add => 'Add';

  @override
  String get twoStepVerification => '2 Step Verification';

  @override
  String get twoStepVerificationDescription =>
      'Enter the 2 step verification code sent on your email address';

  @override
  String get otp => 'OTP';

  @override
  String get submit => 'Submit';

  @override
  String get needHelp => 'Need Help';

  @override
  String get invalidOTPMessage => 'Invalid otp, Try again';

  @override
  String get home => 'Home';

  @override
  String get securityAlerts => 'Security Alerts';

  @override
  String get reports => 'Reports';

  @override
  String get menu => 'Menu';

  @override
  String get guest => 'Guest';

  @override
  String get deleteVisitor => 'Delete Visitor';

  @override
  String get regularVisitor => 'Regular Visitor';

  @override
  String get requestedTime => 'REQUESTED TIME';

  @override
  String get accessFor => 'Access For';

  @override
  String get teacher => 'Teacher';

  @override
  String get accessApprovedDate => 'Access Approved Date';

  @override
  String get contactNum => 'Contact No';

  @override
  String get edit => 'Edit';

  @override
  String get delete => 'Delete';

  @override
  String get from => 'From';

  @override
  String get to => 'To';

  @override
  String get shareKey => 'Share Key';

  @override
  String get qrCode => 'QR CODE';

  @override
  String get paymentsAndBilling => 'Payments & Billing';

  @override
  String get currentService => 'Current Service';

  @override
  String get otherServices => 'Other Services';

  @override
  String get serviceName => 'Service Name';

  @override
  String get cleaningOfCommonAreas => 'Cleaning of common areas';

  @override
  String get garbageCollection => 'Garbage Collection';

  @override
  String get complaint => 'Complaint';

  @override
  String get uploadPhotos => 'Upload Photos';

  @override
  String get openCamera => 'Open Camera';

  @override
  String get requestAccess => 'Request Access';

  @override
  String get viewProfile => 'View Profile';

  @override
  String get directory => 'Directory';

  @override
  String get communityCalendar => 'Community Calendar';

  @override
  String get communityPolls => 'Community Polls';

  @override
  String get guards => 'Guards';

  @override
  String get carPooling => 'Car Pooling';

  @override
  String get emergencyCalls => 'Emergency Calls';

  @override
  String get privacyPolicy => 'Privacy Policy';

  @override
  String get logout => 'Logout';

  @override
  String get search => 'Search';

  @override
  String get guardTracking => 'Guard Tracking';

  @override
  String get name => 'Name';

  @override
  String get phone => 'Phone';

  @override
  String get emergencyContacts => 'Emergency Contacts';

  @override
  String get vehicleInformation => 'Vehicle Information';

  @override
  String get vehicleName => 'Vehicle Name';

  @override
  String get licensePlateNumber => 'License Plate Number';

  @override
  String get registrationNumber => 'Registration Number';

  @override
  String get update => 'Update';

  @override
  String get color => 'Color';

  @override
  String get profile => 'Profile';

  @override
  String get editProfile => 'Edit Profile';

  @override
  String updateYour(Object userInfo) {
    return 'Update your $userInfo';
  }

  @override
  String get addGuest => 'Add Guest';

  @override
  String get editGuest => 'Edit Guest';

  @override
  String get deleteComplaint => 'Delete Complaint';

  @override
  String get profileInfoUpdated => 'Profile information updated';

  @override
  String get guestVerified => 'Guest Verified';

  @override
  String get carPlateNumber => 'Car Plate Number';

  @override
  String get vehicleModel => 'Vehicle Model';

  @override
  String get time => 'Time';

  @override
  String userAddedMsg(Object user, Object userType) {
    return '$user has been added as a $userType';
  }

  @override
  String userUpdatedMsg(Object user) {
    return '$user has been updated';
  }

  @override
  String get today => 'Today';

  @override
  String get yesterday => 'Yesterday';

  @override
  String get scanQRCode => 'Scan QR Code';

  @override
  String get scanningWillStartAutomatically =>
      'Scanning will start automatically';

  @override
  String get userHasBeenDeleted => 'User has been deleted successfully';

  @override
  String get failedToDeleteUser => 'Failed to delete user, Try again';

  @override
  String get writeAboutTheReport => 'Write about the report';

  @override
  String imageUploaded(Object imageNum) {
    return 'Image $imageNum';
  }

  @override
  String get aboutReport => 'About Report';

  @override
  String get deleteReport => 'Delete Report';

  @override
  String get emergencyCommunication => 'Emergency Communication';
}
