import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:jobsearchmobile/screens/home/widgets/bullet_widgets.dart';
import 'package:http/http.dart' as http;
import '../../../models/job_info.dart';
import '../../../models/job_application.dart';


class JobDetail extends StatelessWidget {
  final JobPosting jobPosting;

  const JobDetail({Key? key, required this.jobPosting}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Container(
        height: 700,
        padding: EdgeInsets.fromLTRB(32.0, 32.0, 32.0, 70.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 40.0,
                    height: 40.0,
                    padding: EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        color: Colors.grey.withOpacity(0.1)),
                    child: Image.network(jobPosting.companyLogo),
                  ),
                  const SizedBox(
                    width: 8.0,
                  ),
                  Text(jobPosting.company,
                      style: const TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.w500))
                ],
              ),
              const SizedBox(
                height: 16.0,
              ),
              Text(
                jobPosting.title,
                style: const TextStyle(
                    fontSize: 24.0, fontWeight: FontWeight.w600),
                textAlign: TextAlign.left,
              ),
              const SizedBox(
                height: 16.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.location_on_outlined,
                        size: 18.0,
                        color: Colors.grey.shade700,
                      ),
                      const SizedBox(
                        width: 4.0,
                      ),
                      Text(
                        jobPosting.location,
                        style: TextStyle(
                            fontSize: 14.0, color: Colors.grey.shade700),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.access_time_outlined,
                        size: 18.0,
                        color: Colors.grey.shade700,
                      ),
                      const SizedBox(
                        width: 4.0,
                      ),
                      Text(
                        jobPosting.jobType,
                        style: TextStyle(
                            fontSize: 14.0, color: Colors.grey.shade700),
                      )
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 24.0,
              ),
              Text(
                'Job Description',
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600),
              ),
              const SizedBox(
                height: 8.0,
              ),
              Text(
                jobPosting.description,
                style: TextStyle(
                    fontWeight: FontWeight.w300,
                    height: 1.5,
                    color: Colors.grey.shade900),
              ),
              const SizedBox(
                height: 16.0,
              ),
              const Text(
                'Qualifications',
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600),
              ),
              const SizedBox(
                height: 8.0,
              ),
              BulletList(jobPosting.qualifications),
              const SizedBox(
                height: 16.0,
              ),
              const Text(
                'Responsibilities',
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600),
              ),
              const SizedBox(
                height: 8.0,
              ),
              BulletList(jobPosting.responsibilities),
            ],
          ),
        ),
      ),
      Positioned(
          bottom: 12.0,
          left: 0.0,
          right: 0.0,
          child: SizedBox(
            height: 60.0,
            child: Center(
              child: SizedBox(
                width: 200.0,
                height: 42.0,
                child: ElevatedButton(
                  onPressed: () async {
                    // Create a JobApplication object
                    final jobApplication = JobApplication(
                      id: 0, // Provide an appropriate ID or keep it 0 for auto-increment
                      dateApplied: DateTime.now(),
                      status: JobApplicationStatus.applied,
                      jobSeekerId: 1, // Replace with the actual jobSeekerId
                      jobPostingId: int.parse(jobPosting.id),
                      jobPosting: jobPosting,
                    );

                    // Convert the JobApplication object to JSON
                    final jobApplicationJson = json.encode(jobApplication.toJson());

                    // Send a POST request to the API with the JSON data
                    var response = await http.post(
                      Uri.parse('https://example.com/api/apply'),
                      headers: {'Content-Type': 'application/json'},
                      body: jobApplicationJson,
                    );

                    if (response.statusCode == 200) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Application Submitted!'),
                        ),
                      );
                      Navigator.pop(context);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Error submitting application.'),
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF2c3a6d),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50.0))),
                  child: const Text(
                    'Apply',
                    style:
                    TextStyle(fontWeight: FontWeight.w600, fontSize: 16.0),
                  ),
                ),
              ),
            ),
          ))
    ]);
  }
}
