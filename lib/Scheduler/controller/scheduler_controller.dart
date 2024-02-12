import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class SchedulerController extends GetxController{
  late User currentUser;


  Future<void> getCurrentUser() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {

        currentUser = user;
        update();
    }
  }
  Future<List<Map<String, dynamic>>> getData() async {
    try {
      String userID = currentUser.uid;

      var result = await FirebaseFirestore.instance
          .collection('users')
          .doc(userID)
          .collection('remindersSet')
          .where("validtill", isGreaterThanOrEqualTo: Timestamp.now())
          .get();

      List<Map<String, dynamic>> records = [];

      result.docs.forEach((DocumentSnapshot document) {
        Map<String, dynamic> data = document.data() as Map<String, dynamic>;

        String medicineName = data['medicineName'] ?? 'Unknown Medicine';
        String type = data['type'] ?? 'Unknown Type';
        String pilltime = data['pilltime'] ?? 'Unknown';
        String pilllimit = data['pilllimit'] ?? 'Unknown';
        String duration = data['duration'] ?? 'Unknown Duration';
        String pillImage = data['pillImage'] ?? 'unknown';
        Timestamp startedDate = data['timestamp'] ?? 'Unknown Time';
        Timestamp validtillFB = data['validtill'] ?? 'Unknown Time';
        List<int> medicineTimes = List<int>.from(data['listoftimes'] ?? []);
        DateTime dateTime = startedDate.toDate().toLocal();
        DateTime validtillTime = validtillFB.toDate().toLocal();
        Duration difference = validtillTime.difference(DateTime.now());
        int indays = difference.inDays;
        String formattedDateTime = indays.toString();
        print('$medicineName: $medicineTimes');

        records.add({
          'documentID': document.id,
          'medicineName': medicineName,
          'type': type,
          'duration': duration,
          'time': formattedDateTime,
          'listoftimes': medicineTimes,
          'pilltime': pilltime,
          'pilllimit': pilllimit,
          'pillImage': pillImage,
        });
      });

      return records;
    } catch (error) {
      print("Error fetching records: $error");
      return [];
    }
  }
  String formatTime(int time) {
    int formattedTime = time % 12;
    if (formattedTime == 0) {
      formattedTime = 12;
    }
    String period = time >= 12 ? 'PM' : 'AM';
    return '$formattedTime $period';
  }


}