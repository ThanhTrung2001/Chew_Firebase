import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// ignore: must_be_immutable
class ContentTextField extends StatelessWidget {
  TextEditingController controller;
  String hint;
  ContentTextField({Key? key, required this.controller, required this.hint})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      padding: const EdgeInsets.all(5.0),
      alignment: Alignment.center,
      height: 174.h,
      width: 314.w,
      decoration: BoxDecoration(
          color: const Color(0xFFF1F1F1),
          borderRadius: BorderRadius.circular(15.0),
          border: Border.all(
            color: const Color.fromARGB(255, 145, 145, 145),
            width: 1,
          )),
      child: TextField(
        expands: true,
        textAlign: TextAlign.left,
        textAlignVertical: TextAlignVertical.center,
        maxLines: null,
        controller: controller,
        style: TextStyle(fontSize: 18.sp, color: Colors.black),
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hint,
          hintStyle: const TextStyle(color: Color.fromARGB(255, 70, 70, 70)),
          isCollapsed: true,
        ),
      ),
    );
  }
}
