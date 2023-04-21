class JobPostingRequest {
  final String title;
  final String companyId;
  final String location;
  final String jobType;
  final String description;
  final List<String> qualifications;
  final List<String> responsibilities;
  final DateTime datePosted;
  final DateTime dateClosing;
  final String salaryRange;

  JobPostingRequest({
    required this.title,
    required this.companyId,
    required this.location,
    required this.jobType,
    required this.description,
    required this.qualifications,
    required this.responsibilities,
    required this.datePosted,
    required this.dateClosing,
    required this.salaryRange,
  });

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'companyId': companyId,
      'location': location,
      'jobType': jobType,
      'description': description,
      'qualifications': qualifications,
      'responsibilities': responsibilities,
      'datePosted': datePosted.toIso8601String(),
      'dateClosing': dateClosing.toIso8601String(),
      'salaryRange': salaryRange
    };
  }
}
