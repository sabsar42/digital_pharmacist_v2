import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import '../Registration/TypeOfAccount.dart';


class OnBoard extends StatelessWidget {
  List<PageViewModel>getPages(){
    return [
      PageViewModel(
       // image: Image.network('https://cdn-icons-png.flaticon.com/512/7310/7310705.png'),
        image:Image.asset('assets/images/onboard_1.png'),
        title: "Get medical Consultation",
        body: "Commmunicate with the finest doctors in your area",
          decoration: PageDecoration(

          )

      ),
      PageViewModel(
        // image: Image.network('https://cdn-icons-png.flaticon.com/512/1546/1546140.png'),
        image:Image.asset('assets/images/onboard_3.png'),
        title: "Medication Reminders",
        body: "Stay on top of your health effortlessly with our Medication Reminders",

      ),
      PageViewModel(
       // image: Image.network('https://cdn-icons-png.flaticon.com/512/4003/4003759.png'),
        image:Image.asset('assets/images/onboard_2.png'),
        title: "Keep EHR files",
        body: "Store all of your EHR files in one place",

      )
    ];
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          margin: EdgeInsets.fromLTRB(0, 150, 0, 5),
          padding: EdgeInsets.fromLTRB(0, 60, 0, 5),
          child: IntroductionScreen(
      pages: getPages(),
      done: const Text(
          "Get Started",
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w400,
            color: Colors.white,
          ),
      ),
            animationDuration: 900,
            autoScrollDuration: 1000,
            infiniteAutoScroll: true,
            isProgress: true,
            showSkipButton: true,
            showNextButton: false,
            skip: const Text("Skip"),

            doneStyle: ElevatedButton.styleFrom(backgroundColor: Colors.lightBlue, elevation: 10),
            onDone: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => TypeOfAccount(),
                ),
              );
            },
    ),
        ));
  }
}
//