import 'package:flutter/material.dart';
import 'package:verademo_dart/utils/constants.dart';


class VAppBar extends StatelessWidget implements PreferredSizeWidget {

  const VAppBar(this.pageTitle, {super.key, this.showBackArrow = true, this.actions});

  final String pageTitle;
  final double iconSize = 48;
  final bool showBackArrow;
  final List<Widget>? actions;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: showBackArrow ? 8 : 20, vertical: 5),
      color: VConstants.codeBlack,
      child: AppBar(
        automaticallyImplyLeading: false,
        leading: showBackArrow ? _backButton(context) : _logoIcon(),
        titleSpacing: showBackArrow ? 20 : 0,
        title: Text(pageTitle, style: Theme.of(context).textTheme.titleMedium),
        actions: actions,
        backgroundColor: VConstants.codeBlack,
        centerTitle: !showBackArrow,
      )
    );
  }

  
  // HeaderBar(String pageName, BuildContext context, {super.key}):super(
  //   toolbarHeight: 83,
  //   leadingWidth: 55,
  //   leading: const ImageIcon(AssetImage("assets/VCicon.png"), color: VConstants.veracodeBlue, size:24),
  //   title: Text(pageName, style: Theme.of(context).textTheme.titleMedium),
  //   centerTitle: true,
  //   backgroundColor: VConstants.codeBlack,
  //   actions: <Widget>[
  //     resetButton(context)
  //     ],
  //   );

  // static IconButton resetButton(BuildContext context) {
  //   return IconButton(
  //     icon: const Icon(
  //       Icons.repeat,
  //       color: VConstants.veracodeWhite,
  //     ),
  //     iconSize: 48,
  //     onPressed: () {
  //       showDialog(
  //         context: context, 
  //         builder: (BuildContext context) {
  //           return const resetPopup();
  //         });} /*run reset controller,*/
  //     );
  // }

  ImageIcon _logoIcon () {
    return ImageIcon(
      const AssetImage("assets/VCicon.png"),
      color: VConstants.veracodeBlue,
      size: iconSize / 2,
    );
  }

  IconButton _backButton(BuildContext context) {
    return IconButton(
      icon: const Icon(
        Icons.arrow_back,
        color: VConstants.veracodeWhite,
      ),
      iconSize: iconSize,
      onPressed: () {
        Navigator.of(context).pop();
      } /*run reset controller,*/
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(80);
}