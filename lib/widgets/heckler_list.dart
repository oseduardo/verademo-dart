import 'package:flutter/material.dart';
import 'package:verademo_dart/utils/constants.dart';
import 'package:verademo_dart/widgets/profile_image.dart';

class HecklerList extends StatefulWidget
{
  final List hecklers;

  const HecklerList(this.hecklers,{super.key});

  @override
  State<HecklerList> createState() => _HecklerListState();
}

class _HecklerListState extends State<HecklerList> {
  
  @override
  Widget build(BuildContext context) {

    return  ListTileTheme(
              textColor: VConstants.veracodeWhite,
              child: ListView(
                children: ListTile.divideTiles(
                  context: context,
                  color: VConstants.lightNeutral3,
                  tiles: listBuilder(widget.hecklers)).toList()
      ),
    );
  }

  List<Widget> listBuilder(List hecklers)
  {
    List<Widget> items = [];
    for (int i=0; i<hecklers.length; i++)
    {
      items.add(buildListItem(hecklers[i]));
    }
    return items;
  }

  Widget buildListItem(Map user) {
    // String name = user['username'].toLowerCase();
    String name = user['username'];
    return ListTile(
      leading: VAvatar(name, radius: 20),
      title: Text(name),
    );
  }
}