import 'package:digi_pharma_app_test/Scheduler/widget/SchedulerAppBar.dart';
import 'package:digi_pharma_app_test/Scheduler/widget/schedulerProfile.dart';
import 'package:digi_pharma_app_test/dasboard/dashboard_appbar.dart';
import 'package:digi_pharma_app_test/style.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';



class SchedulerScreen extends StatefulWidget {
  const SchedulerScreen({super.key});

  @override
  State<SchedulerScreen> createState() => _SchedulerScreenState();
}

class _SchedulerScreenState extends State<SchedulerScreen> {
  List<String> _generateLast7Days() {
    List<String> last7Days = [];
    for (int i = 3; i >= 0; i--) {
      DateTime currentDate = DateTime.now().subtract(Duration(days: i));
      String dayName = DateFormat('EEE').format(currentDate);
      String dayAndMonth = DateFormat('dd MMM').format(currentDate);
      last7Days.add('$dayName\n$dayAndMonth');
    }
    return last7Days;
  }

  List<String> _upComingDays() {
    List<String> upComingDays = [];
    for (int i = 1; i < 3; i++) {
      DateTime currentDate = DateTime.now().add(Duration(days: i));
      String dayName = DateFormat('EEE').format(currentDate);
      String dayAndMonth = DateFormat('dd MMM').format(currentDate);
      upComingDays.add('$dayName\n$dayAndMonth');
    }
    return upComingDays;
  }

  @override
  Widget build(BuildContext context) {
    List<String> last7Days = _generateLast7Days();
    String currentDate = DateFormat('EEE, dd MMM').format(DateTime.now());

    List<String> upComingDays = _upComingDays();

    return Scaffold(
      // appBar: AppBar(
      //   toolbarHeight: 200,
      //   backgroundColor: Colors.transparent,
      //   elevation: 0,
      //   flexibleSpace: SchedulerAppBar(),
      // ),
      body: Container(
      //  margin: EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          Expanded(
            flex:25,
            child:SafeArea(child: SizedBox(
                height: 200,
                child: schedulerProfileBar())),),


            Expanded(
              flex: 15,
              child: Container(
                margin: EdgeInsets.only(left: 5,right: 5),
                child: Column(children: [
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Reminder',
                    style: size30Black(),
                  ),
                  SizedBox(height: 10),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        Row(
                          // mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: last7Days
                              .map(
                                (date) => GestureDetector(
                                  onTap: () {
                                    print('Clicked on date');
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: date.contains(DateFormat('dd MMM')
                                                .format(DateTime.now()))
                                            ? Colors.blue
                                            : Colors.transparent,
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Text(
                                      date,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: date.contains(DateFormat('dd MMM')
                                                .format(DateTime.now()))
                                            ? Colors.blue
                                            : null,
                                      ),
                                    ),
                                  ),
                                ),
                              )
                              .toList(),
                        ),
                        Row(
                          // mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: upComingDays
                              .map(
                                (date) => Container(
                                  padding: EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: date.contains(DateFormat('dd MMM')
                                              .format(DateTime.now()))
                                          ? Colors.blue
                                          : Colors.transparent,
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Text(
                                    date,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: date.contains(DateFormat('dd MMM')
                                              .format(DateTime.now()))
                                          ? Colors.blue
                                          : null,
                                    ),
                                  ),
                                ),
                              )
                              .toList(),
                        ),
                      ],
                    ),
                  ),
                ]),
              ),
            ),
            Expanded(
              flex:60,
              child: Container(
                margin: EdgeInsets.only(left: 10,right: 10),
                height: 500, // Set a fixed height
                child: ListView.separated(
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return Container(
                      height: 70,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.transparent,
                        border: Border.all(color: Colors.black, width: 2),
                      ),
                      child: Center(
                        child: Text(
                          'Item $index',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    // This widget will be used as a separator between the items.
                    return Divider(
                      height: 10,
                    );
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
