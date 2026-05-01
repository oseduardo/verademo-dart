import 'package:flutter/material.dart';
import 'package:verademo_dart/pages/reset.dart';

import '../pages/blabbers.dart';
import '../pages/feed.dart';
import '../pages/logout.dart';
import '../pages/profile.dart';
import '../pages/tools.dart';
import '../utils/constants.dart';
import '../widgets/app_bar.dart';



class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.username});

  final String username;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentPageIndex = 0;

  late final List<Widget> screens;
  late final List<String> headers;

  @override
  initState()
  {
    super.initState();
    screens = [
      FeedPage(username: widget.username,),
      ProfilePage(),
      BlabbersPage(username: widget.username),
      ToolsPage(username: widget.username),
      LogoutPage(username: widget.username),
    ];

    headers = [
      'Feed',
      'Profile',
      'Blabbers',
      'Tools',
      'Logout',
    ];
  }

  
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (bool didPop) {
        if (didPop) return;
        setState(() => currentPageIndex = 4);
      },
      child: Scaffold(
        appBar: VAppBar(headers[currentPageIndex], actions: <Widget>[resetButton(context)], showBackArrow: false,),
        // appBar: HeaderBar(headers[currentPageIndex], context),
        body: IndexedStack(
          index: currentPageIndex,
          children: screens,
        ),
        bottomNavigationBar: NavigationBar(
          destinations: const [
            NavigationDestination(icon: Icon(Icons.home), label: 'Feed'),
            NavigationDestination(icon: Icon(Icons.person), label: 'Profile'),
            NavigationDestination(icon: Icon(Icons.people), label: 'Blabbers'),
            NavigationDestination(icon: Icon(Icons.design_services), label: 'Tools'), /* there is a wrench one, don't know what its called though */
            NavigationDestination(icon: Icon(Icons.logout), label: 'Logout'),
            /*
            onPressed: (){
              
              print('Navigator popping');
              Navigator.pop(context);},)
              }
              */
          ],
          selectedIndex: currentPageIndex,
          indicatorColor: VConstants.veracodeBlue,
          backgroundColor: VConstants.codeBlack,
          
          onDestinationSelected: (int index) {
            setState(() {
              currentPageIndex = index;
            });
          },
        ),
      ),
    );
  }

  static IconButton resetButton(BuildContext context) {
    return IconButton(
      icon: const Icon(
        Icons.repeat,
        color: VConstants.veracodeWhite,
      ),
      iconSize: 48,
      onPressed: () {
        showDialog(
          context: context, 
          builder: (BuildContext context) {
            return const resetPopup();
          }
        );
      } /*run reset controller,*/
    );
  }
}