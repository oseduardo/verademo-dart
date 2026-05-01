import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:verademo_dart/pages/login.dart';
import 'package:verademo_dart/utils/constants.dart';
import 'package:verademo_dart/utils/shared_prefs.dart';
import 'package:verademo_dart/utils/snackbar.dart';

class ResetController{
  
  void processReset(BuildContext context) async
  {
    // Build API call for login
    print("Building API call to /users/reset/");
    final url = "${VConstants.apiUrl}/users/reset/";
    final uri = Uri.parse(url);
    final Map<String, String> headers = {
      "content-type": "application/json",
      "Authorization": "${VSharedPrefs().token}"
    };

    try{
      // Execute API call for login
      final response = await http.get(uri, headers: headers);

      if (!context.mounted) return;

      if(response.statusCode==200)
      {
        // Make sure context exists
        VSharedPrefs().clear();
        Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => const LoginPage()),);
        ScaffoldMessenger.of(context).showSnackBar(VSnackBar.successSnackBar("Database Reset Successful"));
      } else {
        Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => const LoginPage()),);
        ScaffoldMessenger.of(context).showSnackBar(VSnackBar.errorSnackBar("Database Reset Failed"));
      }
    } catch(e) {
      print(e);
      Navigator.pushReplacement(context,
                       MaterialPageRoute(builder: (context) => const LoginPage()),);
      ScaffoldMessenger.of(context).showSnackBar(VSnackBar.errorSnackBar("Couldn't make API connection"));
    }
    
  }
}