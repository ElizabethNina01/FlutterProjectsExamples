import 'package:flutter/material.dart';
class Bat extends StatelessWidget {
  late final double width;
  late final double height;
  Bat(this.width, this.height);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: new BoxDecoration(
        color: Colors.blue[900],
      ),
    );
  }
}
