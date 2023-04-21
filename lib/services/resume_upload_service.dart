import 'package:dio/dio.dart';
import 'package:jobsearchmobile/models/resume_upload_result.dart';
import 'package:file_picker/file_picker.dart';
import 'package:universal_io/io.dart' as universal_io;
import 'package:universal_platform/universal_platform.dart';

import '../constants/api.dart';

class ResumeUploader {
  final Dio dio = Dio();
  late String resumeId;

  Future<ResumeUploadResult> uploadResume(String userID) async {
    String url = '${Api.baseUrl}/resume/$userID/createResume';
    FilePickerResult? filePickerResult;

    if (UniversalPlatform.isWeb) {
      filePickerResult = await FilePicker.platform.pickFiles(
          type: FileType.custom, allowedExtensions: ['pdf']);
    } else {
      filePickerResult = await FilePicker.platform.pickFiles(
          type: FileType.custom, allowedExtensions: ['pdf']);
    }

    if (filePickerResult != null && filePickerResult.files.isNotEmpty) {
      final file = filePickerResult.files.first;
      String fileName = file.name;

      try {
        MultipartFile multipartFile;

        if (UniversalPlatform.isWeb) {
          multipartFile = MultipartFile.fromBytes(
            file.bytes!,
            filename: fileName,
          );
        } else {
          universal_io.File resumeFile = universal_io.File(file.path!);
          multipartFile = await MultipartFile.fromFile(
            resumeFile.path,
            filename: fileName,
          );
        }

        FormData formData = FormData.fromMap({
          'fileName': fileName,
          'userId': userID,
          'file': multipartFile,
        });

        Response response = await dio.post(url, data: formData);
        print(response.statusCode);
        resumeId = response.data['data']['resumeId'];
        print(resumeId);
      } catch (e) {
        print(e.toString());
      }

      return ResumeUploadResult(file.name, resumeId);
    }
    return ResumeUploadResult('', '');
  }
}


