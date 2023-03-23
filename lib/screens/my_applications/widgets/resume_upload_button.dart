
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';

class ResumeUploadButton extends StatefulWidget {
  @override
  _ResumeUploadButtonState createState() => _ResumeUploadButtonState();
}

class _ResumeUploadButtonState extends State<ResumeUploadButton> {
  String _resumeFileName = '';

  Future<void> _uploadResume() async {
    final filePickerResult =
    await FilePicker.platform.pickFiles(type: FileType.custom, allowedExtensions: ['pdf']);if (filePickerResult != null && filePickerResult.files.isNotEmpty) {
      final file = filePickerResult.files.first;
      setState(() {
        _resumeFileName = file.name ?? '';
      });

      // TODO: Implement resume upload logic
      File resumeFile = File(file.path!);
      String fileName = basename(resumeFile.path);

      try {
        var request = http.MultipartRequest(
            'POST', Uri.parse('http://your_api_endpoint.com/upload_resume'));
        request.files.add(await http.MultipartFile.fromPath('resume', resumeFile.path,
            filename: fileName));
        var response = await request.send();
        print(response.statusCode);
      } catch (e) {
        print(e.toString());
      }
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
