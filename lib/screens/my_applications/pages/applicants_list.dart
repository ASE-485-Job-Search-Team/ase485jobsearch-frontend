import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:jobsearchmobile/services/job_application_service.dart';
import 'package:http/http.dart' as http;

import '../../../models/job_info.dart';
import '../../profile/widgets/resume_reader.dart';

class ApplicantsList extends StatefulWidget {
  final JobPosting jobPosting;
  const ApplicantsList({Key? key, required this.jobPosting}) : super(key: key);

  @override
  State<ApplicantsList> createState() => _ApplicantsListState();
}

class _ApplicantsListState extends State<ApplicantsList> {
  final JobApplicationService _jobApplicationService =
      JobApplicationService(httpClient: http.Client());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          foregroundColor: Colors.grey.shade900,
          title: Text(
            widget.jobPosting.title,
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Applicants',
                style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.w600),
              ),
              const Divider(),
              const SizedBox(
                height: 16.0,
              ),
              FutureBuilder(
                  future:
                      _jobApplicationService.getJobApplicationsFromJobPosting(
                          widget.jobPosting.companyId, widget.jobPosting.id),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return const Center(
                        child: Text('Something went wrong. Please try again'),
                      );
                    } else if (snapshot.hasData) {
                      final jobApplications = snapshot.data as List;
                      return Expanded(
                        child: ListView.builder(
                          itemCount: jobApplications.length,
                          itemBuilder: (context, index) {
                            final jobApplication = jobApplications[index];
                            return ApplicantResumeCard(
                              applicantName: jobApplication.name,
                              dateApplied: DateFormat.yMMMMd()
                                  .format(jobApplication.dateApplied),
                              resumeUrl: jobApplication.resumeUrl,
                            );
                          },
                        ),
                      );
                    } else {
                      return const Text('No data');
                    }
                  }),
            ],
          ),
        ));
  }
}

class ApplicantResumeCard extends StatelessWidget {
  final String applicantName;
  final String dateApplied;
  final String resumeUrl;
  const ApplicantResumeCard({
    super.key,
    required this.applicantName,
    required this.dateApplied,
    required this.resumeUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      padding: const EdgeInsets.fromLTRB(12.0, 12.0, 12.0, 12.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.white,
          border: Border.all(color: Colors.grey[200]!)),
      child: Row(
        children: [
          Container(
            width: 32.0,
            height: 32.0,
            padding: const EdgeInsets.all(4.0),
            child:
                const Icon(Icons.picture_as_pdf, color: Colors.red, size: 20),
          ),
          const SizedBox(
            width: 8.0,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 180,
                child: Text(
                  applicantName,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600),
                ),
              ),
              SizedBox(
                height: 4.0,
              ),
              Text('Date applied: $dateApplied',
                  style: TextStyle(fontSize: 12.0, color: Colors.grey)),
            ],
          ),
          const Spacer(),
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ResumeReader(
                          title: applicantName, resumeUrl: resumeUrl)));
            },
            child: Chip(
              label: Text(
                'Preview',
                style: TextStyle(fontSize: 12.0, color: Colors.grey.shade700),
              ),
              visualDensity: VisualDensity.compact,
              backgroundColor: Colors.grey.shade100,
            ),
          ),
        ],
      ),
    );
  }
}
