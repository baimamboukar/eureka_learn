import 'package:eureka_learn/models/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

final failedProvider = StateProvider<bool>((ref) => false);

class PaperView extends HookWidget {
  final PaperModel paper;
  const PaperView({Key? key, required this.paper}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final failed = useProvider(failedProvider);
    final PdfViewerController controller = PdfViewerController();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Document"),
      ),
      body: failed.state
          ? LottieBuilder.asset("assets/animations/nothing.json")
          : Container(
              child: SfPdfViewer.network(paper.link,
                  interactionMode: PdfInteractionMode.pan,
                  controller: controller,
                  onDocumentLoadFailed: (PdfDocumentLoadFailedDetails) {
              failed.state = true;
            }, onDocumentLoaded: (PdfDocumentLoadedDetails load) {
              showAboutDialog(
                  context: context,
                  children: [Text("${load.document.template}")]);
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
