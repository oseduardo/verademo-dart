import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

import 'package:verademo_dart/utils/constants.dart';

class VAvatar extends StatefulWidget {
  const VAvatar(this.username, {super.key, this.radius = 48});

  final String? username;
  final double radius;

  @override
  State<VAvatar> createState() => _VAvatarState();
}

class _VAvatarState extends State<VAvatar> {
  Future<dynamic>? _profileImage;

  @override
  void initState() {
    super.initState();
    _profileImage = getProfileImage(widget.username);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<dynamic> ( 
      future: _profileImage,
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        return CircleAvatar(
          foregroundImage: snapshot.data,
          backgroundImage: const AssetImage(VConstants.defaultProfile),
          radius: widget.radius,
        );
      }
    );
  }
}

getProfileImage(String? username) async {
  final dir = await getApplicationDocumentsDirectory();
  final image = File("${dir.path}/$username.png");
  if (image.existsSync()) {
    return FileImage(image);
  } else {
    return AssetImage('assets/images/$username.png');
  }
}
