import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:verademo_dart/controllers/internal_controller.dart';
import 'package:verademo_dart/pages/register-finish.dart';
import 'package:verademo_dart/utils/constants.dart';
import 'package:verademo_dart/utils/shared_prefs.dart';
import 'package:verademo_dart/utils/snackbar.dart';

class RegisterController {
  final username = TextEditingController();
  final password = TextEditingController();
  final cpassword = TextEditingController();
  final realName = TextEditingController();
  final blabName = TextEditingController();
  String? errorMessage;

  GlobalKey<FormState> registerFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> registerFinishFormKey = GlobalKey<FormState>();

  // Future<String?> _validateUsernameAvailable() async {
  //   try {
  //     print("Username is: ${username.text}");
  //     if (username.text.isEmpty) {
  //       return "Username is required.";
  //     }

  //     // Build API call for getUsers
  //     print("Building API call to /users/getUsers/");
  //     const url = "${VConstants.apiUrl}/users/getUsers/";
  //     final uri = Uri.parse(url);
  //     final Map<String, String> headers = {
  //       "content-type": "application/json",
  //       "Authorization": "Token: 21232F297A57A5A743894A0E4A801FC3"
  //     };

  //     // Execute API call for getUsers
  //     final response = await http.get(uri, headers: headers);

  //     if (response.statusCode == 200) {
  //       // getUsers successful
  //       print(response.body);

  //       // Convert output to JSON
  //       final data = jsonDecode(response.body)["data"];
  //       print(data);

  //       // Check if username already exists
  //       bool exists = data.where((user) => user['username'] == username.text).isNotEmpty;

  //       if (exists) {
  //         print("${username.text} is available.");
  //         return null;
  //       } else {
  //         return "${username.text} is taken";
  //       }

  //     } else {
  //       // Login failed
  //       return "API Call Failed";
  //     }
  //   } catch (err) {
  //     return err.toString();
  //   }
  // }

  void processRegister(BuildContext context) async {
    try {
      // Validate form
      if (!registerFormKey.currentState!.validate()) {
        return;
      }

      // Build API call for getUsers
      print("Building API call to /users/getUsers/");
      final url = "${VConstants.apiUrl}/users/getUsers/";
      final uri = Uri.parse(url);
      final Map<String, String> headers = {
        "content-type": "application/json",
        "Authorization": "Token: admin_21232F297A57A5A743894A0E4A801FC3"
      };

      // Execute API call for getUsers
      final response = await http.get(uri, headers: headers);

      if (response.statusCode == 200) {
        // getUsers successful
        print(response.body);

        // Convert output to JSON
        final data = jsonDecode(response.body)["data"];
        print(data);

        // Check if username already exists
        bool exists = data.where((user) => user['username'] == username.text).isNotEmpty;
        print(exists);

        if (!exists) {
          print("Username '${username.text}' is available.");
        } else {
          errorMessage = "Username '${username.text}' is taken";
          registerFormKey.currentState!.validate();
          return;
        }

        // Make sure context exists
        if (!context.mounted) return;

        Navigator.push(context,
                      MaterialPageRoute(builder: (context) => RegisterFinishPage(controller: this)),);
      } else {
        final data = json.decode(response.body)["data"];
        print(data);
        if (!context.mounted) return;
        
        ScaffoldMessenger.of(context).showSnackBar(VSnackBar.errorSnackBar(data));
      }

    } catch (err) {
      print(err);
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(VSnackBar.errorSnackBar(err));
    }
  }

  void processRegisterFinish(BuildContext context) async {
    try {
      // Validate form
      if (!registerFinishFormKey.currentState!.validate()) {
        return;
      }

      // Build API call for register
      print("Building API call to /users/register/");
      final url = "${VConstants.apiUrl}/users/register/";
      final uri = Uri.parse(url);
      final body = jsonEncode(<String, String> {
        "username": username.text,
        "password": password.text,
        "cpassword": cpassword.text,
        "realName": realName.text,
        "blabName": blabName.text,
      });
      final Map<String, String> headers = {
        "content-type": "application/json",
      };
      print(body);

      // Execute API call for register
      final response = await http.post(uri, body: body, headers: headers);

      if (response.statusCode == 200) {
        // Register successful
        print(response.body);

        // Make sure context exists
        if (!context.mounted) return;

        // Set session username
        VSharedPrefs().username = username.text;
        VSharedPrefs().token = "Token: ${username.text}_${md5.convert(utf8.encode(password.text)).toString()}";

        // Use pushReplacement to prevent back button from going back to register page after registering
        Navigator.pushReplacement(context,
                       MaterialPageRoute(builder: (context) => HomePage(username: username.text)),);
      } else {
        // Register failed
        final data = json.decode(response.body)["data"];
        print(data);
        if (!context.mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(VSnackBar.errorSnackBar(data));
      }
    } catch (err) {
      print(err);
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(VSnackBar.errorSnackBar(err));
    }
  }
}
