import 'package:easy_pdf_viewer/easy_pdf_viewer.dart';
import 'package:flutter/material.dart';

import '../constant/app-constant.dart';

class PdfViewerScreen extends StatefulWidget {
  String material_url;
  PdfViewerScreen({super.key,required this.material_url});

  @override
  State<PdfViewerScreen> createState() => _PdfViewerScreenState();
}

class _PdfViewerScreenState extends State<PdfViewerScreen> {
  PDFDocument? document;
  void initialisePdf() async{
    document=await PDFDocument.fromURL(widget.material_url);
    setState(() {

    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initialisePdf();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: document!=null
          ?PDFViewer(
        document: document!,
      ):Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
