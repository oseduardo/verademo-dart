import 'package:flutter/material.dart';
import 'package:verademo_dart/controllers/internal_controller.dart';
import 'package:verademo_dart/pages/login.dart';
import 'package:verademo_dart/utils/constants.dart';
import 'package:verademo_dart/utils/shared_prefs.dart';

class LogoutPage extends StatefulWidget {
  final String username;

  const LogoutPage({super.key, required this.username});

  @override
  State<LogoutPage> createState() => _LogoutPageState();
}

class _LogoutPageState extends State<LogoutPage> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 32,
          vertical: 16,
        ),
        decoration: BoxDecoration(
          color : VConstants.veracodeBlack,
          borderRadius: BorderRadius.circular(10),
        ),
        child : Column(
          mainAxisSize: MainAxisSize.min,
          children: [
              // ignore: prefer_const_constructors
              Text('Are You Sure?\n',
              textAlign: TextAlign.center,
              // ignore: prefer_const_constructors
              style: TextStyle(
                color: VConstants.veracodeWhite,
                fontSize: 24,
                fontWeight: FontWeight.bold, 
              ),
              ),
              // spacing purposes
              // ignore: prefer_const_constructors
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xffEC5B5B),
                      padding: const EdgeInsets.symmetric(
                        vertical: 5,
                        horizontal: 10,
                      ),
                    ),
                    onPressed: () 
                    {
                      // VSharedPrefs().clear();
                      VSharedPrefs().remove("username");
                      VSharedPrefs().remove("rememberedPassword");
                      VSharedPrefs().remove("rememberedUsername");
                      Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => LoginPage(username: widget.username)));
                      // Navigator.of(context).pop(context);
                    }, // TODO: Implement LogoutController trigger event
                    child: const Text(
                      'Yes, Log me out!',
                      style: TextStyle(
                        color: VConstants.veracodeWhite,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: VConstants.veracodeBlue,
                      padding: const EdgeInsets.symmetric(
                        vertical: 5,
                        horizontal: 10,
                      ),
                    ),
                    onPressed: () {
                      Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => HomePage(username: widget.username)));
                    },
                    child: const Text(
                      'No, More Blab!',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ), 
          ],
        ),
      ),
    );
  }
}