import 'guest_api_response.dart';
import 'visitor_api_response.dart';

class VerifiedUser {
  final dynamic user; // Guest or Visitor
  final DateTime logsIn;
  DateTime? logsOut;

  VerifiedUser({
    required this.user,
    required this.logsIn,
    this.logsOut,
  });

  Map<String, dynamic> toJson() {
    return {
      'user': user.toJson(),
      'userType': user is Guest ? 'Guest' : 'Visitor',
      'logs_in': logsIn.toIso8601String(),
      'logs_out': logsOut?.toIso8601String(),
    };
  }

  static VerifiedUser fromJson(Map<String, dynamic> json) {
    final userType = json['userType'];
    final user = userType == 'Guest'
        ? Guest.fromJson(json['user'])
        : Visitor.fromJson(json['user']);
    return VerifiedUser(
      user: user,
      logsIn: DateTime.parse(json['logs_in']),
      logsOut: json['logs_out'] != null ? DateTime.parse(json['logs_out']) : null,
    );
  }
} 