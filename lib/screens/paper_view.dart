import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PaperView extends StatelessWidget {
  const PaperView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: Column(
        children: [
          Container(
              child: SfPdfViewer.network(
                  "https://firebasestorage.googleapis.com/v0/b/eurekalearn-d63d4.appspot.com/o/documents%2Fpaper.pdf?alt=media&token=a6e86c4c-c206-466e-b91b-515f03680de0",
                  pageLayoutMode: PdfPageLayoutMode.single))
        ],
      )),
    );
  }
}
