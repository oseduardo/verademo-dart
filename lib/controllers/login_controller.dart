import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:verademo_dart/controllers/internal_controller.dart';
import 'package:verademo_dart/utils/constants.dart';
import 'package:verademo_dart/utils/shared_prefs.dart';
import 'package:verademo_dart/utils/snackbar.dart';

class LoginController {
  final username = TextEditingController();
  final password = TextEditingController();
  final api = TextEditingController();

  bool rememberMe = false;
  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();

  void processLogin(BuildContext context) async {
    try {
      // Validate Form
      if (!loginFormKey.currentState!.validate()) {
        return;
      }

      // Build API call for login
      print("Building API call to /users/login/");
      final url = "${VConstants.apiUrl}/users/login/";
      final uri = Uri.parse(url);
      final body = jsonEncode(<String, String> {
        "username": username.text,
        "password": password.text
      });
      final Map<String, String> headers = {
        "content-type": "application/json",
        "Authorization": "Token: ${username.text}_${md5.convert(utf8.encode(password.text)).toString()}"
      };

      // Execute API call for login
      final response = await http.post(uri, body: body, headers: headers);

      if (response.statusCode == 200) {
        // Login successful
        print(response.body);

        // Make sure context exists
        if (!context.mounted) return;

        // Save login information with remember me
        if (rememberMe) {
          VSharedPrefs().rememberedUsername = username.text;
          VSharedPrefs().rememberedPassword = password.text;
        }

        // Set session username
        VSharedPrefs().username = username.text;
        VSharedPrefs().token = "Token: ${username.text}_${md5.convert(utf8.encode(password.text)).toString()}";

        // Use pushReplacement to prevent back button from going back to login page once logged in
        Navigator.pushReplacement(context,
                       MaterialPageRoute(builder: (context) => HomePage(username: username.text)),);
      } else if (response.statusCode == 403) {
        // Login credentials incorrect
        final data = json.decode(response.body)["data"];
        print(data);
        if (!context.mounted) return;
        
        ScaffoldMessenger.of(context).showSnackBar(VSnackBar.errorSnackBar("Username or password incorrect."));
      } else {
         // Login failed
        final data = json.decode(response.body)["data"];
        print(data);
        if (!context.mounted) return;
        
        ScaffoldMessenger.of(context).showSnackBar(VSnackBar.errorSnackBar(data));
 
      }
    } catch (err) {
      print(err);
      //if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(VSnackBar.errorSnackBar("Couldn't make API connection"));
    }
  }

  void processAPI(BuildContext context) async {

    RegExp exp = RegExp(r'^((localhost)+|(127.0.0.1))+');
    String str = api.text;
    bool match = exp.hasMatch(str);
    print(match);
    if (match)
    {
      
      VConstants.apiUrl = "http://10.0.2.2:${str.split(':').last}";
    }
    else{
      VConstants.apiUrl = api.text;
    }
    print(VConstants.apiUrl);

    // Build API call for login
    print("Building API call to ${VConstants.apiUrl}/");
    final url = VConstants.apiUrl;
    final uri = Uri.parse(url);
    try{
      // Execute API call for login
      final response = await http.get(uri);

      if (!context.mounted) return;

      if(response.statusCode==200)
      {
        // Make sure context exists
        ScaffoldMessenger.of(context).showSnackBar(VSnackBar.successSnackBar("Database Found"));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(VSnackBar.errorSnackBar("Database found with unexpected error"));
      }
    } catch(e) {
      ScaffoldMessenger.of(context).showSnackBar(VSnackBar.errorSnackBar("Couldn't make API connection"));
    }
  }
}
