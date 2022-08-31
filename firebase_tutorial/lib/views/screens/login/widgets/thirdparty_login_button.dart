import 'package:flutter/material.dart';

class ThirdPartyLoginButton extends StatelessWidget {
  String imgLink;
  VoidCallback onPressed;
  ThirdPartyLoginButton({
    Key? key,
    required this.imgLink, required this.onPressed
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Image.asset(imgLink, scale: 4,),
    );
  }
}