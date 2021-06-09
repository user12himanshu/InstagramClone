import 'package:flutter/material.dart';

import '../constants.dart';

class PrimaryButton extends StatelessWidget {
  final String? text;
  final void Function()? onpressed;
  final double? width;
  final double? height;
  const PrimaryButton({
    Key? key,
    this.text,
    this.onpressed,
    this.width,
    this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onpressed,
      child: Text(
        text!,
        style: TextStyle(
            color: Colors.white, fontWeight: FontWeight.bold, fontSize: 17.4),
      ),
      style: TextButton.styleFrom(
          backgroundColor: kprimaryColor, fixedSize: Size(width!, height!)),
    );
  }
}
