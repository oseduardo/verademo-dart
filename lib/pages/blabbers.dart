import 'package:flutter/material.dart';
import 'package:verademo_dart/utils/constants.dart';
import 'package:verademo_dart/utils/shared_prefs.dart';
import 'package:verademo_dart/widgets/blabber_list.dart';

class BlabbersPage extends StatefulWidget {
  final String username;

  const BlabbersPage({super.key, required this.username});

  @override
  State<BlabbersPage> createState() => _BlabbersPageState();
}

class _BlabbersPageState extends State<BlabbersPage> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: VConstants.darkNeutral1,
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: 44,
                width: 151,
                child: Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                    color: VConstants.darkNeutral2,),
                  alignment: Alignment.center,
                  child: Text('Blabber',
                    style: Theme.of(context).textTheme.headlineMedium ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: 44,
                width: 86,
                child: Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                    color: VConstants.darkNeutral2,),
                  alignment: Alignment.center,
                  child: Text('Listening',
                  style: Theme.of(context).textTheme.headlineMedium),
                ),
              ),
            )
          ],),
          Expanded(
            child: Container(
              child: BlabberList("${VSharedPrefs().token}")
              
              /*const Center(
                child: Text(
                  'No Blabs yet...',
                  style: TextStyle(color: VConstants.codeWhite),
                ),
              ),*/
            ),
          ),
        ],
      ),
        );
  }
}