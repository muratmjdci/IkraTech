import 'package:flutter/material.dart';

class DefaultButton extends StatelessWidget {
  final Function onPressed;
  final String text;
  DefaultButton({
    this.text,
    @required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return OutlineButton(
      borderSide: BorderSide(color: Colors.red),
      child: Text(
        this.text,
        style: TextStyle(color: Colors.red),
      ),
      onPressed: this.onPressed,
    );
  }
}
