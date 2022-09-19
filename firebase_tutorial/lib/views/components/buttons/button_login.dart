import 'package:firebase_tutorial/config/app_textstyle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// ignore: must_be_immutable
class LoginFuncButton extends StatelessWidget {
  String title;
  Color color;
  VoidCallback onPressed;
  LoginFuncButton({Key? key, required this.title, required this.color, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: 50.h,
        width: 262.w,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: color,
          border: Border.all(width: 2.h, color: Colors.black),
          borderRadius: BorderRadius.circular(15.0.w),
        ),
        child: Text(title, style: AppTextStyle.buttonText,),
      ),
    );
  }
}