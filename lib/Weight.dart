import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Weight extends StatefulWidget {
  const Weight({super.key});

  @override
  State<Weight> createState() => _WeightState();
}

class _WeightState extends State<Weight> {
  double _currentSliderValue = 20;

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
      body: Column(
        //Whole
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "What is your weight?",
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
            child: Text('Let us know your weight', style: TextStyle(
              fontSize: 15,
              color: Colors.grey,
            ),),
          ),
          SizedBox(
            height: 10,
          ),

          Slider(
            value: _currentSliderValue,
            max: 200,
            divisions: 200,
            label: _currentSliderValue.round().toString(),
            onChanged: (double value) {
              setState(() {
                _currentSliderValue = value;
              });
            },
          ),
          SizedBox(
            height: 100,
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: ElevatedButton(
              onPressed: () {
              },
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

        ],
      ),

    );
  }
}

