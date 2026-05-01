import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:verademo_dart/controllers/blab_controller.dart';
import 'package:verademo_dart/pages/blab.dart';
import 'package:verademo_dart/utils/constants.dart';
import 'package:verademo_dart/utils/shared_prefs.dart';
import 'package:verademo_dart/widgets/profile_image.dart';

// enum type for switching between containers on same page
enum WidgetState {
  // ignore: constant_identifier_names
  Feed, MyBlabs
}

class FeedRadio extends StatefulWidget {
  FeedRadio({super.key});
  final controller = TextEditingController();

  @override
  State<FeedRadio> createState() => _FeedRadioState();
}

class _FeedRadioState extends State<FeedRadio> {
  WidgetState currentWidget = WidgetState.Feed;
  int currentSelect = 0;
  late Future<List<Widget>> _data;

  @override
  initState()
  {
    super.initState();
    _data = getFeedData();
  }

  void update() async {
    setState(() {
      if (currentWidget == WidgetState.Feed) {
        _data = getFeedData();
      } else {
        _data = getBlabData();
      }
    });
  }

  Future<List<Widget>> getFeedData() async {
    print("Building API call to /posts/getBlabsForMe/");
    final url = "${VConstants.apiUrl}/posts/getBlabsForMe";
    final uri = Uri.parse(url);
    final Map<String, String> headers = {
      "content-type": "application/json",
      "Authorization": "${VSharedPrefs().token}"
    };
    await Future.delayed(const Duration(seconds: 2));
    
    final response = await http.get(uri, headers: headers);
     // Convert output to JSON
    final data = jsonDecode(response.body)["data"] as List;

    List<Widget> items = [];
    for (int i=0; i<data.length; i++)
    {
      items.add(buildFeedItem(data[i]));
    }
    return items;
  }

  Future<List<Widget>> getBlabData() async {
    print("Building API call to /posts/getBlabsByMe/");
    final url = "${VConstants.apiUrl}/posts/getBlabsByMe";
    final uri = Uri.parse(url);
    final Map<String, String> headers = {
      "content-type": "application/json",
      "Authorization": "${VSharedPrefs().token}"
    };
    await Future.delayed(const Duration(seconds: 2));
    
    final response = await http.get(uri, headers: headers);
     // Convert output to JSON
    final data = jsonDecode(response.body)["data"] as List;

    List<Widget> items = [];
    for (int i=0; i<data.length; i++)
    {
      items.add(buildFeedItem(data[i]));
    }
    return items;
  }

  @override
  Widget build(BuildContext context) {
    return Column( 
        children: [
          BlabBar(context,),
          const SizedBox(height: 16),
          RadioHead(),
          const SizedBox(height: 10.0,),
          // Feed view
          Expanded(child: Feed()),
          ],);
    
  }

  // ignore: non_constant_identifier_names
  Widget Feed(){
    return ListView(
      scrollDirection: Axis.vertical,
      children: [
        FutureBuilder<List<Widget>>(
          future: _data,
          builder: (context, snapshot) {
            switch (snapshot.connectionState){
              case ConnectionState.waiting:
                return const Center(
                child: CircularProgressIndicator(
                  color: VConstants.veracodeBlue,));
              case ConnectionState.done:
              default:
                if (snapshot.hasError){
                  return Text('Error: ${snapshot.error}');
                } else if (snapshot.hasData) {
                  List<Widget> data = snapshot.data as List<Widget>;
                  return Column(children: data,);
                } else {
                  return const Text('No results received.');
                }
            }
          },
                ),
      ],);
  }

  Row BlabBar(BuildContext context) {
    return Row(
            children: [
              Expanded(
                child: TextField(
                  controller: widget.controller,
                  decoration: InputDecoration(
                    hintStyle: Theme.of(context).textTheme.bodyMedium,
                    hintText: 'Blab something now...',
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
              const SizedBox(width: 8,),
              ElevatedButton(
                onPressed: () { 
                  setState(() {
                    BlabController.addBlab(widget.controller.text,context);
                    _data = getBlabData();

              }); },
                child: const Text('Add'),
              ),
            ],
          );
  }

  // ignore: non_constant_identifier_names
  Widget RadioHead() {
    return SizedBox(
            height: 40,
            width: 240,
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        currentWidget = WidgetState.Feed;
                        currentSelect = 0;
                        _data = getFeedData();
                      });
                    },
                    style: ElevatedButton.styleFrom(backgroundColor: (currentSelect==0) ? VConstants.veracodeBlue : VConstants.veracodeBlack),
                    child: const Text('Feed'),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        currentWidget = WidgetState.MyBlabs;
                        currentSelect = 1;
                        _data = getBlabData();
                      }
                      );
                    },
                    style: ElevatedButton.styleFrom(backgroundColor: (currentSelect==1) ? VConstants.veracodeBlue : VConstants.veracodeBlack),
                    child: const Text('My Blabs'),
                    
                  ),
                  
                ), 
                const SizedBox(width: 16),
                
              ],
            ),
          );
  }

  Widget buildFeedItem(Map data) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5.0),
      child: FeedItem(data),
    );
  }

  // ignore: non_constant_identifier_names
  Container FeedItem(Map data) {
    if (data['username'] == null)
    {
      data['username'] = VSharedPrefs().username;
      data['blab_name'] = "Me";
    }
    return Container(
      decoration: BoxDecoration(
          color: VConstants.darkNeutral2,
          borderRadius: BorderRadius.circular(10),
        ),
      width: double.infinity,
      child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                  VAvatar(data['username'], radius:30),
                  const SizedBox(width: 10,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(data['blab_name'],
                        style: Theme.of(context).textTheme.headlineMedium, ),
                      Text(getTimestampString(data['timestamp']), 
                        style: Theme.of(context).textTheme.labelSmall),
                    ],
                  ),
                  Expanded(child: Container()),
                  IconButton(
                    onPressed: () {
                      Navigator.push(context,
                        MaterialPageRoute(builder: (context) => BlabPage(blabInfo: data)),);
                    },
                    icon: const Icon(
                      Icons.comment,
                      color: VConstants.veracodeWhite,
                    ),)
                          
                  ],),
                const SizedBox(height: 10,),
                Text(data['content'], overflow: TextOverflow.ellipsis,),
                
          ]),
        ),);
    }
}

getTimestampString(timestamp) {
  return VConstants.dateFormat.format(DateTime.parse(timestamp));
}


