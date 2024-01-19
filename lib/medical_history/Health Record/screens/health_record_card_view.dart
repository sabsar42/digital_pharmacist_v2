import 'package:flutter/material.dart';

import 'Health_Record_Screen.dart';
import '../../TabBar_View.dart';

class HealthRecordCard extends StatelessWidget {
  final HealthRecord record;
  // final String uniqueDocID;
  HealthRecordCard({required this.record});

  @override
  Widget build(BuildContext context) {
    final customColor = Color.fromRGBO(8, 52, 109, 1.0);

    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => TabBarScreen(uniqueDocID: record.docID),
          ),
        );
      },
      child: Card(
        margin: EdgeInsets.all(10.0),
        color: customColor,
        elevation: 8,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.0),
            image: DecorationImage(
              image: AssetImage("assets/images/dashboard_card.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Card(
                  color: Colors.deepPurple.shade800,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(6, 5, 10, 5),
                    child: Text(
                      'Category : ${record.diagnosisType}',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Diagnosis Number: ${record.diagnosisNumber}',
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w300,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      'Date: ${record.date}',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.yellow.shade200,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 12),
                Row(
                  children: [
                    CircleAvatar(
                      backgroundImage: AssetImage('assets/images/doctor.png'),
                      radius: 30,
                    ),
                    SizedBox(width: 16.0),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          record.doctorName.startsWith('Dr.')
                              ? record.doctorName
                              : 'Dr. ' + record.doctorName,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          record.specialization,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.blueAccent,
                          ),
                        ),
                        Text(
                          record.hospitalName,
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.pink,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 12),
                Text(
                  'Time: ${record.time}',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 12),
                Align(
                  alignment: Alignment.centerRight,
                  child: CircleAvatar(
                    backgroundColor:
                        record.isCompleted ? Colors.green : Colors.grey,
                    radius: 16,
                    child: Icon(
                      Icons.done_outline_rounded,
                      color: record.isCompleted
                          ? Colors.white
                          : Colors.black45,
                      size: 20,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
