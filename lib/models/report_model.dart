class ReportApiResponse {
  final String message;
  final bool status;
  final List<Report> data;

  ReportApiResponse({
    required this.message,
    required this.status,
    required this.data,
  });

  factory ReportApiResponse.fromJson(Map<String, dynamic> json) {
    return ReportApiResponse(
      message: json['message'],
      status: json['status'],
      data: List<Report>.from(json['data'].map((x) => Report.fromJson(x))),
    );
  }
}

class Report {
  final String id;
  final String reportId;
  final String status;
  final String reportText;
  final List<String> images;
  final String createdBy;
  final bool isRemoved;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int v;

  Report({
    required this.id,
    required this.reportId,
    required this.status,
    required this.reportText,
    required this.images,
    required this.createdBy,
    required this.isRemoved,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory Report.fromJson(Map<String, dynamic> json) {
    return Report(
      id: json['_id'],
      reportId: json['reportId'],
      status: json['status'],
      reportText: json['report_text'],
      images: List<String>.from(json['images']),
      createdBy: json['createdBy'],
      isRemoved: json['isRemoved'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      v: json['__v'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'reportId': reportId,
      'status': status,
      'report_text': reportText,
      'images': images,
      'createdBy': createdBy,
      'isRemoved': isRemoved,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      '__v': v,
    };
  }
}