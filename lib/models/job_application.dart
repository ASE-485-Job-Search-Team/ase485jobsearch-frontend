import 'dart:ui';

import 'package:flutter/material.dart';

import 'job_info.dart';

class JobApplication {
  final int id;
  final DateTime dateApplied;
  final JobApplicationStatus status;
  final int jobSeekerId;
  final int jobPostingId;
  final JobPosting jobPosting;

  JobApplication(
      {required this.id,
      required this.dateApplied,
      required this.status,
      required this.jobSeekerId,
      required this.jobPostingId,
      required this.jobPosting});

  factory JobApplication.fromJson(Map<String, dynamic> json) {
    return JobApplication(
        id: json['id'],
        dateApplied: DateTime.parse(json['dateApplied']),
        status: mapStatus(json['status']),
        jobSeekerId: json['jobSeekerId'],
        jobPostingId: json['jobPostingId'],
        jobPosting: JobPosting.fromJson(json['jobPosting']));
  }

  static JobApplicationStatus mapStatus(String status) {
    switch (status) {
      case 'applied':
        return JobApplicationStatus.applied;
      case 'underReview':
        return JobApplicationStatus.underReview;
      case 'offered':
        return JobApplicationStatus.offered;
      case 'rejected':
        return JobApplicationStatus.rejected;
      default:
        return JobApplicationStatus.unknown;
    }
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'dateApplied': dateApplied.toIso8601String(),
        'status': status,
        'jobSeekerId': jobSeekerId,
        'jobPostingId': jobPostingId,
        'jobPosting': jobPosting
      };
}

enum JobApplicationStatus { applied, underReview, offered, rejected, unknown }

extension JobApplicationStatusExtension on JobApplicationStatus {
  String get name {
    switch (this) {
      case JobApplicationStatus.applied:
        return 'Applied';
      case JobApplicationStatus.underReview:
        return 'Under Review';
      case JobApplicationStatus.offered:
        return 'Offered';
      case JobApplicationStatus.rejected:
        return 'Rejected';
      default:
        return 'Unknown';
    }
  }

  Color get color {
    switch (this) {
      case JobApplicationStatus.applied:
        return Colors.deepPurple.shade800;
      case JobApplicationStatus.underReview:
        return Colors.yellow.shade900;
      case JobApplicationStatus.offered:
        return Colors.green.shade800;
      case JobApplicationStatus.rejected:
        return Colors.red.shade800;
      default:
        return Colors.grey.shade800;
    }
  }

  Color get backgroundColor {
    switch (this) {
      case JobApplicationStatus.applied:
        return Colors.deepPurple.shade50;
      case JobApplicationStatus.underReview:
        return Colors.amber.shade50;
      case JobApplicationStatus.offered:
        return Colors.green.shade50;
      case JobApplicationStatus.rejected:
        return Colors.red.shade50;
      default:
        return Colors.grey.shade100;
    }
  }
}
