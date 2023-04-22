class Resume {
  final String fileName;
  final String resumeId;
  final String downloadUrl;
  final String userId;

  Resume(
      {required this.fileName,
      required this.resumeId,
      required this.downloadUrl,
      required this.userId});

  factory Resume.fromJson(Map<String, dynamic> json) {
    return Resume(
      fileName: json['fileName'],
      resumeId: json['resumeId'],
      downloadUrl: json['downloadUrl'],
      userId: json['userId'],
    );
  }
}
