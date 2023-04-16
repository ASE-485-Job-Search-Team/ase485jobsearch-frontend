import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
//Local imports
// import 'save_file_mobile.dart' if (dart.library.html) 'save_file_web.dart';

class ResumeReader extends StatelessWidget {
  final String title;
  final String resumeUrl;
  const ResumeReader({Key? key, required this.title, required this.resumeUrl})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          foregroundColor: Colors.grey.shade900,
          title: Text(title, style: TextStyle(fontSize: 16)),
        ),
        body: Container(child: SfPdfViewer.network(resumeUrl)));
  }
}
