

import 'package:popover/popover.dart';
import 'EHR_Detailed_View.dart';
import 'Health_Record_Screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'EHR_First_Screen.dart';
import 'Health_Record_Screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:digi_pharma_app_test/medical_history/Health_Record_Detailed.dart';
import 'package:flutter/material.dart';

import 'package:digi_pharma_app_test/medical_history/Health_Record_Detailed.dart';
import 'package:flutter/material.dart';
import 'PopBup_Menu_Three_Button_Functions_Screen.dart';

class PopUpMenuThreeButton extends StatelessWidget {
  const PopUpMenuThreeButton({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap:() =>
      showPopover(
        context: context,
        bodyBuilder: (context) => PopUpMenuItems(),

        height: 130,
        width: 120,
        arrowHeight: 5,
        direction: PopoverDirection.bottom,
      ),
      //enableFeedback: true,
      child: Icon(Icons.more_vert_rounded),
    );
  }
}

class PopUpMenuItems extends StatelessWidget {
  const PopUpMenuItems({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          height: 43,
          color: Colors.deepPurple[300],
          child: Align(
            alignment: Alignment.center,
            child: Container(
             // padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text("Edit",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),),
            ),
          ),
        ),
        SizedBox(height: 0.5),
        Container(
          height: 43,
          color: Colors.deepPurple[200],
          child: Align(
            alignment: Alignment.center,
            child: Container(
            //  padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text("View",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),),
            ),
          ),
        ),
        SizedBox(height: 0.3),
        Container(
          height: 43,
          color: Colors.deepPurple[200],
          child: Align(
            alignment: Alignment.center,
            child: Container(
             // padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text("Info",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),),
            ),
          ),
        ),
      ],
    );
  }
}