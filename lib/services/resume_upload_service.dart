import 'dart:io';
import 'package:dio/dio.dart';
import 'package:path/path.dart';
import 'package:file_picker/file_picker.dart';

class ResumeUploader {
  final Dio dio = Dio();

  Future<String> uploadResume(String userID) async {
    final filePickerResult = await FilePicker.platform.pickFiles(
        type: FileType.custom, allowedExtensions: ['pdf']);

    if (filePickerResult != null && filePickerResult.files.isNotEmpty) {
      final file = filePickerResult.files.first;

      File resumeFile = File(file.path!);
      String fileName = basename(resumeFile.path);

      try {
        FormData formData = FormData.fromMap({
          'resume': await MultipartFile.fromFile(resumeFile.path, filename: fileName),
          'userID': userID,
        });

        Response response = await dio.post(
            'http://example_api_endpoint.com/upload_resume',
            data: formData);
        print(response.statusCode);
      } catch (e) {
        print(e.toString());
      }

      return file.name ?? '';
    }

    return '';
  }
}
