// import 'dart:convert';
//

// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:transformable_list_view/transformable_list_view.dart';
// import 'package:digi_pharma_app_test/medical_history/Health_Record_Detailed.dart';
// import 'TabBar_View.dart';
// import 'TranformableListView_Packagea_Method.dart';
// import 'package:http/http.dart' as http;
//
// class HealthRecordScreenApi extends StatefulWidget {
//   const HealthRecordScreenApi({Key? key}) : super(key: key);
//
//   @override
//   _HealthRecordScreenApiState createState() => _HealthRecordScreenApiState();
// }
//
// class _HealthRecordScreenApiState extends State<HealthRecordScreenApi> {
//   void getUsers() async {
//     const url = 'https://randomuser.me/api/?results=10';
//     final uri = Uri.parse(url);
//     final response = await http.get(uri);
//     final body = response.body;
//     final json = jsonDecode(body);
//     setState(() {
//       records = json['results'];
//     });
//   //  print( ${randomU)
//     print(json['results'][1]['name']['first']);
//   }
//
//
//
//
//   List<dynamic> records = [];
//
//   List<HealthRecord> generateHealthRecords() {
//
//     List<HealthRecord> record = [];
//
//     for (int i = 0; i < records.length; i++) {
//       final randomUser = records[i];
//       //print('Fetched Data: $randomUser');
//       record.add(
//         HealthRecord(
//           diagnosisNumber:  "00$i",
//           doctorName: " ${randomUser['name']['first']}",
//           hospitalName: "Hospital/Clinic ${randomUser['city']}",
//           date: "${randomUser['dob']['date']}",
//           timeline: "${8 + i}:00 AM - ${9 + i}:30 AM",
//           img : randomUser['picture']['thumbnail'],
//         ),
//       );
//     }
//
//     return record;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     List<HealthRecord> records = generateHealthRecords();
//
//     return Scaffold(
//       appBar: PreferredSize(
//         preferredSize: Size.fromHeight(70.0), // Adjust the preferred height
//         child: ClipRRect(
//           borderRadius: BorderRadius.vertical(
//             bottom: Radius.circular(20), // Adjust the radius to control roundness
//           ),
//           child: AppBar(
//             elevation: 10,
//             backgroundColor: Color.fromRGBO(236, 220, 248, 1.0),
//             title: Text(
//               '\nHealth Records',
//               style: TextStyle(
//                 fontSize: 24, // Adjust the font size
//                 color: Colors.deepPurple, // Text color
//                 fontWeight: FontWeight.bold, // Font weight
//               ),
//             ),
//           ),
//         ),
//       ),
//       body: ListView.builder(
//         itemCount: records.length,
//         itemBuilder: (context, index) {
//           return HealthRecordCard(record: records[index]);
//         },
//       ),
//     );
//   }
// }
//
// class HealthRecord {
//   final String diagnosisNumber;
//   final String doctorName;
//   final String hospitalName;
//   final String date;
//   final String timeline;
//   final img;
//
//   HealthRecord({
//     required this.diagnosisNumber,
//     required this.doctorName,
//     required this.hospitalName,
//     required this.date,
//     required this.timeline,
//     required this.img,
//   });
// }
// class HealthRecordCard extends StatelessWidget {
//   final HealthRecord record;
//
//   HealthRecordCard({required this.record});
//   final customColor = Color.fromRGBO(8, 52, 109, 1.0);
//
//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: () {
//         Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (context) => HealthRecordDetailScreen(
//               diagnosisNumberfromPrev: record.diagnosisNumber, // Use the actual diagnosis number
//             ),
//           ),
//         );
//       },
//
//       child: Card(
//         margin: EdgeInsets.all(10.0),
//         color: customColor, // Set your preferred background color
//         elevation: 20, // Add some elevation for a material design look
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(19.0), // Rounded corners
//         ),
//         child: Padding(
//           padding: EdgeInsets.all(35.0),
//           child: Stack(
//             children: [
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Padding(
//                     padding: EdgeInsets.symmetric(vertical: 8.0),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Text(
//                           'Diagnosis Number: ${record.diagnosisNumber}',
//                           style: TextStyle(
//                             fontSize: 16,
//                             fontWeight: FontWeight.bold,
//                             color: Colors.white,
//                           ),
//                         ),
//                         Text(
//                           'Date: ${record.date}',
//                           style: TextStyle(
//                             fontSize: 16,
//                             color: Colors.white,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   Row(
//                     children: [
//                       // CircleAvatar(
//                       //
//                       //   backgroundImage:
//                       //  // Image.network( 'record.img' ), // Replace with the path to the doctor's avatar image
//                       // //  radius: 30, // Increase the radius for a larger avatar
//                       // ),
//                       SizedBox(width: 16.0),
//                       Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             record.doctorName,
//                             style: TextStyle(
//                               fontSize: 18,
//                               fontWeight: FontWeight.bold,
//                               color: Colors.white,
//                             ),
//                           ),
//                           Text(
//                             record.hospitalName,
//                             style: TextStyle(
//                               fontSize: 16,
//                               color: Colors.white,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                   Padding(
//                     padding: EdgeInsets.only(top: 8.0),
//                     child: Text(
//                       'Timeline: ${record.timeline}',
//                       style: TextStyle(
//                         fontSize: 16,
//                         color: Colors.white,
//                       ),
//                     ),
//                   ),
//                   Positioned(
//                     top: 0.0,
//                     right: 8.0,
//                     child: Icon(
//                       Icons.link,
//                       color: Colors.white,
//                       size: 24,
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }