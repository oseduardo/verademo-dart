# VeraDemo-Dart - Blab-a-Gag

### Notice

This project is intentionally vulnerable! It contains known vulnerabilities and security errors in its code and is meant as an example project for software security scanning tools such as Veracode. Please do not report vulnerabilities in this project; the odds are they’re there on purpose :) .

## About

Blab-a-Gag is a fairly simple forum type application which allows:

- Users can post a one-liner joke.
- Users can follow the jokes of other users or not (listen or ignore).
- Users can comment on other users messages (heckle).

### Pages

- `Home` shows the jokes/heckles that are relevant to the current user.
- `Blabbers` shows a list of all other users and allows the current user to listen or ignore.
- `Profile` allows the current user to modify their profile.
- `Login` allows you to log in to your account
- `Register` allows you to create a new user account
- `Tools` shows a tools page that shows a fortune or lets you ping a host.
- `Reset` lets the user reset the database being used.
- `Logout` takes the user back to the login page.

## Run
**Preface: Setup has a lot of steps.** This means there are lots of places to mess up, get lost, misconfigure, and have to troubleshoot. Do not try to do this 15 minutes before a demo.

The app has multiple parts that need to be executed to bring it online. The app runs on a local Android Emulator, but most of the funcitonality depends on an external API which must be setup as well. Therefore there are two steps to get this app operational:

### Setup local simulator

Step 1: **Download Flutter**
This section boils down to:
 - Download Flutter
 - Configure Android Studio

Follow the instructions to download Flutter and Android Studio [here](https://docs.flutter.dev/get-started/install)

**Tips**
 - Downloading via VSCode is optional, but easier!
 - Flutter has great documentation. If you get stuck, it is likely addressed somewhere on flutter's docs
 - Reminder: Apple Silicon users need Rosetta (mentioned in flutter docs). [Install](https://support.apple.com/en-us/102527)

We developed this app for the Pixel 8 API 35 device, so we recommend selecting this for your emulator device.
Once you are able to run `flutter doctor` with no errors, you are ready for step 2.

Step 2: **Run application on emulator**
This section is more straightforward:
 - Clone project
 - Start emulator
 - Run project


**Clone the repository:**
    
    git clone "https://github.com/veracode-demo-labs/verademo-dart.git"
    
    cd verademo-dart

Open the project in either Android Studio or VSCode, depending on preference
 - NOTE: If you didn't configure flutter with VSCode in Step 1, don't use it for this.

For VSCode:
In the bottom right corner, start an emulator, then run the project with `flutter run` in terminal while in the project folder.

For Android Studio:
 - Select a device to run in 'Device Manager' using run button
 - Press run button at the top of the screen. Make sure the entrypoint is main.dart.

Now the login page for Blab-a-gag mobile should display! However with no API connected, login will fail.

### Setup API

This app connects to an instance of [VeraDemoAPI](https://github.com/veracode-demo-labs/verademo-javascript-api), which can be hosted either locally or on demolabs.

Hosting on DemoLabs is recommended as it allows for Dynamic Analysis scanning, and is easier to configure.

#### DemoLabs
 - Login to DemoLabs
 - Create an instance of VerademoAPI
 - when running, paste the link for Dynamic Analysis into the `Sync API` box on the login screen of the emulator. Press the `Sync` button, and you should be good to go. You will know based on what popup you receive.

#### Locally Hosted
 - Just don't do it.

## Exploitation Demos

Flutter is a new language and is therefore very secure, so there currently aren't any demoable vulnerabilities.


## Technologies Used

- Flutter
- [fortune-dart](https://github.com/rinukkusu/fortune-dart/blob/master/lib/fortune.dart)
