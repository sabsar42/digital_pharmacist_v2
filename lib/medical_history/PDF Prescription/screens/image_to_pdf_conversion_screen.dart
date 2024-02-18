import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class ImageToPDF extends StatefulWidget {
  final String uniqueDiagnosisNumber;

  const ImageToPDF({super.key, required this.uniqueDiagnosisNumber});

  @override
  State<ImageToPDF> createState() => _ImageToPDFState();
}

class _ImageToPDFState extends State<ImageToPDF> {
  File? _image;
  final imagePicker = ImagePicker();
  final pdf = pw.Document();

  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  late User currentUser;
  late String userID;

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  Future<void> getCurrentUser() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      setState(() {
        currentUser = user;
        userID = currentUser.uid;
      });
    }
  }

  void showSnackBar(String message, Duration duration) {
    var snackbar = SnackBar(
      content: Text(message),
      duration: duration,
      backgroundColor: Colors.green,
    );

    ScaffoldMessenger.of(context).showSnackBar(snackbar);
  }

  void _uploadPdf(ImageSource source) async {
    final pick = await imagePicker.pickImage(source: source);
    setState(() {
      if (pick != null) {
        _image = File(pick.path);
      } else {
        showSnackBar('No Image Selected', Duration(microseconds: 300));
      }
    });
  }

  createPdf() async {
    final image = pw.MemoryImage(_image!.readAsBytesSync());
    pdf.addPage(pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Center(child: pw.Image(image));
        }));
  }

  Future<String?> uploadPDF(String fileName, File file) async {
    final reference = FirebaseStorage.instance
        .ref()
        .child('${userID}')
        .child("pdf_folder/$fileName.pdf");
    final uploadTask = reference.putFile(file);
    await uploadTask.whenComplete(() {
      showSnackBar('SUCCESS', Duration(seconds: 3));
    });

    final downloadLink = await reference.getDownloadURL();
    return downloadLink;
  }

  savePDF() async {
    try {
      final dir = await getApplicationDocumentsDirectory();
      final file = File('${dir.path}/filename.pdf');

      /// CORRECT THE NAMING CONVENTION OF THE fileName;
      final fName = DateTime.now().millisecond;
      final downloadLink = await uploadPDF('local_files', file);
      await firebaseFirestore
          .collection("users")
          .doc(userID)
          .collection("healthRecords")
          .doc(widget.uniqueDiagnosisNumber)
          .collection("pdf_folders")
          .add({
            "name": '$fName.pdf',
            "url": downloadLink,
          })
          .whenComplete(() => showSnackBar(
              'Image uploaded successfully!', Duration(seconds: 2)))
          .then((value) => Navigator.pop(context));

      await file.writeAsBytes(await pdf.save());
      // print('path is ${dir?.path}');
      showSnackBar('SUCCESS', Duration(seconds: 3));
    } catch (e) {
      showSnackBar('FAILED', Duration(microseconds: 300));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(8),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: SizedBox(
              height: 500,
              width: double.infinity,
              child: Column(
                children: [
                  Text(
                    'CONVERT IMAGE TO PDF',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                      color: Color.fromRGBO(5, 70, 65, 1.0),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Expanded(
                    flex: 4,
                    child: Container(
                      width: 300,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: Colors.purple,
                        ),
                      ),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: _image == null
                                  ? Center(
                                      child: Text('NO IMAGE'),
                                    )
                                  : Image.file(_image!),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              _uploadPdf(ImageSource.gallery);
                            },
                            child: Column(
                              children: [Icon(Icons.photo), Text('Gallery')],
                            ),
                            style: ElevatedButton.styleFrom(
                              primary:  Color.fromRGBO(5, 70, 65, 1.0),// Background color
                              onPrimary: Colors.white, // Text color
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    10.0), // Rounded corners
                              ),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 19.0,
                                  vertical: 6.0), // Button padding
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              _uploadPdf(ImageSource.camera);
                            },
                            child: Column(
                              children: [
                                Icon(Icons.camera_alt_outlined),
                                Text('Camera')
                              ],
                            ),
                            style: ElevatedButton.styleFrom(
                              primary:  Color.fromRGBO(5, 70, 65, 1.0),// Background color
                              onPrimary: Colors.white, // Text color
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    10.0), // Rounded corners
                              ),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 19.0,
                                  vertical: 6.0), // Button padding
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          createPdf();
                          savePDF();
                        },
                        style: ElevatedButton.styleFrom(
                          primary:  Color.fromRGBO(5, 70, 65, 1.0),
                          // Background color
                          onPrimary: Colors.white,
                          // Text color
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(10.0), // Rounded corners
                          ),
                          padding: EdgeInsets.symmetric(
                              horizontal: 120.0,
                              vertical: 20.0), // Button padding
                        ),
                        child: Text('Upload Image'),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
