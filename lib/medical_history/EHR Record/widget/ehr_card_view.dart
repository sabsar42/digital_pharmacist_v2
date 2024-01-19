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
  }) : super(key: key);

  final String url;
  final String description;

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
              height: 600,
              width: 600,
              child: Image.network(
                widget.url,
                fit: BoxFit.fill,
              ),
            ),
          );
        });
  }

  Future shareImage() async {
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

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5),
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: Colors.grey.shade50,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(15),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      flex: 8,
                      child: InkWell(
                        child: Image.network(
                          widget.url,
                          height: 300,
                          width: 400,
                          fit: BoxFit.cover,
                        ),
                        onTap: () => showFullDialog(),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.deepPurple,
                          ),
                          icon: Icon(Icons.share),
                          onPressed: () {
                            shareImage();
                          },
                          label: Text('Share'),
                        ),
                      ),
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
