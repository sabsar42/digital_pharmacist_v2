import 'package:animated_weight_picker/animated_weight_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';

class ImageUpload extends StatefulWidget {
  String? userID;
  String? folderName;

  ImageUpload({Key? key, required this.userID, required this.folderName})
      : super(key: key);

  @override
  State<ImageUpload> createState() => _ImageUploadState();
}

class _ImageUploadState extends State<ImageUpload> {
  File? _image;
  final imagePicker = ImagePicker();

  Future imagePickerMethod(ImageSource source) async {
    final pick = await imagePicker.pickImage(source: source);
    setState(() {
      if (pick != null) {
        _image = File(pick.path);
      } else {
        showSnackBar('No Image Selected', Duration(microseconds: 300));
      }
    });
  }

  void showSnackBar(String message, Duration duration) {
    var snackbar = SnackBar(
      content: Text(message),
      duration: duration,
      backgroundColor: Colors.green,
    );

    ScaffoldMessenger.of(context).showSnackBar(snackbar);
  }

  Future<void> uploadImage() async {
    final postID = DateTime.now().millisecondsSinceEpoch.toString();
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    Reference ref = FirebaseStorage.instance
        .ref()
        .child("${widget.userID}/ehr_folder/${widget.folderName}")
        .child("post_${postID}.jpg");

    try {
      await ref.putFile(_image!);
      String downloadUrl = await ref.getDownloadURL();
      print(downloadUrl);

      await firebaseFirestore
          .collection("users")
          .doc(widget.userID)
          .collection("ehr_folders")
          .doc(widget.folderName)
          .collection('${widget.folderName}_images')
          .add({'downloadURL': downloadUrl})
          .whenComplete(() => showSnackBar(
              'Image uploaded successfully!', Duration(seconds: 2)))
          .then((value) => Navigator.pop(context));
    } catch (e) {
      print('Error uploading image: $e');
      showSnackBar(
          'Error uploading image. Please try again.', Duration(seconds: 2));
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
                    'UPLOAD EHR FILES',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                      color: Colors.deepPurple.shade700,
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
                              imagePickerMethod(ImageSource.gallery);
                            },
                            child: Icon(Icons.photo),
                            style: ElevatedButton.styleFrom(
                              primary: Colors.purple, // Background color
                              onPrimary: Colors.white, // Text color
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    10.0), // Rounded corners
                              ),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 30.0,
                                  vertical: 12.0), // Button padding
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              imagePickerMethod(ImageSource.camera);
                            },
                            child: Icon(Icons.camera_alt_outlined),
                            style: ElevatedButton.styleFrom(
                              primary: Colors.purple, // Background color
                              onPrimary: Colors.white, // Text color
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    10.0), // Rounded corners
                              ),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 30.0,
                                  vertical: 12.0), // Button padding
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          uploadImage();
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.deepPurple.shade900,
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
                      ),
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
