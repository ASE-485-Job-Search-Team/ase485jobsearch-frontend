import 'package:flutter/material.dart';

class ApplyJobButton extends StatelessWidget {
  const ApplyJobButton({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        onPressed: () {
        },
        child: Text('Apply'),
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Theme.of(context).primaryColor),
          padding: MaterialStateProperty.all(EdgeInsets.symmetric(vertical: 12.0, horizontal: 24.0)),
        ),
      ),
    );
  }
}
