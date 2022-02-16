import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PaperView extends StatelessWidget {
  const PaperView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final PdfViewerController controller = PdfViewerController();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Document"),
      ),
      body: Container(
          child: SfPdfViewer.network(
              "https://firebasestorage.googleapis.com/v0/b/eurekalearn-d63d4.appspot.com/o/documents%2F0750-AGEOGRAPHY3-1.pdf?alt=media&token=81cf5285-cbe0-4fb6-bdf2-11829baee7bb",
              interactionMode: PdfInteractionMode.pan,
              controller: controller,
              onDocumentLoaded: (PdfDocumentLoadedDetails load) {
        showAboutDialog(
            context: context, children: [Text("${load.document.template}")]);
      }, pageLayoutMode: PdfPageLayoutMode.continuous)),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          controller.searchText("GCE");
        },
        child: Icon(Icons.file_download),
      ),
    );
  }
}
