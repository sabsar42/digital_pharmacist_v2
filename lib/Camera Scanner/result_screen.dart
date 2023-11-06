import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../Google Berd/BardAiController.dart';
import '../Google Berd/BardHomePage.dart';
import 'ResultBardHomePage.dart';
import 'result_in_pdf_page.dart';

class ResultScreen extends StatelessWidget {
  final String text;

  const ResultScreen({super.key, required this.text});


  @override
  Widget build(BuildContext context) {
    BardAIController controller = Get.put(BardAIController());
    TextEditingController textField = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Result'),
      ),
      body: Container(
        padding: const EdgeInsets.all(30.0),
        child: Text(text),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {


          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  ResultBardHomePage(txt: text)
            ),
          );
        },
        child: Text('Genetate Summary'),
      ),
    );
  }
}
