import 'package:flutter/material.dart';
import 'package:jobsearchmobile/constants/api.dart';
import 'package:jobsearchmobile/models/auth/update_resume_fb_request.dart';
import 'package:jobsearchmobile/models/auth/update_resume_md_request.dart';
import 'package:jobsearchmobile/models/resume_upload_result.dart';
import 'package:jobsearchmobile/services/auth_api_service.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
import '../../../services/resume_upload_service.dart';


class ResumeUploadButton extends StatefulWidget {
  final String userID;

  ResumeUploadButton({required this.userID});

  @override
  _ResumeUploadButtonState createState() => _ResumeUploadButtonState(userID: this.userID);
}

class _ResumeUploadButtonState extends State<ResumeUploadButton> {
  String _resumeFileName = '';
  final ResumeUploader _resumeUploader = ResumeUploader();
  final userID;

  _ResumeUploadButtonState({required this.userID});

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
                ResumeUploadResult result = await _resumeUploader.uploadResume(userID);
                setState(() {
                  _resumeFileName = result.fileName;
                });

                UpdateResumeMDRequestModel mDModel = UpdateResumeMDRequestModel(
                    id:userID,
                    resumeId: result.resumeId);

                APIService.updateResumeMD(mDModel).then((response) {
                  if(response.data != null) {
                    UpdateResumeFBRequestModel fBModel = UpdateResumeFBRequestModel(
                      userId: userID,
                      resumeId: result.resumeId
                    );

                    APIService.updateResumeFB(fBModel).then((response2) {
                      if(response2.put == 'success') {
                        // Show a dialog to inform the user that the upload was successful
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('Resume Uploaded'),
                              content: Text('Your resume has been uploaded successfully.'),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    // Close the dialog and navigate to the login page
                                    Navigator.of(context).popUntil((route) => route.isFirst);
                                    Navigator.pushNamed(context, '/home');
                                  },
                                  child: Text('OK'),
                                ),
                              ],
                            );
                          },
                        );
                      } else {
                        FormHelper.showSimpleAlertDialog(
                          context,
                          Api.appName,
                          "Failed to update user resume to firebase",
                          "OK",
                              () {
                            Navigator.of(context).pop();
                          },
                        );
                      }
                    });
                  } else {
                    FormHelper.showSimpleAlertDialog(
                      context,
                      Api.appName,
                      "Failed to update user resume to mongodb",
                      "OK",
                          () {
                        Navigator.of(context).pop();
                      },
                    );
                  }
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
