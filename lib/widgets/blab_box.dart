
// ignore: non_constant_identifier_names
import 'package:flutter/material.dart';
import 'package:verademo_dart/utils/constants.dart';
import 'package:verademo_dart/widgets/profile_image.dart';

// ignore: non_constant_identifier_names
Container BlabBox(username, blabber, content, timestamp,{ellipsis=false, feed=false}){
  return Container(
    decoration: BoxDecoration(
        color: VConstants.darkNeutral2,
        borderRadius: BorderRadius.circular(10),
      ),
    width: double.infinity,
    child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BlabberHeader(username: username, blabName: blabber, timestamp: timestamp),
              const SizedBox(height: 10,),
              Builder(
                builder: (context) {
                  if (ellipsis)
                  {
                    return Text(content, overflow: TextOverflow.ellipsis,);
                  }
                  else{
                    return Text(content, softWrap: true,);
                  }
                }
              
              )
              
        ]),
      ),);
  
}

class BlabberHeader extends StatelessWidget {
  
  final String username;
  final String blabName;
  final String timestamp;
  const BlabberHeader({
    super.key,
    required this.username,
    required this.blabName,
    required this.timestamp,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
      VAvatar(username, radius:30),
      const SizedBox(width: 10,),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(blabName,
            style: Theme.of(context).textTheme.headlineMedium, ),
          Text(timestamp, 
            style: Theme.of(context).textTheme.labelSmall),
        ],
      ), 
              
      ],);
  }
}