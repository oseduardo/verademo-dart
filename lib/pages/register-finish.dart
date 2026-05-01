import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:verademo_dart/controllers/register_controller.dart';
import 'package:verademo_dart/theme/theme.dart';
import 'package:verademo_dart/utils/constants.dart';
import 'package:verademo_dart/widgets/credentials_field.dart';

import 'login.dart';

class RegisterFinishPage extends StatelessWidget {
  const RegisterFinishPage({super.key, required this.controller});

  final RegisterController controller;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: VTheme.loginTheme,
      child: Scaffold(
        appBar: AppBar(backgroundColor: VConstants.veracodeBlack,),
        body: SingleChildScrollView(
          child: Padding(
            padding: VConstants.loginSpacing,
            child: Column (
              children:  [
                const SizedBox(height: 44),
                _registerTitle(context),
                const SizedBox(height: 50),
                _registerForm(context),
                const SizedBox(height: 85),
                _signInText(context)
              ],
            ),
          ),
        ),
      ),
    );
  }

  Text _registerTitle(BuildContext context) {
    return Text(
      "Complete Register",
      style: Theme.of(context).textTheme.headlineLarge?.copyWith(color: VConstants.veracodeWhite),
    );
  }

  Form _registerForm(BuildContext context) {

    return Form(
      key: controller.registerFinishFormKey,
      child: Column(
        children: [
          VCredField('Username', controller: controller.username, edit: false),
          const SizedBox(height: VConstants.textFieldSpacing),
          VCredField('Password', controller: controller.password, hide: true),
          const SizedBox(height: VConstants.textFieldSpacing),
          TextFormField (
            controller: controller.cpassword,
            obscureText: true,
            validator: (value) => _validatePasswordMatch(controller),
            textAlignVertical: TextAlignVertical.center,
            decoration: const InputDecoration(
              hintText: "Confirm Password",
            ),
          ),
          const SizedBox(height: VConstants.textFieldSpacing),
          VCredField('Real Name', controller: controller.realName),
          const SizedBox(height: VConstants.textFieldSpacing),
          VCredField('Blab Name', controller: controller.blabName),
          const SizedBox(height: 42),
          _registerButton(context, controller),
        ],
      ),
    );
  }

  Text _signInText(BuildContext context) {
    return Text.rich(
      TextSpan(children: [
        const TextSpan(text: "Already have an account? "),
        TextSpan(
          text: "Sign In",
          // style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.blue),
          style: const TextStyle(
            color: Colors.blue
          ),
          recognizer: TapGestureRecognizer()..onTap = () {
            print("Sign in");
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => const LoginPage()));
          }
        ),
      ]),
    );
  }

  Row signUpTitle(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Image(
          height: 48,
          image: AssetImage(VConstants.vcIcon)
        ),
        const SizedBox(width: 9.2),
        Text("Register", style: Theme.of(context).textTheme.titleMedium?.copyWith(color: VConstants.codeWhite)),
        const SizedBox(width: 4),
      ],
    );
  }

  ElevatedButton _registerButton(BuildContext context, RegisterController controller) {
    return ElevatedButton(
      child: const Text('Register'),
      onPressed: () {
        controller.processRegisterFinish(context);
      },
    );
  }

  static String? _validatePasswordMatch(RegisterController controller) {
    print("Controller cpassword is: ${controller.cpassword.text}");
    if (controller.cpassword.text.isEmpty) {
      return "Confirm password is required.";
    }

    if (controller.password.text != controller.cpassword.text) {
      return "Passwords must match.";
    }

    return null;
  }
}