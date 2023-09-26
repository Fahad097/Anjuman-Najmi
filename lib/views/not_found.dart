import 'package:flutter/material.dart';

class NotFoundPage extends StatelessWidget {
  const NotFoundPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Text(
        "Not Found Page",
        style: TextStyle(
          fontFamily: 'Helvetica',
          color: Colors.black,
          fontSize: 17,
          fontWeight: FontWeight.w400,
        ),
      ),
    ));
  }
}
