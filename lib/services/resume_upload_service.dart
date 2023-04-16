import 'dart:io';
import 'package:dio/dio.dart';
import 'package:path/path.dart';
import 'package:file_picker/file_picker.dart';

import '../constants/api.dart';

class ResumeUploader {
  final Dio dio = Dio();

  Future<String> uploadResume(String userID) async {
    String url = '${Api.baseUrl}/$userID/createResume';
    final filePickerResult = await FilePicker.platform.pickFiles(
        type: FileType.custom, allowedExtensions: ['pdf']);

    if (filePickerResult != null && filePickerResult.files.isNotEmpty) {
      final file = filePickerResult.files.first;

      File resumeFile = File(file.path!);
      String fileName = basename(resumeFile.path);

      try {
        FormData formData = FormData.fromMap({
          'fileName': fileName,
          'userId': userID,
          'file': await MultipartFile.fromFile(resumeFile.path, filename: fileName),
        });

        Response response = await dio.post(
            url,
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
