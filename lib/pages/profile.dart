import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gal/gal.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:verademo_dart/controllers/profile_controller.dart';
import 'package:verademo_dart/pages/events.dart';
import 'package:verademo_dart/pages/hecklers.dart';
import 'package:verademo_dart/utils/constants.dart';
import 'package:verademo_dart/utils/shared_prefs.dart';
import 'package:verademo_dart/utils/snackbar.dart';
import 'package:verademo_dart/widgets/profile_image.dart';
import 'package:verademo_dart/widgets/user_field.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({super.key});

  final username = VSharedPrefs().username ?? "";
  final controller = ProfileController();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: VConstants.pagePadding,
          child: Column(
            children: [
              _updateProfileForm(),
              const SizedBox(height: VConstants.textFieldSpacingMed * 2),
              _hecklersButton(context),
              const SizedBox(height: VConstants.textFieldSpacing / 2),
              _historyButton(context),
            ],
          )
        )
      )
    );
  }

  SizedBox _historyButton(context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          controller.updateEvents(username, (results) => {
              Navigator.push(context,
                MaterialPageRoute(builder: (context) => EventsPage(events: results)),)
            }
           );
          
        },
        child: const Text("History"),
      ),
    );
  }

  SizedBox _hecklersButton(context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(context,
            MaterialPageRoute(builder: (context) => HecklersPage(hecklers: controller.hecklers)),);
        },
        child: const Text("Hecklers"),
      ),
    );
  }

  Form _updateProfileForm() {

    print("Setting variables using username ${VSharedPrefs().username}");
    controller.setVariablesFromUsername(VSharedPrefs().username ?? "");

    return Form(
      child: Column(
        children: [
          ProfileImage(VSharedPrefs().username),
          const SizedBox(height: VConstants.textFieldSpacing * 2),
          VUserField("Real Name", controller: controller.realName),
          const SizedBox(height: VConstants.textFieldSpacingMed),
          VUserField("Blab Name", controller: controller.blabName),
          const SizedBox(height: VConstants.textFieldSpacingMed),
          VUserField("Username", controller: controller.username),
          const SizedBox(height: VConstants.textFieldSpacingMed),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () async { controller.processProfile(); },
              child: const Text("Update Profile"),
            ),
          )
        ],
      ),
    );
  }
  

  
}

class ProfileImage extends StatefulWidget {
  const ProfileImage(this.username, {
    super.key,
  });

  final String? username;

  @override
  State<ProfileImage> createState() => _ProfileImageState();
}

class _ProfileImageState extends State<ProfileImage> {

  // @override
  // void initState() {
  //   super.initState();
    // _profileImage = getProfileImage(widget.username);
  // }

  void _updateImage() {
    setState(() {
      imageCache.clear();
      // imageCache.clearLiveImages();
      
      // _profileImage = getProfileImage(widget.username);
    });
  }
  

  // getProfileImage(String? username) async {
  //   final dir = await getApplicationDocumentsDirectory();
  //   final image = File("${dir.path}/$username.png");
  //   if (image.existsSync()) {
  //     return FileImage(image);
  //   } else {
  //     return AssetImage('assets/images/$username.png');
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Row(
      key: UniqueKey(),
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // CircleAvatar(
        //   foregroundImage:  File('assets/images/$username.png').existsSync() ? AssetImage('assets/images/$username.png') : const AssetImage('assets/images/default_profile.png'),
        //   backgroundImage: const AssetImage('assets/images/default_profile.png'),
        //   radius: 48,
        // ),
        VAvatar(widget.username),
        // FutureBuilder<dynamic> ( 
        //   future: _profileImage,
        //   builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        //   return CircleAvatar(
        //     key: UniqueKey(),
        //     foregroundImage: snapshot.data,
        //     backgroundImage: const AssetImage(VConstants.defaultProfile),
        //     radius: 48,
        //     );
        //   }
        // ),
        const SizedBox(width: 30),
        _profileImageActions()
      ]
    );
  }

  Expanded _profileImageActions() {
    return Expanded(
      child: Column(
        children: [
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () async { await _uploadImage(); _updateImage(); },
              child: const Text("Change Profile Picture")
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _downloadImage,
              child: const Text("Download Current Image")
            ),
          ),
        ]
      )
    );
  }

  void _downloadImage() async {
    if (!await Gal.hasAccess()) {
      await Gal.requestAccess();
      if (!await Gal.hasAccess()) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(VSnackBar.errorSnackBar("Permission Denied."));
        }
        return;
      }
    }

    final downloadsDir = await getDownloadsDirectory();
    if (!File("${downloadsDir?.path}/${widget.username}.png").existsSync()) {
      File('${downloadsDir?.path}/${widget.username}.png').createSync(recursive: true);
    }
    
    final documentsDir = await getApplicationDocumentsDirectory();
    final File oldFile = File("${documentsDir.path}/${widget.username}.png");
    if (oldFile.existsSync()) {
      Gal.putImage("${documentsDir.path}/${widget.username}.png");
    } else {
      try {
        final ByteData image = await rootBundle.load('assets/images/${widget.username}.png');
        Gal.putImageBytes(image.buffer.asUint8List(image.offsetInBytes, image.lengthInBytes));
      } catch (err) {
        final ByteData image = await rootBundle.load('assets/images/${VConstants.defaultProfile}.png');
        Gal.putImageBytes(image.buffer.asUint8List(image.offsetInBytes, image.lengthInBytes));
      }
    }

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(VSnackBar.successSnackBar("Image Downloaded Successfully!"));
    }
  }

  Future<void> _uploadImage() async {
    final XFile? image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image != null) {
      final dir = await getApplicationDocumentsDirectory();
      final File newFile = File("${dir.path}/${widget.username}.png");
      if (!newFile.existsSync()) {
        newFile.create(recursive: true);
      }
      await File(image.path).copy("${dir.path}/${widget.username}.png", );
    }

  }
}

