class EmergencyContactApiResponse {
  final String message;
  final bool status;
  final List<EmergencyContact> data;

  EmergencyContactApiResponse({
    required this.message,
    required this.status,
    required this.data,
  });

  factory EmergencyContactApiResponse.fromJson(Map<String, dynamic> json) {
    return EmergencyContactApiResponse(
      message: json['message'],
      status: json['status'],
      data: List<EmergencyContact>.from(json['data'].map((x) => EmergencyContact.fromJson(x))),
    );
  }
}

class EmergencyContact {
  final String id;
  final String name;
  final String contactNumber;

  EmergencyContact({
    required this.id,
    required this.name,
    required this.contactNumber,
  });

  factory EmergencyContact.fromJson(Map<String, dynamic> json) {
    return EmergencyContact(
      id: json['_id'],
      name: json['name'],
      contactNumber: json['contactNumber'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'contactNumber': contactNumber,
    };
  }

}