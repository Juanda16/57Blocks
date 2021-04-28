import 'package:flutter/material.dart';

class ExpandedButton extends StatelessWidget {
  final String text;
  final Color backgroundColor;

  ExpandedButton({required this.text, required this.backgroundColor});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TextButton(
        onPressed: () {},
        autofocus: true,
        child: Text(text),
        style: ButtonStyle(
          textStyle: MaterialStateProperty.all(
            TextStyle(
              color: Colors.black54,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          padding: MaterialStateProperty.all(EdgeInsets.all(10)),
          backgroundColor: MaterialStateProperty.all(backgroundColor),
          foregroundColor: MaterialStateProperty.all(Colors.white),
          elevation: MaterialStateProperty.all(20),
        ),
      ),
    );
  }
}
