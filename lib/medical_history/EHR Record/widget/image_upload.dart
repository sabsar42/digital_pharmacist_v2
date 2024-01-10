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

  ImageUpload({super.key, required this.userID,required this.folderName});

  @override
  State<ImageUpload> createState() => _ImageUploadState();
}

class _ImageUploadState extends State<ImageUpload> {
  File? _image;
  final imagePicker = ImagePicker();

  //Image picker

  Future imagePickerMethod() async {
    final pick = await imagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pick != null) {
        _image = File(pick.path);
      } else {
        showSnackBar('No Image Seleced', Duration(microseconds: 300));
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

// Firebase Upload

  String? downloadUrl;

  Future<void> uploadImage() async {
    final postID = DateTime.now().millisecondsSinceEpoch.toString();
    Reference ref = FirebaseStorage.instance
        .ref()
        .child("${widget.userID}/ehr_folder/${widget.folderName}")
        .child("post_${postID}.jpg");


    try {
      await ref.putFile(_image!);
      downloadUrl = await ref.getDownloadURL();
      print(downloadUrl);
      showSnackBar('Image uploaded successfully!', Duration(seconds: 2));
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
                  Text('UPLOAD EHR FILES'),
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
                                      : Image.file(_image!)),
                              ElevatedButton(
                                  onPressed: () {
                                    imagePickerMethod();
                                  },
                                  child: Text('Select Image')),
                              ElevatedButton(
                                  onPressed: () {
                                    uploadImage();
                                  },
                                  child: Text('Upload Image'))
                            ],
                          ),
                        ),
                      ))
                ],
              ),
            ),
          )),
    ));
  }
}
