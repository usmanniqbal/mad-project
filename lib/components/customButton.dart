import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final Color color;
  final String text;
  final String imageUri;
  final double borderRadius;
  final VoidCallback onPressed;
  CustomButton({
    @required this.color,
    this.text,
    this.borderRadius,
    this.onPressed,
    this.imageUri,
  }) : assert(color != null);

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            imageUri != null
                ? Image.asset(this.imageUri)
                : Opacity(
                    opacity: 0.0,
                  ),
            Text(
              this.text,
              style: TextStyle(
                color: Colors.black,
                fontSize: 16.5,
              ),
            ),
            Opacity(
              opacity: 0.0,
            ),
          ],
        ),
        onPressed: onPressed,
        color: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
        ));
  }
}
