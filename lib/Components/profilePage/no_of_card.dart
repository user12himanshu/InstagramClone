import 'package:flutter/material.dart';

import '../../constants.dart';

class NoofCard extends StatelessWidget {
  final String? no;
  final String? label;
  const NoofCard({Key? key, this.label, this.no}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            no!,
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 21, color: ktextColor),
          ),
          Text(
            label!,
            style: TextStyle(
                fontWeight: FontWeight.w400, fontSize: 17, color: ktextColor),
          )
        ],
      ),
    );
  }
}
