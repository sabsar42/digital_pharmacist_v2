import 'package:flutter/material.dart';

import 'Gallery Image Acces.dart';

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
      body: Column(
        children: [
          SizedBox(height: 180,),
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
                onTap: (){
                  Navigator.push(context,

                  MaterialPageRoute(builder: (context)=> GalleryImageAccess(),));
                },
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
                      width: 200, // Adjust the width and height as needed
                      height: 200,
                      child: Center(
                        child: Text(
                          'Upload from Gallery',
                          style: TextStyle(
                            fontWeight: FontWeight.w200,
                            color: Colors.purple,
                            fontSize: 22,
                          ),
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
            onPressed: () {},
            child: Text(
              'Open Camera',
              style: TextStyle(
                color: Colors.purple,
                fontSize: 20,
              ),
            ),
            style: ElevatedButton.styleFrom(

              backgroundColor:  Color.fromRGBO(236, 220, 248, 1.0),

            ),
          ),
        ],
      ),

    );
  }
}
