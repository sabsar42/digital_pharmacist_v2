import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import '../Registration/TypeOfAccount.dart';


class OnBoard extends StatelessWidget {
  List<PageViewModel>getPages(){
    return [
      PageViewModel(

        image:Image.asset('assets/images/health_records.png'),
        title: "Get medical Consultation",
        body: "Store Health Records",
          decoration: PageDecoration(
          )

      ),
      PageViewModel(
        image:Image.asset('assets/images/onboard_3.png'),
        title: "Medicine Reminders",
        body: "Stay on top of your health effortlessly with our Medication Reminders",

      ),
      PageViewModel(
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
            animationDuration: 300,
            autoScrollDuration: 500,
            infiniteAutoScroll: false,
            isProgress: true,
            showSkipButton: true,
            showNextButton: false,
            skip: const Text("Skip",
            style: TextStyle(
              color: Color.fromRGBO(110, 10, 161, 1.0),
            ),),

            doneStyle: ElevatedButton.styleFrom(backgroundColor: Color.fromRGBO(
                12, 57, 93, 1.0), elevation: 10),
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