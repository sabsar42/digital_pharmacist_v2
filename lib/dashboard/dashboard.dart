import 'dashbaord_appbar.dart';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:digi_pharma_app_test/monthlyMed.dart';
import 'package:digi_pharma_app_test/style.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.transparent,

        color: Color(0xff08346D),
       // color:Colors.transparent,
        animationDuration: Duration(milliseconds: 290),
        items: [
          Icon(
            Icons.camera_alt,
            color: Color(0xffF68D8D),
            size: 40,
          ),
          Icon(
            Icons.home,
            color: Color(0xffB3C3FD),
            size: 40,
          ),
          Icon(
            Icons.settings,
            color: Color(0xffB3C3FD),
            size: 40,
          ),
        ],
      ),

      appBar: AppBar(
        toolbarHeight: 200,
        backgroundColor: Colors.transparent,
        elevation: 0,
        flexibleSpace: dashboardAppbar(),
      ),


      body: Container(
        margin: EdgeInsets.only(left: 20, top: 18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Medical History", style: siz31Black()),
            Container(
              margin: EdgeInsets.all(15),
              child: Row(
                children: [
                  Expanded(
                    flex: 50,
                    child: Container(
                      //  padding: const EdgeInsets.only(top: 20),
                      //  margin: EdgeInsets.only(left: 5),

                      child: Container(
                        height: 68,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          boxShadow:[BoxShadow(color: Colors.grey)],
                            borderRadius: BorderRadius.circular(15),
                            //color: Color(0xffFACE8C),
                            color: Colors.white,

                            // border: Border.all(
                            //   color: Colors.black,
                            //   width: 1.1,
                            // )
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 25,
                    child: Container(
                      margin: EdgeInsets.only(left: 12),
                      child: Container(
                        height: 69,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Color(0xffa0d28f),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.black),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 25,
                    child: Container(
                      margin: EdgeInsets.only(left: 14),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => monthlyMed()));
                        },
                        child: Stack(
                          children: [
                            Container(
                              height: 69,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Color(0x5453405e),
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: Colors.black),
                              ),
                            ),
                            Positioned(
                                top: 5,
                                left: 5,
                                bottom: 5,
                                right: 5,
                                child: Image.asset('images/dashboard_3.png'))
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(0, 40, 5, 5),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Medicine",
                    style: siz31Black(),
                  ),
                  SizedBox(
                    height: 18,
                  ),
                  Container(
                    width: 154,
                    height: 128,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(color: Colors.black),
                      color: Color(0xff90b6f0),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}


