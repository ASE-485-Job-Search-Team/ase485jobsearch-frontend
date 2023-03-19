import 'package:flutter/material.dart';
import 'package:jobsearchmobile/screens/my_applications/pages/job_app_create_form.dart';

class CreateAppButton extends StatelessWidget {
  const CreateAppButton({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => JobApplicationPage()),
          );
        },
        child: Text('Create Application'),
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Theme.of(context).primaryColor),
          padding: MaterialStateProperty.all(EdgeInsets.symmetric(vertical: 12.0, horizontal: 24.0)),
        ),
      ),
    );
  }
}