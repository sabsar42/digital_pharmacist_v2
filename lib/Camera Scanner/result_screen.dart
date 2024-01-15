import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Gemini Digi-BOT/sections/stream.dart';
import '../Google Berd/BardAiController.dart';
import '../Google Berd/BardHomePage.dart';
import 'ResultBardHomePage.dart';
import 'gemini_text_to_medRecord.dart';
import 'result_in_pdf_page.dart';

class ResultScreen extends StatelessWidget {
  final String text;

  const ResultScreen({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final BardAIController controller = Get.put(BardAIController());
    final TextEditingController textField = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Text('Recognized Text'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding:  EdgeInsets.all(20.0),
          child: Container(
            height:  MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Wrap(
              children: [
                Text(
                  text,
                  textAlign: TextAlign.justify,
                  style: TextStyle(fontSize: 18.0),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => TextRecogSectionTextStreamInput(initialText: text,)
            ),
          );
        },
        child: Icon(
          Icons.arrow_forward_ios,
          color: Colors.white,
        ),
        backgroundColor: Colors.indigo,
      ),
    );
  }
}
