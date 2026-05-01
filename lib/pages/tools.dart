

import 'package:flutter/material.dart';
import 'package:verademo_dart/utils/constants.dart';
import 'package:verademo_dart/utils/fortune.dart';
import 'package:dart_ping/dart_ping.dart';

class ToolsPage extends StatefulWidget {
  const ToolsPage({super.key, required String username});

  @override
  ToolsPageState createState() => ToolsPageState();
  
}

class ToolsPageState extends State<ToolsPage> {
  TextEditingController pingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          //crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text('Ping:\n', style: Theme.of(context).textTheme.headlineMedium?.copyWith(color: VConstants.codeWhite),),
            ),
            Row(
              children: [
                Expanded(
                  child: TextField(
                  controller: pingController,
                  decoration: InputDecoration(
                    hintStyle: Theme.of(context).textTheme.bodyMedium,
                    hintText: 'Enter Hostname/IP',
                    filled: true,
                    fillColor: VConstants.darkNeutral2,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
                    ),
                  ),
                ),
                const SizedBox(width: 18,),
                ElevatedButton(
                  onPressed: () async {
                    var input = pingController.text;
                    var ping = await Ping(input, count : 1).stream.first;
                    FortuneRiddles.newValue.value = ping.toString();
                  },
                  child: const Text('Ping'),
                ),    
              ],
            ),
            const SizedBox(height: VConstants.textFieldSpacingMed,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  height: 40,
                  width: 240,
                  child: Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () async {
                            var fortune = FortuneFromData();
                            FortuneRiddles.newValue.value = await fortune.next();
                          },
                          child: const Text('Fortune'),  
                        ),  
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () async {
                            var riddles = RiddlesFromData();
                            FortuneRiddles.newValue.value = await riddles.next();
                          },
                          child: const Text('Riddles'),
                          
                        ),
                      ),
                      
                    ],
                  ),
                ), 
              ],
            ),
            const SizedBox(height: VConstants.textFieldSpacingMed * 1.5),
            const FortuneRiddles(),
          /*Expanded(
            child: Container(
              color:  VConstants.darkNeutral2,
          ),
          ),*/
          ],
        ),
      ),
    );

  }
}

class FortuneRiddles extends StatelessWidget{
  static ValueNotifier<String> newValue = ValueNotifier("Ping a server or generate a random fortune/riddle!");

  const FortuneRiddles({super.key});

  @override
  Widget build(BuildContext context) {
  return Container(
    padding: const EdgeInsets.all(15),
    decoration: const BoxDecoration(
          color: VConstants.codeBlack,
          borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
    child: Column(  
      children: [
        ValueListenableBuilder(
          valueListenable: newValue, 
          builder: (BuildContext context, String string, Widget? child) {
            return Text(
              string,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: VConstants.codeWhite)
              // style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            );
          }, 
        ),
      ]
    ),
  );
  }
  
}



