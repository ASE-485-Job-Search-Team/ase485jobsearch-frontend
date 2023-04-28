import 'package:flutter/material.dart';
import 'package:jobsearchmobile/screens/my_applications/pages/job_app_create_form.dart';
import 'package:jobsearchmobile/services/auth_api_service.dart';
import 'package:jobsearchmobile/services/job_posting_service.dart';

class CreateAppButton extends StatelessWidget {
  final APIService apiService;
  final JobPostingService jobPostingService;
  const CreateAppButton({Key? key, required this.apiService, required this.jobPostingService}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(1.5),
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => JobApplicationPage(apiService: apiService, jobPostingService: jobPostingService,)),
          );
        },
        child: Text('Create Application'),
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Color(0xFF2c3a6d)),
          padding: MaterialStateProperty.all(EdgeInsets.symmetric(vertical: 6.0, horizontal: 12.0)),
        ),
      ),
    );
  }
}