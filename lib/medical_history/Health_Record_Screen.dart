import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:digi_pharma_app_test/medical_history/Health_Record_Detailed.dart';

class HealthRecordScreen extends StatelessWidget {
  List<HealthRecord> generateHealthRecords() {
    List<HealthRecord> records = [];

    for (int i = 1; i <= 15; i++) {
      records.add(
        HealthRecord(
          diagnosisNumber: "00$i",
          doctorName: "Dr. Doctor $i",
          hospitalName: "Hospital/Clinic $i",
          date: "10/${16 + i}/2023",
          timeline: "${8 + i}:00 AM - ${9 + i}:30 AM",
        ),
      );
    }

    return records;
  }
  @override
  Widget build(BuildContext context) {
    List<HealthRecord> records = generateHealthRecords();

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70.0), // Adjust the preferred height
        child: ClipRRect(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(20), // Adjust the radius to control roundness
          ),
          child: AppBar(
            elevation: 10,
            backgroundColor: Color.fromRGBO(236, 220, 248, 1.0),
            title: Text(
                '\nHealth Records',
              style: TextStyle(
                fontSize: 24, // Adjust the font size
                color: Colors.deepPurple, // Text color
                fontWeight: FontWeight.bold, // Font weight
              ),
            ),
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: records.length,
        itemBuilder: (context, index) {
          return HealthRecordCard(record: records[index]);
        },
      ),
    );
  }
}

class HealthRecord {
  final String diagnosisNumber;
  final String doctorName;
  final String hospitalName;
  final String date;
  final String timeline;

  HealthRecord({
    required this.diagnosisNumber,
    required this.doctorName,
    required this.hospitalName,
    required this.date,
    required this.timeline,
  });
}
class HealthRecordCard extends StatelessWidget {
  final HealthRecord record;

  HealthRecordCard({required this.record});
  final customColor = Color.fromRGBO(8, 52, 109, 1.0);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // Navigate to the HealthRecord Detailed screen here
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => HealthRecordDetailScreen(diagnosisNumberfromPrev: 'diagnosisNumber'),
          ),
        );
      },
      child: Card(
        margin: EdgeInsets.all(10.0),
        color: customColor, // Set your preferred background color
        elevation: 20, // Add some elevation for a material design look
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(19.0), // Rounded corners
        ),
        child: Padding(
          padding: EdgeInsets.all(35.0),
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Diagnosis Number: ${record.diagnosisNumber}',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          'Date: ${record.date}',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundImage:
                        AssetImage('assets/doctor_avatar.png'), // Replace with the path to the doctor's avatar image
                        radius: 30, // Increase the radius for a larger avatar
                      ),
                      SizedBox(width: 16.0),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            record.doctorName,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            record.hospitalName,
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 8.0),
                    child: Text(
                      'Timeline: ${record.timeline}',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 0.0,
                    right: 8.0,
                    child: Icon(
                      Icons.link,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
