// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, sort_child_properties_last, prefer_const_literals_to_create_immutables, unused_local_variable, unnecessary_new, unused_import, unnecessary_brace_in_string_interps, unused_element, use_build_context_synchronously, file_names, avoid_print

import 'dart:io';
import 'package:checkme/database/writeToDatabase.dart';
import 'package:checkme/screens/qrCodePage.dart';
import 'package:checkme/screens/scanQrCode.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:ftpconnect/ftpconnect.dart';
import 'package:page_transition/page_transition.dart';
import 'package:path/path.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  PlatformFile? file;
  String passwordvalue = '';
  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
  
  bool showProgress=false;

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
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            border: Border.all(
                                color: Color.fromRGBO(10, 7, 65, 1), width: 5)),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListTile(
                              leading: Image.asset("assets/images/pdf.png"),
                              title: Text("Select PDF/DOCS"),
                              trailing: IconButton(
                                onPressed: () async {
                                  FilePickerResult? result =
                                      await FilePicker.platform.pickFiles(
                                    type: FileType.custom,
                                    allowedExtensions: [
                                      'pdf',
                                      'docs',
                                      'docx',
                                      'csv'
                                    ],
                                  );
                                  if (result != null) {
                                    setState(() {
                                      file = result.files.first;
                                      _showMyDialog(
                                          basename(file!.path.toString()),
                                          context);
                                    });
                                  }
                                },
                                icon: Icon(Icons.arrow_right_alt,
                                    color: Colors.purple),
                              )),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            border: Border.all(
                                color: Color.fromRGBO(10, 7, 65, 1), width: 5)),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListTile(
                              leading: Image.asset("assets/images/picture.png"),
                              title: Text("Select Image"),
                              trailing: IconButton(
                                onPressed: () async {
                                  FilePickerResult? result =
                                      await FilePicker.platform.pickFiles(
                                    type: FileType.custom,
                                    allowedExtensions: ['jpeg', 'jpg', 'png'],
                                  );
                                  if (result != null) {
                                    setState(() {
                                      file = result.files.first;
                                      _showMyDialog(
                                          basename(file!.path.toString()),
                                          context);
                                    });
                                  }
                                },
                                icon: Icon(Icons.arrow_right_alt,
                                    color: Colors.purple),
                              )),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            border: Border.all(
                                color: Color.fromRGBO(10, 7, 65, 1), width: 5)),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListTile(
                              leading: Image.asset("assets/images/mp4.png"),
                              title: Text("Select Video"),
                              trailing: IconButton(
                                onPressed: () async {
                                  FilePickerResult? result =
                                      await FilePicker.platform.pickFiles(
                                    type: FileType.custom,
                                    allowedExtensions: ['mp4', 'mov', 'mkv'],
                                  );
                                  if (result != null) {
                                    setState(() {
                                      file = result.files.first;
                                      _showMyDialog(
                                          basename(file!.path.toString()),
                                          context);
                                    });
                                  }
                                },
                                icon: Icon(Icons.arrow_right_alt,
                                    color: Colors.purple),
                              )),
                        ),
                      ),
                    ),
                    showProgress?
                    CircularProgressIndicator(color:Color.fromRGBO(10, 7, 65, 1), ):
                    SizedBox.shrink(),
                    SizedBox(height: MediaQuery.of(context).size.height - 700),
                    
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          PageTransition(
                              child: ScanQrPage(),
                              type: PageTransitionType.leftToRight),
                        );
                      },
                      child: Text("Scan QR"),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromRGBO(10, 7, 65, 1),
                          foregroundColor: Colors.white),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> _showMyDialog(filename, BuildContext con) async {
    return showDialog<void>(
      context: con,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Set Password'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Do you want to set password for this file (${filename})'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Yes'),
              onPressed: () {
                Navigator.of(context).pop();
                _showMyDialogForPassword(con, filename);
              },
            ),
            TextButton(
              child: const Text('No'),
              onPressed: () {
                Navigator.of(context).pop();
                _showPreview(con, filename, "No");
              },
            ),
            TextButton(
              child: const Text('Cancel File'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _showMyDialogForPassword(BuildContext con, file) async {
    return showDialog<void>(
      context: con,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Set Password'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: TextField(
                    obscureText: true,
                    controller: password,
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(15),
                        labelText: "Enter Password",
                        isDense: true,
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10)))),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: TextField(
                    obscureText: true,
                    controller: confirmPassword,
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(15),
                        labelText: "Confirm Password",
                        isDense: true,
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10)))),
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel File'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Submit'),
              onPressed: () {
                if (password.text != "") {
                  if (password.text == confirmPassword.text) {
                    Navigator.of(context).pop();
                    _showPreview(con, file, "Yes");
                  } else {
                    const snackdemo = SnackBar(
                      content: Text('Passwords Does Not Match'),
                      backgroundColor: Colors.red,
                      elevation: 10,
                      behavior: SnackBarBehavior.floating,
                      margin: EdgeInsets.all(5),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackdemo);
                  }
                } else {
                  const snackdemo = SnackBar(
                    content: Text('Please Enter Password'),
                    backgroundColor: Colors.red,
                    elevation: 10,
                    behavior: SnackBarBehavior.floating,
                    margin: EdgeInsets.all(5),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackdemo);
                }
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _showPreview(BuildContext con, filename, pass) async {
    return showDialog<void>(
      context: con,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Preview'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text("File :- $filename"),
                Text("Password :- $pass")
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel File'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Get QR'),
              onPressed: () {
                saveFileData(filename, pass == "No" ? '' : password.text);
                _uploadFile(file, con);
                password.clear();
                confirmPassword.clear();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _uploadFile(filePath, context) async {
    setState(() {
      showProgress=true;
    });
    String fileName = basename(filePath.path);
    try {
      FormData formData = new FormData.fromMap({
        "file": await MultipartFile.fromFile(filePath.path, filename: fileName),
      });
      Response response = await Dio().post(
          "https://vesgroup4.000webhostapp.com/uploads.php",
          data: formData);
      print(response.data.toString());
      if (response.data == "File Uploaded") {
        Navigator.push(
            context,
            PageTransition(
                child: QrPage(basename(file!.path.toString())),
                type: PageTransitionType.leftToRight));
      } 
      else {
        const snackdemo = SnackBar(
          content: Text('File Size Is Very Large'),
          backgroundColor: Colors.red,
          elevation: 10,
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.all(5),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackdemo);
      }
      setState(() {
        showProgress=false;
      });
    } catch (e) {
      print("expectation Caugch: $e");
    }
  }
}
