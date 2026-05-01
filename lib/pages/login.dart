import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:verademo_dart/controllers/login_controller.dart';
import 'package:verademo_dart/theme/theme.dart';
import 'package:verademo_dart/utils/constants.dart';
import 'package:verademo_dart/widgets/credentials_field.dart';
import 'package:verademo_dart/widgets/stateful_checkbox.dart';

import 'register.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key, this.username, this.password});

  final String? username;
  final String? password;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: VTheme.loginTheme,
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: VConstants.loginSpacing,
            child: Column (
              children: [
                const SizedBox(height: 60),
                _loginTitle(context),
                const SizedBox(height: 10),
                _loginSubtitle(context),
                const SizedBox(height: 58),
                // const _LoginForm(),
                _loginForm(context),
                const SizedBox(height: 35),
                _signUpText(context),
                const SizedBox(height: 90),
                _APIForm(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Text _loginSubtitle(BuildContext context) {
    return Text(
      "The home of witty one-liners",
      style: Theme.of(context).textTheme.headlineMedium?.copyWith(color: VConstants.lightNeutral2)
    );
  }

  Form _loginForm(BuildContext context) {
    final controller = LoginController();

    controller.username.text = username ?? "";
    controller.password.text = password ?? "";

    WidgetsBinding.instance.addPostFrameCallback( (_) {
      if (controller.username.text != "" && controller.password.text != "") {
        controller.processLogin(context);
      }
    });

    return Form(
      key: controller.loginFormKey,
      child: Column(
        children: [
          VCredField("Username", controller: controller.username),
          const SizedBox(height: VConstants.textFieldSpacing),
          VCredField("Password", controller: controller.password, hide: true),
          _rememberMe(controller),
          const SizedBox(height: 30),
          _loginButton(context, controller),
        ],
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Column _APIForm(BuildContext context) {
    final controller = LoginController();

    controller.api.text = VConstants.apiUrl;

    return Column(
      children: [
        VCredField("http://...", controller: controller.api),
        const SizedBox(height: VConstants.textFieldSpacing),
        //const SizedBox(height: 10),
        ElevatedButton(
          onPressed: () => controller.processAPI(context),
          child: const Text('Sync API'),
        ),
      ],
    );
  }

  Padding _rememberMe(LoginController controller) {
    return Padding(
      padding: const EdgeInsets.only(top: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          VCheckbox(value: controller.rememberMe, onChanged: ((bool? newValue) {
            print("Controller remember me was ${controller.rememberMe}");
            controller.rememberMe = newValue ?? true;
            print("Controller remember me set to ${controller.rememberMe}");

            // TODO: rememberMe functionality
            if (controller.rememberMe) {

            } else {

            }
          })),
          const Text("Remember me")
        ],
      ),
    );
  }

  Text _signUpText(BuildContext context) {
    return Text.rich(
      TextSpan(children: [
        const TextSpan(text: "Don't have an account? "),
        TextSpan(
          text: "Sign Up",
          // style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.blue),
          style: const TextStyle(
            color: Colors.blue
          ),
          recognizer: TapGestureRecognizer()..onTap = () {
            print("Sign up");
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => const RegisterPage()));
          }
        ),
      ]),
    );
  }

  Row _loginTitle(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Image(
          height: 48,
          image: AssetImage(VConstants.vcIcon)
        ),
        const SizedBox(width: 9.2),
        Text("Blab-a-Gag", style: Theme.of(context).textTheme.titleMedium?.copyWith(color: VConstants.codeWhite)),
        const SizedBox(width: 4),
      ],
    );
  }

  ElevatedButton _loginButton(BuildContext context, LoginController controller) {
    return ElevatedButton(
      onPressed: () => controller.processLogin(context),
      // onPressed: () {
      //   Navigator.push(context,
      //   MaterialPageRoute(builder: (context) => const HomePage(username: 'Hello, World')),);
      // },
      child: const Text('Login'),
    );
  }
}
