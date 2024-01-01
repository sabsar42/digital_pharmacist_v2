import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'GenderType.dart';
import 'BloodGroup.dart';

class GenderType extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     appBar: AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: IconButton(
        onPressed: () { Navigator.pop(context); }, icon: Icon(Icons.arrow_back), color: Colors.blue,
      ),
    ),
      body:Column(    //Whole
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("What is your Gender?", style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 30,
          ),),

          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(50, 8, 50, 8),
            child: Text('To give you a better experience we need to know your gender', style: TextStyle(
              fontSize: 15,
              color: Colors.grey,
            ),),
          ),
          SizedBox(
            height: 10,
          ),
          
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              InkWell(
                onTap: (){},
                child: Container(
                  height: 300,
                  width: 150,
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.black12,
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                            "Male",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Image.network('https://cdn-icons-png.flaticon.com/512/2219/2219885.png')
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: (){},
                child: Container(
                  height: 300,
                  width: 150,
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.black12,
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Female",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Image.network('https://cdn-icons-png.flaticon.com/512/4086/4086577.png')
                    ],
                  ),
                ),
              ),

            ]
            
          ),
          SizedBox(
            height: 100,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) {
                    return BloodGroup();
                  }),
                );
              },
              child: Text('Continue'),
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  elevation: 10.0,
                backgroundColor: Color.fromRGBO(19, 68, 130, 1.0),
                fixedSize: Size(350.0, 60.0)
              ),
            ),
          ),

        ],
      ),
    );
  }

}
//