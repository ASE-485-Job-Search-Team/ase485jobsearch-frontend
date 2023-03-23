import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

class ResumeUploadButton extends StatefulWidget {
  @override
  _ResumeUploadButtonState createState() => _ResumeUploadButtonState();
}

class _ResumeUploadButtonState extends State<ResumeUploadButton> {
  String _resumeFileName = '';

  Future<void> _uploadResume() async {
    final filePickerResult = await FilePicker.platform.pickFiles(type: FileType.custom, allowedExtensions: ['pdf']);

    if (filePickerResult != null && filePickerResult.files.isNotEmpty) {
      final file = filePickerResult.files.first;
      setState(() {
        _resumeFileName = file.name ?? '';
      });

      // TODO: Implement resume upload logic
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (_resumeFileName.isNotEmpty)
          Text(
            'Selected resume: $_resumeFileName',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ElevatedButton(
          onPressed: _uploadResume,
          child: Text('Upload Resume (PDF)'),
        ),
      ],
    );
  }
}
