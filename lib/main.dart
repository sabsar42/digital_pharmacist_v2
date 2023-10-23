import 'package:flutter/material.dart';

import 'OnBoard.dart';


void main(){
  runApp(MyApp());

}
class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Medicine App",
      home: OnBoard(),
    );
  }

}
//