import 'package:flutter/material.dart';
import 'package:verademo_dart/utils/constants.dart';


class MyBlabs extends StatefulWidget {
  const MyBlabs({super.key});

  @override
  State<MyBlabs> createState() => MyBlabsState();
}

class MyBlabsState extends State<MyBlabs> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: VConstants.darkNeutral2,
        borderRadius: BorderRadius.circular(10), 
      ),
      margin: const EdgeInsets.only(top: 25, left:25, right: 25),
      padding: const EdgeInsets.all(15)
    );
  }

  
}