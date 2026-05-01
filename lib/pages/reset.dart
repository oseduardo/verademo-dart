import 'package:flutter/material.dart';
import 'package:verademo_dart/controllers/reset_controller.dart';
import 'package:verademo_dart/utils/constants.dart';


// ignore: camel_case_types, for testing purposes, may be removed in future
class resetPopup extends StatefulWidget {
  const resetPopup({super.key});

  @override
  State<resetPopup> createState() => resetWidget();

}


// ignore: camel_case_types
class resetWidget extends State<resetPopup> {
  // const resetWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 5,
          vertical: 15,
        ),
        decoration: const BoxDecoration(
          color : VConstants.veracodeBlack,
          borderRadius: BorderRadius.all(Radius.circular(15)),
        ),
        child : Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              // mainAxisAlignment: MainAxisAlignment.center,
              // mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(
                  icon: const Icon(
                    Icons.close,
                    color: VConstants.veracodeWhite
                  ),
                  iconSize: 35,
                  onPressed: () {
                    _CheckBoxState.isReset["Confirm"] = false;
                    Navigator.of(context).pop();
                  },
                ),
                const SizedBox(width: 10),
                Text('Confirm Reset', style: Theme.of(context).textTheme.titleSmall,)
              ],
            ),
            const SizedBox(height:25),
            // spacing purposes
            // ignore: prefer_const_constructors
            CheckboxListTile(
              controlAffinity: ListTileControlAffinity.leading,
              value: _CheckBoxState.isReset['Confirm'],
              title : const Text(
                'I realize that I will lose all data in my current VeraDemo instance, including users.',
                textAlign: TextAlign.center,
                // ignore: prefer_const_constructors
                style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                ),
              ),
              onChanged: (bool? value) {
                setState(() {
                  _CheckBoxState.isReset['Confirm'] = value!;
                });
              },
            ),
            const SizedBox(height: 25),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xffEC5B5B),
                    padding: const EdgeInsets.symmetric(
                      vertical: 0, 
                      horizontal: 130,
                    ),
                  ),
                  onPressed: () => 
                  {
                    if (_CheckBoxState.isReset["Confirm"] == true)
                    {
                      _CheckBoxState.isReset["Confirm"] = false,
                      ResetController().processReset(context)
                    }
                  },
                  child: const Text(
                    'Reset',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ), 
          ],
        ),
      ),
    );
  }
}

class CheckBox extends StatefulWidget {
  const CheckBox({super.key});
  @override
  State<CheckBox> createState() => _CheckBoxState();
}

class _CheckBoxState extends State<CheckBox> {
  bool _isChecked = false;

  static Map<String,bool?> isReset = {
    'Confirm' : false,
  };
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Checkbox(
          value: _isChecked,
          onChanged: (value) {
            setState(() {
              _isChecked = value!;
            });
          },
        ),
      ],
    );
  }
}