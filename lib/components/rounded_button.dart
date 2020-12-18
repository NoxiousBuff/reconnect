import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  final Color colour;
  final String buttonText;
  final Function onPressed;

  RoundedButton({this.colour, this.onPressed, this.buttonText});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 25.0, top: 10.0, right: 25.0, bottom: 10.0),
      child: FlatButton(
        minWidth: double.infinity,
        padding: EdgeInsets.only(bottom: 20.0, top: 20.0),
        onPressed: onPressed,
        child: Text(
          buttonText,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 15.0,
          ),
        ),
        color: colour,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
      ),
    );
  }
}
