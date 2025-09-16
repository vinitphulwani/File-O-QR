// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, sort_child_properties_last, prefer_const_literals_to_create_immutables, unused_local_variable, unnecessary_new, unused_import, unnecessary_brace_in_string_interps, unused_element, use_build_context_synchronously, must_be_immutable, file_names, deprecated_member_use, unnecessary_string_interpolations, avoid_print

import 'dart:io';
import 'dart:typed_data';
import 'package:checkme/database/writeToDatabase.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:ftpconnect/ftpconnect.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:share/share.dart';
import 'package:widgets_to_image/widgets_to_image.dart';

class QrPage extends StatefulWidget {
  String filename;
  QrPage(this.filename);
  @override
  State<StatefulWidget> createState() => QrPageState();
}

class QrPageState extends State<QrPage> {
  // WidgetsToImageController to access widget
  WidgetsToImageController controller = WidgetsToImageController();
// to save image bytes of widget
  Uint8List? bytes;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(10, 7, 65, 1),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SafeArea(
                child: Padding(
              padding: const EdgeInsets.all(0.0),
              child: Container(
                height: 100,
                width: double.infinity,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/images/logo.jpeg'),
                        fit: BoxFit.cover)),
              ),
            )),
            Padding(
              padding: const EdgeInsets.all(25.0),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                height: MediaQuery.of(context).size.height - 210,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    WidgetsToImage(
                        controller: controller,
                        child: QrImageView(
                          backgroundColor: Colors.white,
                          foregroundColor: Color.fromRGBO(10, 7, 65, 1),
                          data:
                              'https://vesgroup4.000webhostapp.com/displayinfo.php?filename=${widget.filename}',
                          version: QrVersions.auto,
                          size: 250,
                        )),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                          IconButton(onPressed: () {
                            saveToGallery(context);

                          }, icon: Icon(Icons.download_rounded),iconSize: 35,color: Colors.blue,),
                           IconButton(onPressed: () {
                            _shareQrImage();
                          }, icon: Icon(Icons.share_rounded),iconSize: 35,color: Colors.green,)

                        ],),
                       
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void saveToGallery(context) async {
    bytes = await controller.capture();
    final result = await ImageGallerySaver.saveImage(bytes!);
    if(result["isSuccess"]){
       const snackdemo = SnackBar(
                    content: Text('QR saved to gallery'),
                    backgroundColor: Colors.green,
                    elevation: 10,
                    behavior: SnackBarBehavior.floating,
                    margin: EdgeInsets.all(5),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackdemo);
    }
  }
   void _shareQrImage() async {
    try {
      bytes = await controller.capture();
      final tempDir = await getTemporaryDirectory();
      final file = await new File('${tempDir.path}/image.png').create();
      await file.writeAsBytes(bytes!);
      await Share.shareFiles(['${tempDir.path}/image.png'], text:'${widget.filename}' );
    } catch (e) {
      print(e);
    }
  }
}
