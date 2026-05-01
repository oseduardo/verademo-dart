import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:verademo_dart/utils/constants.dart';
import 'package:verademo_dart/utils/shared_prefs.dart';
import 'package:verademo_dart/utils/snackbar.dart';

class BlabController {
  final blabPost = TextEditingController();
  final commentPost = TextEditingController();

  static void addBlab(String text, BuildContext context) async {
    try {
      print("Building API call to /posts/addBlab/");
      final url = "${VConstants.apiUrl}/posts/addBlab/";
      final uri = Uri.parse(url);
      final body = jsonEncode(<String, String> {
        "blab": text
      });
      final Map<String, String> headers = {
        "content-type": "application/json",
        "Authorization": VSharedPrefs().token ?? "",
      };

      // Execute API call for addBlab/
      final response = await http.post(uri, headers: headers, body: body);
      print("Executed API call to addBlab");

      if (response.statusCode == 200) {
        print(response.body);

        // TODO: Update My Blabs
      } else {
        ScaffoldMessenger.of(context).showSnackBar(VSnackBar.errorSnackBar("Post failed."));
      }
    } catch (err) {
      print(err);
      ScaffoldMessenger.of(context).showSnackBar(VSnackBar.errorSnackBar("Post failed."));
    }
  }

  static void addBlabComment(int blabId, String comment, BuildContext context) async {
    try {
      print("Building API call to /posts/addBlabComment/");
      final url = "${VConstants.apiUrl}/posts/addBlabComment/";
      final uri = Uri.parse(url);
      final body = jsonEncode(<String, dynamic> {
        "blabId": blabId,
        "comment": comment
      });
      final Map<String, String> headers = {
        "content-type": "application/json",
        "Authorization": VSharedPrefs().token ?? "",
      };

      // Execute API call for addBlabComment/
      final response = await http.post(uri, headers: headers, body: body);
      print("Executed API call to addBlabComment");

      if (response.statusCode == 200) {
        print(response.body);

        // TODO: Update My Blabs and Feed
      } else {
        if (!context.mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(VSnackBar.errorSnackBar("Post failed."));
      }
    } catch (err) {
      print(err);
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(VSnackBar.errorSnackBar("Post failed."));
    }
  }

  

}
