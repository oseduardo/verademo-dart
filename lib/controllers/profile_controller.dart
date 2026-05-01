import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:verademo_dart/utils/constants.dart';
import 'package:verademo_dart/utils/shared_prefs.dart';

class ProfileController {
  final realName = TextEditingController();
  final blabName = TextEditingController();
  final username = TextEditingController();
  List hecklers = [];
  List events = [];
  GlobalKey<FormState> profileFormKey = GlobalKey<FormState>();

  void setVariablesFromUsername(String username) async {
    try {
      // Build API call for getProfileInfo
      print("Building API call to /users/getProfileInfo/");
      final url = "${VConstants.apiUrl}/users/getProfileInfo/";
      final uri = Uri.parse(url);
      final Map<String, String> headers = {
        "Authorization": VSharedPrefs().token ?? "",
      };

      // Execute API call for getProfileInfo
      final response = await http.get(uri, headers: headers);

      if (response.statusCode == 200) {
        // Query successful

        // Set variables
        final data = jsonDecode(response.body)["data"];
        realName.text = data["realName"];
        blabName.text = data["blabName"];
        this.username.text = data["username"];
        events = data['events'];
        hecklers = data['hecklers'];

      }
    } catch (err) {
      print(err);
    }
  }

  // TODO (parts of processProfile that can't be handled by API)
  // - update profile image name / path
  // - change session token and username (done)
  // - change remembered username (done)
  void processProfile() async {
    try {
      final oldUsername = VSharedPrefs().username;
      print("Old username: $oldUsername");

      print("Building API call to /users/updateProfile/");
      final url = "${VConstants.apiUrl}/users/updateProfile/";
      final uri = Uri.parse(url);
      final body = jsonEncode(<String, String> {
        "username": username.text,
        "realName": realName.text,
        "blabName": blabName.text,
      });
      final Map<String, String> headers = {
        "content-type": "application/json",
        "Authorization": VSharedPrefs().token ?? "",
      };

      // Execute API call for updateProfile/
      final response = await http.post(uri, headers: headers, body: body);
      print("Executed API call to updateProfile");

      if (response.statusCode == 200) {
        // Query successful

        // Set variables
        final data = jsonDecode(response.body)["data"];
        realName.text = data["realName"];
        blabName.text = data["blabName"];
        username.text = data["username"];
        
        print("Old username: $oldUsername, New username: ${data["username"]}");
        if (oldUsername != data["username"]) {
          VSharedPrefs().username = data["username"];
          VSharedPrefs().token = "Token: ${data["username"]}_${VSharedPrefs().token!.split("_")[1]}";
          print("New token: ${VSharedPrefs().token}");

          if (VSharedPrefs().rememberedUsername != null) {
            VSharedPrefs().rememberedUsername = data["username"];
          }

          print("Changing profile picture");
          final documentsDir = await getApplicationDocumentsDirectory();
          final File oldFile = File("${documentsDir.path}/$oldUsername.png");
          if (oldFile.existsSync()) {
            print("File exists in documents directory, renaming");
            final File newFile = File("${documentsDir.path}/${data["username"]}.png");
            if (!newFile.existsSync()) {
              newFile.create(recursive: true);
            }
            await oldFile.rename("${documentsDir.path}/${data["username"]}.png", );
            
          } else {
            try {
              print("File exists in assets, creating file in documents directory");
              final ByteData image = await rootBundle.load('assets/images/$oldUsername.png');
              final File newFile = File("${documentsDir.path}/${data["username"]}.png");
              if (!newFile.existsSync()) {
                newFile.create(recursive: true);
              }
              newFile.writeAsBytesSync(image.buffer.asUint8List(image.offsetInBytes, image.lengthInBytes));

            } catch (err) {
              print("No file found. User is using default profile image.");
            }
          }
        }
      } else {
        final data = json.decode(response.body)["data"];
        print(data);
      }
    } catch (err) {
      print(err);
    }
  }

  updateEvents(String username, callback) async {
    try {
      // Build API call for getProfileInfo
      print("Building API call to /users/getEvents/");
      final url = "${VConstants.apiUrl}/users/getEvents/";
      final uri = Uri.parse(url);
      final Map<String, String> headers = {
        "Authorization": VSharedPrefs().token ?? "",
      };

      // Execute API call for getProfileInfo
      final response = await http.get(uri, headers: headers);

      if (response.statusCode == 200) {
        // Query successful
        print(response.body);

        // Set variables
        final data = jsonDecode(response.body)["data"];
        events = data;
        return callback(events);
      }
      else{
        return callback(["Bad Response"]);
      }
    } catch (err) {
      return callback(["error occurred"]);
    }


  }

}
