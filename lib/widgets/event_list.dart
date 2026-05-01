import 'package:flutter/material.dart';
import 'package:verademo_dart/utils/constants.dart';

class EventList extends StatefulWidget
{
  final List events;

  const EventList(this.events,{super.key});

  @override
  State<EventList> createState() => _EventListState();
}

class _EventListState extends State<EventList> {
  
  @override
  Widget build(BuildContext context) {

    return  ListTileTheme(
              textColor: VConstants.veracodeWhite,
              child: ListView(
                children: ListTile.divideTiles(
                  context: context,
                  color: VConstants.lightNeutral3,
                  tiles: listBuilder(widget.events)).toList()
      ),
    );
  }

  List<Widget> listBuilder(List events)
  {
    List<Widget> items = [];
    for (int i=0; i<events.length; i++)
    {
      items.add(buildListItem(events[i]));
    }
    return items;
  }

  Widget buildListItem(String message) {
    return ListTile(
      title: Text(message),
    );
  }
}