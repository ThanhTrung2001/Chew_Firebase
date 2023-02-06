import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// ignore: must_be_immutable
class PasswordTextField extends StatelessWidget {
  TextEditingController controller;
  String hint;
  PasswordTextField({Key? key, required this.controller, required this.hint})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.only(left: 23.w, right: 23.0.w),
      alignment: Alignment.center,
      height: 50.h,
      width: 340.w,
      decoration: BoxDecoration(
          color: const Color(0xFFF1F1F1),
          borderRadius: BorderRadius.circular(15.0),
          border: Border.all(
            color: const Color.fromARGB(255, 145, 145, 145),
            width: 1,
          )),
      child: TextField(
        obscureText: true,
        textAlign: TextAlign.left,
        textAlignVertical: TextAlignVertical.center,
        maxLines: 1,
        controller: controller,
        style: TextStyle(fontSize: 18.sp, color: Colors.black),
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hint,
          hintStyle: const TextStyle(color: Color(0xFF767676)),
          isCollapsed: true,
        ),
      ),
    );
  }
}
