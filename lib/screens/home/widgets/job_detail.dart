import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:jobsearchmobile/screens/home/widgets/bullet_widgets.dart';
import 'package:http/http.dart' as http;
import 'package:jobsearchmobile/services/job_application_service.dart';
import '../../../models/job_info.dart';
import '../../../models/job_application.dart';
import '../../../models/user.dart';
import '../../../services/auth_api_service.dart';

class JobDetail extends StatefulWidget {
  final APIService apiService;
  final JobPosting jobPosting;
  final bool displayApplyButton;

  const JobDetail(
      {Key? key, required this.jobPosting, required this.displayApplyButton, required this.apiService})
      : super(key: key);

  @override
  State<JobDetail> createState() => _JobDetailState();
}

class _JobDetailState extends State<JobDetail> {
  final jobApplicationService =
      JobApplicationService(httpClient: http.Client());

  late User _user;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  void _loadUserData() async {
    String response = await widget.apiService.getUserProfile();

    final model = jsonDecode(response);
    final isAdmin = model['data']['isAdmin'];
    User user;

    if (isAdmin) {
      user = User(
        id: model['data']['id'],
        name: model['data']['company'],
        email: model['data']['email'],
        isAdmin: true,
      );
    } else {
      user = User(
        id: model['data']['id'],
        name: model['data']['first'] + ' ' + model['data']['last'],
        email: model['data']['email'],
        resume: model['data']['resume'],
        isAdmin: false,
      );
    }

    setState(() {
      _user = user;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Container(
        height: 700,
        padding: const EdgeInsets.fromLTRB(32.0, 32.0, 32.0, 70.0),
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
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        color: Colors.grey.withOpacity(0.1)),
                    child: Image.network(widget.jobPosting.companyLogo),
                  ),
                  const SizedBox(
                    width: 8.0,
                  ),
                  Text(widget.jobPosting.company,
                      style: const TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.w500))
                ],
              ),
              const SizedBox(
                height: 16.0,
              ),
              Text(
                widget.jobPosting.title,
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
                        widget.jobPosting.location,
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
                        widget.jobPosting.jobType,
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
              const Text(
                'Job Description',
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600),
              ),
              const SizedBox(
                height: 8.0,
              ),
              Text(
                widget.jobPosting.description,
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
              BulletList(widget.jobPosting.qualifications),
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
              BulletList(widget.jobPosting.responsibilities),
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
              child: widget.displayApplyButton
                  ? SizedBox(
                      width: 200.0,
                      height: 42.0,
                      child: ElevatedButton(
                        onPressed: () async {
                          final String userId = _user!.id;
                          final String jobId = widget.jobPosting.id;
                          jobApplicationService
                              .applyForJob(userId, jobId)
                              .then((_) => {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text('Application Submitted!'),
                                        backgroundColor: Colors.green,
                                      ),
                                    ),
                                    Navigator.pop(context)
                                  })
                              .catchError((error) => {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(error.message),
                                        backgroundColor: Colors.red,
                                      ),
                                    ),
                                    Navigator.pop(context)
                                  });
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF2c3a6d),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50.0))),
                        child: const Text(
                          'Apply',
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 16.0),
                        ),
                      ),
                    )
                  : Container(),
            ),
          ))
    ]);
  }
}
