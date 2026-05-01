import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:verademo_dart/utils/constants.dart';
import 'package:verademo_dart/utils/shared_prefs.dart';
import 'package:verademo_dart/widgets/profile_image.dart';
import 'package:verademo_dart/widgets/stateful_checkbox.dart';

class BlabberList extends StatefulWidget
{
  final String username;

  const BlabberList(this.username,{super.key});

  @override
  State<BlabberList> createState() => _BlabberListState();
}

class _BlabberListState extends State<BlabberList> {
  late Future<List<Widget>> _data;

  @override
  initState()
  {
    super.initState();
    _data = getData();
  }
  
  Future<List<Widget>> getData() async {
    print("Building API call to /users/getBlabbers/");
    final url = "${VConstants.apiUrl}/users/getBlabbers/";
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
      items.add(buildListItem(data[i]));
    }
    return items;
  }
  @override
  Widget build(BuildContext context) {

    return FutureBuilder<List<Widget>>(
        future: _data,
        builder: (context, snapshot) {
          if (snapshot.hasError)
          {
            final error = snapshot.error;

            return Text('Error: $error');
          } else if (snapshot.hasData) {
            List<Widget> data = snapshot.data as List<Widget>;
            return  ListTileTheme(
              textColor: VConstants.veracodeWhite,
              child: ListView(
                children: ListTile.divideTiles(
                  context: context,
                  color: VConstants.lightNeutral3,
                  tiles: data).toList()
      ),
    );
          }
          else {
            return const Center(
              child: CircularProgressIndicator(
                color: VConstants.veracodeBlue,));
          }
        },
      );

  }

  Widget buildListItem(Map user) {
    String name = user['username'].toLowerCase();
    bool listener = user['listeners']==1 ? true : false;
    return ListTile(
      leading: VAvatar(name, radius: 20),
      title: Text(name),
      trailing: VCheckbox(
        value: listener,
        onChanged: (value) => { 
          if (value)
          {
            listen(name)
          } else {
            ignore(name)
          }
        },
      ),
    );
  }

  void ignore(String blabberUser)
  async {
    print("Building API call to /users/ignore/");
    final url = "${VConstants.apiUrl}/users/ignore/";
    final uri = Uri.parse(url);
    final Map<String, String> headers = {
      "content-type": "application/json",
      "Authorization": "${VSharedPrefs().token}"
    };
    final body = jsonEncode(<String, String> {
        "blabberUsername": blabberUser
      });
    final response = await http.post(uri, headers: headers, body: body);

    if (response.statusCode == 200) {
        // Register successful
        print(response.body);
    } else {
        // Register failed
        final data = json.decode(response.body)["data"];
        print(data);
    }
  }

  void listen(String blabberUser)
  async {
    print("Building API call to /users/listen/");
    final url = "${VConstants.apiUrl}/users/listen/";
    final uri = Uri.parse(url);
    final Map<String, String> headers = {
      "content-type": "application/json",
      "Authorization": "${VSharedPrefs().token}"
    };
    final body = jsonEncode(<String, String> {
        "blabberUsername": blabberUser
      });
    final response = await http.post(uri, headers: headers, body: body);

    if (response.statusCode == 200) {
        // Register successful
        print(response.body);
    } else {
        // Register failed
        final data = json.decode(response.body)["data"];
        print(data);
    }
  }
}