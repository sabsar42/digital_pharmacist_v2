import 'package:carousel_slider/carousel_slider.dart';
import '../../style.dart';
import 'package:flutter/material.dart';

class monthlyMedDetails extends StatelessWidget {
  const monthlyMedDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back,
            color: Colors.black87,
            size: 35,
          ),
        ),
        title: Container(
          margin: EdgeInsets.only(top: 30),
          child: Text(
            "Med from 2Apr - 2May",
            style: size25Black(),
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: ListView(
        children: [
          Container(
            margin: EdgeInsets.fromLTRB(10, 30, 10, 10),
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 80,
                        child: TextFormField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            fillColor: Color(0xff08346D),
                            filled: true,
                            label: Text(
                              'Search here....',
                              style: size20Gray(),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 20,
                        child: Container(
                          margin: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Color(0xff08346D),
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.black87),
                          ),
                          height: 50,
                          width: double.infinity,
                          child: Icon(
                            Icons.search,
                            color: Colors.white,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
              margin: EdgeInsets.only(left: 20, bottom: 20, top: 10),
              child: Text(
                "Total medicines: 3",
                style: size30Black(),
              )),
          CarouselSlider(
              items: [
                Container(
                  height: 500,
                  width: 500,
                  margin: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Color(0xff040359),
                  ),
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment.topCenter,
                        child: Container(
                          margin: EdgeInsets.only(top: 10),
                          height: 100,
                          width: 200,
                          decoration: BoxDecoration(
                              color: Color(0xff08346D),
                              borderRadius: BorderRadius.circular(20)),
                        ),
                      ),
                      Align(
                        alignment: Alignment.topCenter,
                        child: Container(
                            margin: EdgeInsets.only(top: 10),
                            height: 100,
                            width: 100,
                            child: Image.asset(
                              'assets/images/syrup.png',
                            )),
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          margin: EdgeInsets.all(5),
                          child: Stack(
                            children: [
                              Positioned(
                                  // alignment: Alignment.bottomCenter,
                                  bottom: 30,
                                  left: 65,
                                  child: ElevatedButton(
                                    onPressed: () {},
                                    child: Text(
                                      'Details',
                                      style: TextStyle(
                                          color: Color(0xff040359),
                                          fontFamily: 'Fontmain'),
                                    ),
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: Color(0xffFFFFFF),
                                        elevation: 100),
                                  )),
                              Align(
                                alignment: Alignment.bottomCenter,
                                child: Container(
                                  margin: EdgeInsets.only(top: 5),
                                  child: Text(
                                    'XYX Syrup',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontFamily: 'Fontmain'),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 500,
                  width: 500,
                  margin: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Color(0xff040359),
                  ),
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment.topCenter,
                        child: Container(
                          margin: EdgeInsets.only(top: 10),
                          height: 100,
                          width: 200,
                          decoration: BoxDecoration(
                              color: Color(0xff08346D),
                              borderRadius: BorderRadius.circular(20)),
                        ),
                      ),
                      Align(
                        alignment: Alignment.topCenter,
                        child: Container(
                            margin: EdgeInsets.only(top: 10),
                            height: 100,
                            width: 100,
                            child: Image.asset(
                              'assets/images/dashboard_pharmacy_medicine.png',
                            )),
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          margin: EdgeInsets.all(5),
                          child: Stack(
                            children: [
                              Positioned(
                                  // alignment: Alignment.bottomCenter,
                                  bottom: 30,
                                  left: 65,
                                  child: ElevatedButton(
                                    onPressed: () {},
                                    child: Text(
                                      'Details',
                                      style: TextStyle(
                                          color: Color(0xff040359),
                                          fontFamily: 'Fontmain'),
                                    ),
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: Color(0xffFFFFFF),
                                        elevation: 100),
                                  )),
                              Align(
                                alignment: Alignment.bottomCenter,
                                child: Container(
                                  margin: EdgeInsets.only(top: 5),
                                  child: Text(
                                    'XYX Syrup',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontFamily: 'Fontmain'),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 500,
                  width: 500,
                  margin: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Color(0xff040359),
                  ),
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment.topCenter,
                        child: Container(
                          margin: EdgeInsets.only(top: 10),
                          height: 100,
                          width: 200,
                          decoration: BoxDecoration(
                              color: Color(0xff08346D),
                              borderRadius: BorderRadius.circular(20)),
                        ),
                      ),
                      Align(
                        alignment: Alignment.topCenter,
                        child: Container(
                            margin: EdgeInsets.only(top: 10),
                            height: 100,
                            width: 100,
                            child: Image.asset(
                              'assets/images/syrup.png',
                            )),
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          margin: EdgeInsets.all(5),
                          child: Stack(
                            children: [
                              Positioned(
                                  // alignment: Alignment.bottomCenter,
                                  bottom: 30,
                                  left: 65,
                                  child: ElevatedButton(
                                    onPressed: () {},
                                    child: Text(
                                      'Details',
                                      style: TextStyle(
                                          color: Color(0xff040359),
                                          fontFamily: 'Fontmain'),
                                    ),
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: Color(0xffFFFFFF),
                                        elevation: 100),
                                  )),
                              Align(
                                alignment: Alignment.bottomCenter,
                                child: Container(
                                  margin: EdgeInsets.only(top: 5),
                                  child: Text(
                                    'XYX Syrup',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontFamily: 'Fontmain'),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ], //item
              options: CarouselOptions(
                height: 200,
                viewportFraction: 0.6,
                autoPlay: true,
                autoPlayInterval: Duration(seconds: 5),
                autoPlayAnimationDuration: Duration(milliseconds: 1000),
                enlargeCenterPage: true,
                enlargeFactor: 0.5,
              )),
          Container(
              margin: EdgeInsets.only(
                top: 40,
                left: 20,
              ),
              child: Text(
                'Details: ',
                style: size30Black(),
              )),
          Container(
            margin: EdgeInsets.all(10),
            height: 300,
            width: 100,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black87),
              color: Color(0xffFCFF78),
              borderRadius: BorderRadius.circular(25),
            ),
            child: Container(
              margin: EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Medicine Name : ",
                    style: siz20Black(),
                  ),
                  Text(
                    "Duration : ",
                    style: siz20Black(),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Used For: ",
                    style: siz20Black(),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
