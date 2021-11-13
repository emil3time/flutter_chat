import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  RoundedButton(
      {required this.tittleButton,
      required this.onClick,
      required this.kolorek});

  final String tittleButton;
  final VoidCallback? onClick;
  final Color kolorek;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        elevation: 5.0,
        color: kolorek,
        borderRadius: BorderRadius.circular(30.0),
        child: MaterialButton(
          onPressed:
              //Go to login screen.
              onClick,
          minWidth: 200.0,
          height: 42.0,
          child: Text(
            '$tittleButton',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
