class JobPosting {
  final String id;
  final String title;
  final String companyId;
  final String company;
  final String location;
  final String jobType;
  final String description;
  final List<String> qualifications;
  final List<String> responsibilities;
  final DateTime datePosted;
  final DateTime dateClosing;
  final String companyLogo;
  final String salaryRange;

  JobPosting({
    required this.id,
    required this.title,
    required this.companyId,
    required this.company,
    required this.location,
    required this.jobType,
    required this.description,
    required this.qualifications,
    required this.responsibilities,
    required this.datePosted,
    required this.dateClosing,
    required this.companyLogo,
    required this.salaryRange,
  });

  factory JobPosting.fromJson(Map<String, dynamic> json) {
    return JobPosting(
        id: json['id'],
        title: json['title'],
        companyId: json['companyId'],
        company: json['company'],
        location: json['location'],
        jobType: json['jobType'],
        description: json['description'],
        qualifications: List<String>.from(json['qualifications']),
        responsibilities: List<String>.from(json['responsibilities']),
        datePosted: DateTime.parse(json['datePosted']),
        dateClosing: DateTime.parse(json['dateClosing']),
        companyLogo: json['companyLogo'],
        salaryRange: json['salaryRange']);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'companyId': companyId,
      'company': company,
      'location': location,
      'jobType': jobType,
      'description': description,
      'qualifications': qualifications,
      'responsibilities': responsibilities,
      'datePosted': datePosted.toIso8601String(),
      'dateClosing': dateClosing.toIso8601String(),
      'companyLogo': companyLogo,
      'salaryRange': salaryRange
    };
  }
}
