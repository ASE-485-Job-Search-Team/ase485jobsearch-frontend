import 'package:flutter/material.dart';
import '../../../services/resume_upload_service.dart';


class ResumeUploadButton extends StatefulWidget {
  final String userID;

  ResumeUploadButton({required this.userID});

  @override
  _ResumeUploadButtonState createState() => _ResumeUploadButtonState();
}

class _ResumeUploadButtonState extends State<ResumeUploadButton> {
  String _resumeFileName = '';
  final ResumeUploader _resumeUploader = ResumeUploader();

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(1.5),
        child: Column(
          children: [
            if (_resumeFileName.isNotEmpty)
              Text(
                'Selected resume: $_resumeFileName',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ElevatedButton(
              onPressed: () async {
                String fileName = await _resumeUploader.uploadResume(widget.userID);
                setState(() {
                  _resumeFileName = fileName;
                });
              },
              child: Text('Upload Resume (PDF)'),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Color(0xFF2c3a6d)),
                padding: MaterialStateProperty.all(
                    EdgeInsets.symmetric(vertical: 6.0, horizontal: 10.0)),
              ),
            ),
          ],
        )
    );
  }
}
