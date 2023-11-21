import 'package:flutter/material.dart';

class UploadScreenPreview extends StatefulWidget {
  const UploadScreenPreview({super.key});

  @override
  State<UploadScreenPreview> createState() => _UploadScreenPreviewState();
}

class _UploadScreenPreviewState extends State<UploadScreenPreview> {
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
      body: Center( child:
        Container(
          width: 300,
          height: 300,
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.greenAccent
            ),
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),

      ),
    );
  }
}
