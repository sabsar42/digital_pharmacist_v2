import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TypeOfAccount extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Column(   //Whole
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Type of Account", style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 40,
              ),),
              SizedBox(
                height: 10,
              ),
              Text('Choose the type of your account', style: TextStyle(
                fontSize: 15,
                color: Colors.grey,
              ),),
              SizedBox(
                height: 10,
              ),
              Padding(   //first container
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  height: 250,
                  width: double.infinity,
                  child: InkWell(
                    onTap: () {},
                    splashColor: Colors.blue,
                    child: Row(
                      children: [
                        Expanded(
                          flex: 60,
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('I am a patient', style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),),
                              Container(
                                width: 200,
                                child: Text('Find doctors, access medical records and medicine delivery', style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.grey,
                                ),),
                              ),


                            ],
                          ),
                        ),
                        
                        Expanded(
                          flex: 40,
                          child:
                            CircleAvatar(
                                radius: 60,
                                backgroundColor: Colors.grey,
                                child: Image.network("https://cdn-icons-png.flaticon.com/512/1430/1430453.png")),

                        ),

                      ],
                    ),
                  ),
                ),
              ),
              Padding(        //second container
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  //margin: const EdgeInsets.all(5),
                  height: 250,
                  width: double.infinity,
                  child: InkWell(
                    onTap: () {},
                    splashColor: Colors.blue,
                    child: Row(
                      children: [
                        Expanded(
                          flex: 60,
                          child: Column(
                            //mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('I am a doctor', style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),),
                              Container(
                                width: 150,
                                child: Text('The easiest way to reach your patients', style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.grey,
                                ),),
                              ),

                            ],
                          ),
                        ),

                        Expanded(
                        flex: 40,
                          child: 
                            CircleAvatar(
                                radius: 60,
                                backgroundColor: Colors.grey,
                                child: Image.network("https://cdn-icons-png.flaticon.com/512/3774/3774299.png")),

                        ),

                      ],
                    ),
                  ),
                ),
              ),

            ],
      ),
    );
  }

}
//