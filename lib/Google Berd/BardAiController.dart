import 'dart:convert';
import 'dart:developer';

import 'package:digi_pharma_app_test/Google Berd/BardModel.dart';
import 'package:digi_pharma_app_test/Google Berd/data_key.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import 'package:digi_pharma_app_test/Camera Scanner/result_in_pdf_page.dart';
import 'BardModel.dart';
import 'package:get_it/get_it.dart';

class BardAIController extends GetxController {
  RxList historyList = RxList<BardModel>([
    BardModel(system: "user", message: "What can you do for me"),
    BardModel(system: "bard", message: "What can you do for me"),
  ]);

  // Define a variable to store the Bard API response.
  String apiResponse = '';

  // Method to update the API response and notify listeners.
  void updateApiResponse(String response) {
    apiResponse = response;
    update(); // Notify listeners that the response has been updated.
  }

  RxBool isLoading = false.obs;

  void sendPrompt(String prompt) async {
    isLoading.value = true;
    var newHistory = BardModel(system: "user", message: prompt);
    historyList.add(newHistory);
    final body = {
      'prompt': {
        'text': prompt,
      },
    };

    final request = await http.post(
      Uri.parse(
          'https://generativelanguage.googleapis.com/v1beta2/models/text-bison-001:generateText?key=$APIKEY'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(body),
    );

    final response = jsonDecode(request.body);
    final bardReplay = response["candidates"][0]["output"];
    String ans = bardReplay.toString();
    print(ans);
    updateApiResponse(ans);
    var newHistory2 = BardModel(system: "bard", message: bardReplay);
    historyList.add(newHistory2);
    print(bardReplay.toString());
    isLoading.value = false;
  }
}

class result {
  final String resultPdf;

  result(
    this.resultPdf,
  );
}
