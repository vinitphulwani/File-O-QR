// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, sort_child_properties_last, prefer_const_literals_to_create_immutables, unused_local_variable, unnecessary_new, unused_import, unnecessary_brace_in_string_interps, unused_element, use_build_context_synchronously, must_be_immutable, file_names, avoid_print, non_constant_identifier_names

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
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:scan/scan.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:widgets_to_image/widgets_to_image.dart';

class ScanQrPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ScanQrPageState();
}

class ScanQrPageState extends State<ScanQrPage> {
    PlatformFile? file;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  QRViewController? controller;
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    } else if (Platform.isIOS) {
      controller!.resumeCamera();
    }
  }

  @override
  Widget build(BuildContext context) {
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 200.0
        : 350.0;
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
                    Expanded(
                      flex: 5,
                      child: QRView(
                        overlay: QrScannerOverlayShape(
                            borderColor: Colors.red,
                            borderRadius: 10,
                            borderLength: 30,
                            borderWidth: 10,
                            cutOutSize: scanArea),
                        key: qrKey,
                        onQRViewCreated: _onQRViewCreated,
                      ),
                    ),
                    ElevatedButton(onPressed: () async {
                        FilePickerResult? result =
                                      await FilePicker.platform.pickFiles(
                                    type: FileType.custom,
                                    allowedExtensions: ['jpeg', 'jpg', 'png'],
                                  );
                                  if (result != null) {
                                      setState(() {
                                        file = result.files.first;
                                  ScanFromImage(file!.path.toString());
                                    });
                                  }
                    }, child: Text("Scan From Image",style: TextStyle(color: Colors.white),),style: ElevatedButton.styleFrom(backgroundColor: Color.fromRGBO(10, 7, 65, 1),),)
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
Future<void> ScanFromImage(imagePath) async {
  String? result = await Scan.parse(imagePath);
  print(result);
  final Uri url = Uri.parse(result!);
   if (!await launchUrl(url)) {
        throw Exception('Could not launch');
      }
}
  void _onQRViewCreated(QRViewController controller) async {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) async {
      result = scanData;
      final Uri url = Uri.parse(result!.code.toString());
      if (!await launchUrl(url)) {
        throw Exception('Could not launch');
      }
    });
  }
}
