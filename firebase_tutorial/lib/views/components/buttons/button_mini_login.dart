import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// ignore: must_be_immutable
class LoginMiniButton extends StatelessWidget {
  String title;
  Color color;
  VoidCallback onPressed;
  LoginMiniButton({Key? key, required this.title, required this.color, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: 50.h,
        width: 123.w,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: color,
          border: Border.all(width: 1.h, color: const Color.fromARGB(255, 128, 128, 128)),
          borderRadius: BorderRadius.circular(15.0.w),
        ),
        child: Text(title, style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18.sp, color: Colors.white),),
      ),
    );
  }
}