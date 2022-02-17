import 'package:eureka_learn/models/models.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PaperView extends StatelessWidget {
  final PaperModel paper;
  const PaperView({Key? key, required this.paper}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final PdfViewerController controller = PdfViewerController();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Document"),
      ),
      body: Container(
          child: SfPdfViewer.network(paper.link,
              interactionMode: PdfInteractionMode.pan, controller: controller,
              onDocumentLoaded: (PdfDocumentLoadedDetails load) {
        showAboutDialog(
            context: context, children: [Text("${load.document.template}")]);
      }, pageLayoutMode: PdfPageLayoutMode.single)),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          controller.searchText("GCE");
        },
        child: Icon(Icons.file_download),
      ),
    );
  }
}
