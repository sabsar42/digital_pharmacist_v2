import 'package:digi_pharma_app_test/style.dart';
import 'package:flutter/material.dart';

class SchedulerSettingsScreen extends StatefulWidget {
  const SchedulerSettingsScreen({super.key});


  @override
  State<SchedulerSettingsScreen> createState() =>
      _SchedulerSettingsScreenState();
}

class _SchedulerSettingsScreenState extends State<SchedulerSettingsScreen> {
  String dropdownvalue = 'Item 1';

  var items = [
    'Item 1',
    'Item 2',
    'Item 3',
    'Item 4',
    'Item 5',
  ];
  var colors = [
    Color(0x5903593f),
    Color(0x59F11212),
    Color(0xFFFF6B00),
    Color(0x5903593f),
    Color(0x59F11212),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: (){

          },
          child: Icon(
            Icons.arrow_back,
            color: Colors.black,
            size: 30,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: ListView(
        children: [
          Container(
            margin: EdgeInsets.fromLTRB(15, 15, 10, 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Set Remidners',
                  style: siz31Black(),
                ),
                const SizedBox(
                  height: 40,
                ),
                Center(
                  child: Image.asset(
                    'assets/images/dashboard_1.png',
                    height: 202,
                    width: 202,
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                Text(
                  'Medicine Name',
                  style: siz20Black(),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
                  height: 44,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(color: Color(0xff040359), width: 2)),
                  child: DropdownButton(
                    value: dropdownvalue,
                    elevation: 0,
                    icon: const Icon(Icons.keyboard_arrow_down),
                    items: items.map((String items) {
                      return DropdownMenuItem(
                        value: items,
                        child: Text(items),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        dropdownvalue = newValue!;
                      });
                    },
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'Type',
                  style: siz20System(),
                ),
                Container(
                  height: 100,
                  child: ListView.builder(
                      itemCount: 5,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
                          height: 72,
                          width: 82,

                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: colors[index],
                          ),
                          //color: Colors.red,
                        );
                      }),
                ),
                Text(
                  'Time & Schedule',
                  style: size25Black(),
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      Container(
                        margin: EdgeInsets.all(10),
                        height: 30,
                        width: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.green,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(10),
                        height: 30,
                        width: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.yellow,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(10),
                        height: 30,
                        width: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.deepOrangeAccent,
                        ),
                      ),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xff08346D)
                          ),


                          onPressed: () {}, child: Icon(Icons.add))
                    ],
                  ),
                ),
                Card(
                  margin: EdgeInsets.fromLTRB(5, 15, 5, 5),
                  elevation: 10,
                  // height: 200,
                  // width: double.infinity,
                  // color: Colors.black,
                  child: Container(
                    margin: EdgeInsets.all(20),
                    height: 180,
                    width: double.infinity,
                    color: Colors.white,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              'Start',
                              style: siz20Black(),
                            ),
                            CustomDropdown(
                              items: ['Today', 'Yesterdat'],
                              initialValue: 'Today',
                              onChanged: (String newValue) {},
                            ),
                            Icon(Icons.add),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              'Duration',
                              style: siz20Black(),
                            ),
                            CustomDropdown(
                              items: [
                                '3 Days',
                                '7 Days',
                                '15 Days',
                                '1 Month',
                                '2 Month'
                              ],
                              initialValue: '3 Days',
                              onChanged: (String newValue) {},
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              'Frequency',
                              style: siz20Black(),
                            ),
                            CustomDropdown(
                              items: [
                                'Everyday',
                                'Twice a Day',
                                'Thrice a Day'
                              ],
                              initialValue: 'Everyday',
                              onChanged: (String newValue) {},
                            ),
                            Icon(Icons.add),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              'Alarm',
                              style: siz20Black(),
                            ),
                            Icon(Icons.add),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Center(
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xff08346D),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          )),
                      onPressed: () {},
                      child: Text(
                        "Add Reminders",
                        style: size20White(),
                      )),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CustomDropdown extends StatefulWidget {
  final List<String> items;
  final String initialValue;
  final Function(String) onChanged;

  CustomDropdown({
    required this.items,
    required this.initialValue,
    required this.onChanged,
  });

  @override
  _CustomDropdownState createState() => _CustomDropdownState();
}

class _CustomDropdownState extends State<CustomDropdown> {
  String dropdownValue = '';

  @override
  void initState() {
    super.initState();
    dropdownValue = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: dropdownValue,
      elevation: 0,
      icon: const Icon(Icons.keyboard_arrow_down),
      items: widget.items.map((String item) {
        return DropdownMenuItem<String>(
          value: item,
          child: Text(item),
        );
      }).toList(),
      onChanged: (String? newValue) {
        setState(() {
          dropdownValue = newValue!;
          widget.onChanged(dropdownValue);
        });
      },
    );
  }
}
