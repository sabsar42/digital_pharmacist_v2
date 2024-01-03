import 'dart:io';

import 'package:digi_pharma_app_test/Camera%20Scanner/ResultBardHomePage.dart';
import 'package:digi_pharma_app_test/Camera%20Scanner/camera_screen.dart';
import 'package:digi_pharma_app_test/Camera%20Scanner/result_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:image_picker/image_picker.dart';

import 'Gallery Image Acces.dart';

class UploadScreenPreview extends StatefulWidget {
  const UploadScreenPreview({super.key});

  @override
  State<UploadScreenPreview> createState() => _UploadScreenPreviewState();
}


class _UploadScreenPreviewState extends State<UploadScreenPreview> {
  File? galleryFile;
  final picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70.0),
        child: ClipRRect(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(20),
          ),
          child: AppBar(
            elevation: 10,
            backgroundColor: Colors.transparent,
            title: Text(
              '\nUpload Your Prescription',
              style: TextStyle(
                fontSize: 24,
                color: Colors.deepPurple,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 120,
          ),
          Center(
            child: Container(
              margin: EdgeInsets.all(10.0),
              width: 350,
              height: 350,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.deepPurple,
                  style: BorderStyle.solid,
                ),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: InkWell(
                onTap: () {
                  _showPicker(context: context);
                },
                // getImage(ImageSource.gallery);
                // Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //       builder: (context) => GalleryImageAccess(),
                //     ));

                child: Container(
                  margin: EdgeInsets.all(30.0),
                  // Add margin to create space for the inner border
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.purple,
                    ),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Center(
                    child: Container(
                      width: 300, // Adjust the width and height as needed
                      height: 300,
                      child: Center(
                        child: Stack(
                          children: [
                            SizedBox(
                              height: 350.0,
                              width: 350.0,
                              child: galleryFile == null
                                  ? Center(
                                child: Text(
                                  'Upload from Gallery',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w200,
                                    color: Colors.purple,
                                    fontSize: 22,
                                  ),
                                ),
                              )
                                  : Center(child: Image.file(galleryFile!)),
                            ),
                          ],
                        ),
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.white,
                        ),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 60),
          ElevatedButton(
            onPressed: () {
              _scanImage(galleryFile!);
            },
            child: Text(
              'Scan Text',
              style: TextStyle(
                color: Color.fromRGBO(197, 217, 231, 1.0),
                fontSize: 20,
              ),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: Color.fromRGBO(53, 12, 89, 1.0),
              minimumSize: Size(300, 50),
            ),
          ),
        ],
      ),
    );
  }

  void _showPicker({
    required BuildContext context,
  }) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Wrap(
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Photo Library'),
                onTap: () {
                  getImage(ImageSource.gallery);
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_camera),
                title: const Text('Camera'),
                onTap: () {
                  getImage(ImageSource.camera);
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future getImage(ImageSource img,) async {
    final pickedFile = await picker.pickImage(source: img);
    XFile? xfilePick = pickedFile;
    setState(
          () {
        if (xfilePick != null) {
          galleryFile = File(pickedFile!.path);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            // is this context <<<
            const SnackBar(
              content: Text('Nothing is selected'),
            ),
          );
        }
      },
    );
  }


  Future<void> _scanImage(File ImageFile) async {
    final navigator = Navigator.of(context);

    try {
      final textRecognizer = TextRecognizer();
      final file = ImageFile;
      final inputImage = InputImage.fromFile(file!);

      final RecognizedText recognizedTexts = await textRecognizer.processImage(
          inputImage);

      print('Recognized Text: ${recognizedTexts.text}');

      await navigator.push(
        MaterialPageRoute(
          builder: (BuildContext context) =>
              ResultBardHomePage(txt: recognizedTexts.text),
        ),
      );

    } catch (e) {
      print('Error during text recognition: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('An error occurred when scanning text'),
        ),
      );
    }
  }
}


// Future<void> _scanImage() async {
//     if (_cameraController == null) return;
//
//     final navigator = Navigator.of(context);
//
//     try {
//       final pictureFile = await _cameraController!.takePicture();
//
//       //final file = File(pictureFile.path);
//       final file = widget.ImageFile;
//
//       final inputImage =
//           InputImage.fromFile(file!); // The Input Image Is HERE !!!!!
//       final recognizedText = await textRecognizer.processImage(inputImage);
//
//       await navigator.push(
//         MaterialPageRoute(
//           builder: (BuildContext context) =>
//               ResultScreen(text: recognizedText.text),
//         ),
//       );
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//           content: Text('An error occurred when scanning text'),
//         ),
//       );
//     }
//   }
// }