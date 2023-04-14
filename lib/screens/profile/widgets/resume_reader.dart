import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
//Local imports
// import 'save_file_mobile.dart' if (dart.library.html) 'save_file_web.dart';

class ResumeReader extends StatefulWidget {
  const ResumeReader({Key? key}) : super(key: key);

  @override
  State<ResumeReader> createState() => _ResumeReaderState();
}

class _ResumeReaderState extends State<ResumeReader> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          foregroundColor: Colors.grey.shade900,
          title: const Text('Resume_0403', style: TextStyle(fontSize: 16)),
        ),
        body: Container(
            child: SfPdfViewer.network(
                'https://firebasestorage.googleapis.com/v0/b/ase456-myfirstproject.appspot.com/o/Software%20Engineer.pdf?alt=media')));
  }
}
