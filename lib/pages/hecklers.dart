import 'package:flutter/material.dart';
// import 'package:verademo_dart/theme/text_theme.dart';
import 'package:verademo_dart/utils/constants.dart';
import 'package:verademo_dart/widgets/app_bar.dart';
import 'package:verademo_dart/widgets/heckler_list.dart';

class HecklersPage extends StatelessWidget
{

  final List hecklers;

  const HecklersPage({super.key, required this.hecklers});

  @override
  Widget build (BuildContext context)
  {
    return Scaffold(
      appBar: const VAppBar('Hecklers'),
      // appBar: HecklerBar('Hecklers',context),
      backgroundColor: VConstants.darkNeutral1,
      body: HecklerList(hecklers)
              
              /*const Center(
                child: Text(
                  'No Blabs yet...',
                  style: TextStyle(color: VConstants.codeWhite),
                ),
              ),*/
        );
  }
}
// ImageIcon veraIcon = const ImageIcon(AssetImage("assets/VCicon.png"), color: VConstants.veracodeBlue, size:24);

// class HecklerBar extends AppBar{
//   HecklerBar(String pageName, BuildContext context, {super.key}):super(
//     toolbarHeight: 83,
//     leadingWidth: 55,
//     leading: resetButton(context),
//     title: Text(pageName, style: VTextTheme.defaultTextTheme.titleMedium,),
//     centerTitle: true,
//     backgroundColor: VConstants.codeBlack,
//     );

//   static IconButton resetButton(BuildContext context) {
//     return IconButton(
//       icon: const Icon(
//         Icons.arrow_back,
//         color: VConstants.veracodeWhite,
//       ),
//       iconSize: 48,
//       onPressed: () {
//         Navigator.of(context).pop();
//       } /*run reset controller,*/
//       );
//   }
// }