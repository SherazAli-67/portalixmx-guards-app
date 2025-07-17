class UserApiResponse {
  final String message;
  final bool status;
  final UserModel data;

  UserApiResponse({
    required this.message,
    required this.status,
    required this.data,
  });

  factory UserApiResponse.fromJson(Map<String, dynamic> json) {
    return UserApiResponse(
      message: json['message'],
      status: json['status'],
      data: UserModel.fromJson(json['data']),
    );
  }
}

class UserModel {
  final String id;
  final String name;
  final String email;
  final String mobile;
  final String password;
  final String role;
  final String image;
  final bool isRemoved;
  final String status;
  final String userId;
  final String createdBy;
  final String associatedSociety;
  final List<String> emergencyContacts;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int v;
  final AdditionalDetails additionalDetails;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.mobile,
    required this.password,
    required this.role,
    required this.image,
    required this.isRemoved,
    required this.status,
    required this.userId,
    required this.createdBy,
    required this.associatedSociety,
    required this.emergencyContacts,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
    required this.additionalDetails,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['_id'],
      name: json['name'],
      email: json['email'],
      mobile: json['mobile'],
      password: json['password'],
      role: json['role'],
      image: json['image'],
      isRemoved: json['isRemoved'],
      status: json['status'],
      userId: json['userId'],
      createdBy: json['createdBy'],
      associatedSociety: json['associatedSociety'],
      emergencyContacts: List<String>.from(json['emergencyContacts']),
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      v: json['__v'],
      additionalDetails: AdditionalDetails.fromJson(json['additionalDetails']),
    );
  }
}

class AdditionalDetails {
  final String vehicleName;
  final String color;
  final String licensePlate;
  final String registrationNumber;

  AdditionalDetails({
    required this.vehicleName,
    required this.color,
    required this.licensePlate,
    required this.registrationNumber,
  });

  factory AdditionalDetails.fromJson(Map<String, dynamic> json) {
    return AdditionalDetails(
      vehicleName: json['vehicleName'],
      color: json['color'],
      licensePlate: json['licensePlate'],
      registrationNumber: json['registrationNumber'],
    );
  }
}