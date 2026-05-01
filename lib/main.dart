import 'package:flutter/material.dart';
import 'package:verademo_dart/pages/login.dart';
import 'package:verademo_dart/utils/shared_prefs.dart';

import 'theme/theme.dart';

// Define colors to be used
const Color veracodeBlack = Color.fromARGB(255, 36, 38, 38);
const Color veracodeBlue =  Color.fromARGB(255, 0, 179, 230);
const Color veracodeWhite = Color.fromARGB(255,244, 244, 244);

//Create themes


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await VSharedPrefs().init();
  runApp( MyApp(username: VSharedPrefs().rememberedUsername, password: VSharedPrefs().rememberedPassword) );
}


class MyApp extends StatelessWidget {
  const MyApp({super.key, this.username, this.password});

  final String? username;
  final String? password;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Blab-a-Gag',
      /*theme: ThemeData(
        appBarTheme: ,
        navigationBarTheme: ,
        colorScheme: ColorSche
      ),*/
      theme: VTheme.defaultTheme,
      home: LoginPage(username: username, password: password)
      // Scaffold(
      //   appBar: AppBar(
      //     backgroundColor: veracodeBlack,
      //     title: const Text('hello world', 
      //       style: TextStyle(
      //         fontSize: 40,
      //         fontFamily: 'Lato',
      //         color:veracodeWhite),),
      //   ),
      //   body: const SizedBox(
      //     child: Center(
      //       child: Padding(
      //         padding: EdgeInsets.all(10),
      //         child: Text('Hello'),
      //         ),
      //     ),
      //   )
      // ,)
    );
  }
}