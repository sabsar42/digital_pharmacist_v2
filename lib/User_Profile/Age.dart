import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'Weight.dart';

class Age extends StatefulWidget {
  const Age({super.key});

  @override
  State<Age> createState() => _AgeState();
}

class _AgeState extends State<Age> {
  double _currentSliderValue = 20;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back),
          color: Colors.blue,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          //Whole
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "How old are you?",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 30,
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(50, 8, 50, 8),
              child: Text(
                'Let us know your age',
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.grey,
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            CarouselSlider(
              options: CarouselOptions(
                height: 50,
                aspectRatio: 1 / 1,
                viewportFraction: 0.2,
                initialPage: 0,
                enableInfiniteScroll: true,
                reverse: false,
                autoPlay: false,
                //autoPlayInterval: Duration(seconds: 3),
                //autoPlayAnimationDuration: Duration(milliseconds: 800),
                autoPlayCurve: Curves.fastOutSlowIn,
                enlargeCenterPage: true,
                enlargeFactor: 0.2,
                //onPageChanged: callbackFunction,
                scrollDirection: Axis.horizontal,
              ),
              items: [for (var i = 1; i <= 100; i++) i].map((i) {
                return Builder(
                  builder: (BuildContext context) {
                    return Container(
                        width: MediaQuery.of(context).size.width,
                        margin: EdgeInsets.symmetric(horizontal: 5.0),
                        //height: 50,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black)),
                        child: Center(
                            child: Text(
                          '$i',
                          style: TextStyle(
                              fontSize: 25, fontWeight: FontWeight.bold),
                        )));
                  },
                );
              }).toList(),
            ),
            SizedBox(
              height: 10,
            ),
            SvgPicture.asset("assets/images/triangle.svg"),
            // Slider(
            //   value: _currentSliderValue,
            //   max: 100,
            //   divisions: 100,
            //   label: _currentSliderValue.round().toString(),
            //   onChanged: (double value) {
            //     setState(() {
            //       _currentSliderValue = value;
            //     });
            //   },
            // ),
            SizedBox(
              height: 100,
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) {
                      return Weight();
                    }),
                  );
                }, //
                child: Text('Continue'),
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    elevation: 10.0,
                    backgroundColor: Color.fromRGBO(19, 68, 130, 1.0),
                    fixedSize: Size(350.0, 60.0)),
              ),
            ),
//
          ],
        ),
      ),
    );
  }
}

//

/*
*/

/*
Scaffold(
    );
 */
