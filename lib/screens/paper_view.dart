import 'package:flutter/material.dart';
//import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';

class PaperView extends StatelessWidget {
  const PaperView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //final PdfViewerController controller = PdfViewerController();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Document"),
      ),
      body: Container(
          child: PDF().cachedFromUrl(
        'https://firebasestorage.googleapis.com/v0/b/eurekalearn-d63d4.appspot.com/o/documents%2FAL%20ECONS%20P2%202020-1.pdf?alt=media&token=92dfee45-0ed6-4c92-a6ce-365d1dd494e2',
        placeholder: (progress) => Center(child: Text('$progress %')),
        errorWidget: (error) => Center(child: Text(error.toString())),
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // controller.searchText("GCE");
        },
        child: Icon(Icons.file_download),
      ),
    );
  }
}
