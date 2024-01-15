import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import '../../style.dart';
import 'package:flutter/material.dart';

class MonthlyMedDetails extends StatefulWidget {
  const MonthlyMedDetails({Key? key, required this.index, required this.time1, this.time2});

  final int index;
  final TextEditingController time1;
  final TextEditingController? time2;

  @override
  State<MonthlyMedDetails> createState() => _MonthlyMedDetailsState();
}

class _MonthlyMedDetailsState extends State<MonthlyMedDetails> {
  late User currentUser;
  List<String> monthList =['January','February','March','April','May','June','July','August','September','October','November','December'];
  List<String> medImages =[ 'assets/images/dashboard_1.png', 'assets/images/dashboard_2.png', 'assets/images/dashboard_3.png', 'assets/images/dashboard_4.png',
    'assets/images/dashboard_1.png', 'assets/images/dashboard_2.png', 'assets/images/dashboard_3.png', 'assets/images/dashboard_4.png',
    'assets/images/dashboard_1.png', 'assets/images/dashboard_2.png', 'assets/images/dashboard_3.png', 'assets/images/dashboard_4.png',
    'assets/images/dashboard_1.png', 'assets/images/dashboard_2.png', 'assets/images/dashboard_3.png', 'assets/images/dashboard_4.png',

  ];

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  Future<void> getCurrentUser() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      setState(() {
        currentUser = user;
      });
    }
  }

  Future<List<Map<String, dynamic>>> getData() async {
    DateTime endMonth = DateFormat("yyyy-MM-dd").parse(widget.time1.text);
    DateTime prevEndMonth = DateFormat("yyyy-MM-dd").parse(widget.time2!.text);
    String userID = currentUser.uid;

    try {
      if(widget.index==0){
        var resultTimestamp = await FirebaseFirestore.instance
            .collection('users')
            .doc(userID)
            .collection('remindersSet')
            .where('timestamp', isLessThanOrEqualTo: endMonth)
            .get();



        List<Map<String, dynamic>> records = [];


        resultTimestamp.docs.forEach((DocumentSnapshot document) {
          Map<String, dynamic> data = document.data() as Map<String, dynamic>;

          records.add(data);
        });




        return records;
      }


      else{var resultTimestamp = await FirebaseFirestore.instance
          .collection('users')
          .doc(userID)
          .collection('remindersSet')
          .where('timestamp', isGreaterThanOrEqualTo: prevEndMonth)
          .where('timestamp', isLessThanOrEqualTo: endMonth)
          .get();

      var resultValidTill = await FirebaseFirestore.instance
          .collection('users')
          .doc(userID)
          .collection('remindersSet')
          .where('validtill', isGreaterThanOrEqualTo: prevEndMonth)
          .where('validtill', isLessThanOrEqualTo: endMonth)
          .get();

      List<Map<String, dynamic>> records = [];


      resultTimestamp.docs.forEach((DocumentSnapshot document) {
        Map<String, dynamic> data = document.data() as Map<String, dynamic>;

        records.add(data);
      });


      resultValidTill.docs.forEach((DocumentSnapshot document) {
        Map<String, dynamic> data = document.data() as Map<String, dynamic>;

        records.add(data);
      });

      return records;
      }
    } catch (error) {
      print("Error fetching records: $error");
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80.0),

        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            image: DecorationImage(
              image: AssetImage(
                "assets/images/dashboard_card.png",  // Replace with the URL of your image
              ),
              fit: BoxFit.cover,
            ),
          ),
          child: AppBar(
            toolbarHeight: 100,
            leading: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(
                Icons.arrow_back_ios,
                color: Colors.purple.shade50,
                size: 25,
              ),
            ),
            title: Container(
              margin: EdgeInsets.only(top: 30),
              child: Text(
                "${monthList[widget.index]} - 2024",
                style: siz22White(),
              ),
            ),
            centerTitle: true,
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
        ),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: getData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else {

            List<Map<String, dynamic>> data = snapshot.data ?? [];
            return CommonBackground(
              child: Column(
                children: [
                  SizedBox(height: 20,),
                  Expanded(
                    child: ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (context, index) {

                        return Container(

                          margin: EdgeInsets.fromLTRB(15, 5, 15, 5),
                          height: 110,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: Colors.grey,width: 1),
                            color: Color(0x76258c25),
                          ),
                          child:Row(
                            children:[
                              Container(
                                margin: EdgeInsets.all(10),
                                height: 100,
                                width: 80,

                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                    color: Color(0x76ffffff),
                                 // border: Border.all(color: Colors.red.shade100,width: 2),
                                  image: DecorationImage(
                                    image: AssetImage(
                                      medImages[index],

                                    ),
                                  )
                                ),
                              ),
                              SizedBox(width:20),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(data[index]['medicineName'],style: size25Black()),

                                  Text('Starting Date: ${DateFormat('yyyy-MM-dd').format(data[index]['timestamp'].toDate())}'),
                                  Text('Ending Date: ${DateFormat('yyyy-MM-dd').format(data[index]['validtill'].toDate())}'),
                                ],
                              ),
                            ]
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
