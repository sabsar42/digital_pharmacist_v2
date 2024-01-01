import 'package:digi_pharma_app_test/Scheduler/Screen/SchedulerSettingsScreen.dart';
import 'package:flutter/material.dart';
import 'package:digi_pharma_app_test/style.dart';

class SchedulerAppBar extends StatefulWidget {
  const SchedulerAppBar({super.key});

  @override
  State<SchedulerAppBar> createState() => _SchedulerAppBarState();
}

class _SchedulerAppBarState extends State<SchedulerAppBar> {
  @override
  Widget build(BuildContext context) {
    return Container(

      child: Stack(
        children: [
          Container(
            padding: EdgeInsets.only(top: 15, left: 15),
            // color: Colors.green,
          ),
          Positioned(
            top: 15,
            left: 10,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 33,
                  backgroundColor: Colors.white,
                  child: Icon(
                    Icons.person,
                    size: 55,
                    color: Colors.black,
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Hello Shuvo Sonjoy",
                        style: siz22White(),
                      ),
                      Text(
                        "ID: 2112s2X",
                        style: size20White(),
                      ),
                      Text(
                        "Age: 22",
                        style: size20White(),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          Positioned(
              top: 110,
              left: 10,
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Create New Schedule',
                      style: siz22White(),
                    ),
                    SizedBox(height: 5,),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                      ),


                        onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>SchedulerSettingsScreen()));
                        },
                        child: Text(
                          'Create',
                          style: siz20System(),
                        ))
                  ],
                ),
              ))
        ],
      ),
      decoration: BoxDecoration(
          color: Color(0xff08346D),
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20))),
    );
  }
}
