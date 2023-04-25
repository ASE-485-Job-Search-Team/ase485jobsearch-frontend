import 'package:flutter/material.dart';
import 'package:jobsearchmobile/screens/my_applications/pages/job_app_create_form.dart';

class CreateAppButton extends StatelessWidget {
  const CreateAppButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(1.5),
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => JobApplicationPage()),
          );
        },
        child: Text('New Job Posting'),
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Color(0xFF2c3a6d)),
          padding: MaterialStateProperty.all(
              EdgeInsets.symmetric(vertical: 6.0, horizontal: 12.0)),
        ),
      ),
    );
  }
}
