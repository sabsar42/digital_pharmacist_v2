import 'package:flutter/material.dart';


class dashboardAppbar extends StatefulWidget {
  const dashboardAppbar({super.key});

  @override
  State<dashboardAppbar> createState() => _dashboardAppbarState();
}


class _dashboardAppbarState extends State<dashboardAppbar> {
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
                        style: TextStyle(fontSize: 20),
                      ),
                      Text(
                        "ID: 2112s2X",
                        style: TextStyle(fontSize: 20),
                      ),
                      Text(
                        "Age: 22",
                        style: TextStyle(fontSize: 20),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          Positioned(
            top: 140,
            left: 45,
            child: Stack(
              children: [
                Container(
                  height: 40,
                  width: 235,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 2),
                      color: Color(0xffB3C3FD),
                      borderRadius: BorderRadius.circular(10)),
                ),
                Positioned(
                    bottom: 5,
                    top: 5,
                    left: 10,
                    child: Row(
                      children: [
                        Container(
                          width: 30,
                          height: double.infinity,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(
                                'images/dashboard_3.png',
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Pill 2X",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w400),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            Container(
                              width: 100,
                              height: 35,
                              decoration: BoxDecoration(
                                border:
                                Border.all(color: Colors.black, width: 1),
                                color: Color(0xffF68D8D),
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            Text(
                              "9.00AM",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w500),
                            )
                          ],
                        ),
                      ],
                    ))
              ],
            ),
          ),
          Positioned(
            top: 138,
            left: 300,
            child: Stack(
              children: [
                Container(
                  height: 45,
                  width: 55,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 1),
                    borderRadius: BorderRadius.circular(8),
                    color: Color(0xffFFEF99),
                  ),
                ),
                Positioned(
                  bottom: 3,
                  top: 3,
                  left: 3,
                  right: 3,
                  child: CircleAvatar(
                    radius: 2,
                    backgroundImage: AssetImage('assets/images/logo-one.jpeg'),
                  ),
                ),
              ],
            ),
          ),
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