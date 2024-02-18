import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import 'package:share_plus/share_plus.dart';

class EhrCardView extends StatefulWidget {
  const EhrCardView({
    Key? key,
    required this.url,
    required this.description,
    required this.onDelete,
  }) : super(key: key);

  final String url;
  final String description;
  final VoidCallback onDelete;

  @override
  State<EhrCardView> createState() => _EhrCardViewState();
}

class _EhrCardViewState extends State<EhrCardView> {
  Future<void> showFullDialog() {
    return showDialog(
      context: context,
      builder: (BuildContext contex) {
        return AlertDialog(
          content: Container(
            height: 800,
            width: 1200,
            child: Image.network(
              widget.url,
              fit: BoxFit.cover,
            ),
          ),
        );
      },
    );
  }

  Future<void> shareImage() async {
    final uri = Uri.parse(widget.url);
    final response = await http.get(uri);
    if (response.statusCode == ConnectionState.waiting) {
      print(response.statusCode);
      Center(
        child: CircularProgressIndicator(),
      );
    } else {
      final imageBytes = response.bodyBytes;
      final tempDirectory = await getApplicationDocumentsDirectory();
      final path = '${tempDirectory.path}/_ehrImage.jpg';
      File(path).writeAsBytes(imageBytes);
      Share.shareFiles([path], text: 'Ehr_Image');
    }
  }

  Future<void> confirmDelete() async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Confirm Deletion"),
          content: Text("Are you sure you want to delete this EHR image?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                widget.onDelete();
                Navigator.of(context).pop();
              },
              child: Text("Yes"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15),
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.grey.shade50,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(15),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Expanded(
                      flex: 8,
                      child: InkWell(
                        child: Image.network(
                          widget.url,
                          height: 600,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                        onTap: () => showFullDialog(),
                      ),
                    ),
                    SizedBox(width: 20),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.deepPurple,
                          ),
                          iconSize: 16,
                          icon: Icon(
                            Icons.share,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            shareImage();
                          },
                        ),
                        SizedBox(height: 20),
                        IconButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                          ),
                          iconSize: 16,
                          icon: Icon(
                            Icons.delete,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            confirmDelete();
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
