import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:esys_flutter_share_plus/esys_flutter_share_plus.dart';
import 'package:http/http.dart' as http;

class EhrCardView extends StatelessWidget {
  const EhrCardView({
    Key? key,
    required this.url,
    required this.description,
  }) : super(key: key);

  final String url;
  final String description;

  //
  // Future<void> _shareImage() async {
  //   final imageUrl = Uri.parse(url);
  //   final response = await http.get(imageUrl);
  //
  //   print(url);
  //   print(imageUrl);
  //   if (response.statusCode == 200) {
  //     await Share.file(
  //       'EHR Image',
  //       'ehr_image.jpg',
  //       response.bodyBytes,
  //       'image/jpg',
  //     );
  //   } else {
  //     print('Failed to download image. Status code: ${response.statusCode}');
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(15),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 8,
                    child: Image.network(
                      url,
                      height: 250,
                      width: 300,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        description,
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: IconButton(
                          icon: Icon(Icons.share),
                          onPressed: () {
                            //  print(url);
                            //  _shareImage();
                          }),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
