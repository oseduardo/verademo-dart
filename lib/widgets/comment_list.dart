import 'package:flutter/material.dart';
import 'package:verademo_dart/utils/constants.dart';
import 'package:verademo_dart/widgets/profile_image.dart';

class CommentList extends StatefulWidget
{
  final List comments;

  const CommentList(this.comments,{super.key});

  @override
  State<CommentList> createState() => _CommentListState();
}

class _CommentListState extends State<CommentList> {
  
  @override
  Widget build(BuildContext context) {

    return ListTileTheme(
      textColor: VConstants.veracodeWhite,
      child: ListView(
        children: ListTile.divideTiles(
          context: context,
          color: VConstants.lightNeutral3,
          tiles: listBuilder(widget.comments)
        ).toList()
      ),
    );
  }

  List<Widget> listBuilder(List comments)
  {
    List<Widget> items = [];
    for (int i=0; i<comments.length; i++)
    {
      items.add(buildListItem(comments[i]));
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