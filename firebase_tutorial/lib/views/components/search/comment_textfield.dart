import 'package:firebase_tutorial/config/export.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// ignore: must_be_immutable
class CommentField extends ConsumerStatefulWidget {
  TextEditingController controller;
  VoidCallback press;
  CommentField({Key? key, required this.controller, required this.press})
      : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CommentFieldState();
}

class _CommentFieldState extends ConsumerState<CommentField> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0.w),
          alignment: Alignment.center,
          height: 50.h,
          width: 300.w,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15.r),
                bottomLeft: Radius.circular(15.r)),
            border: Border.all(width: 2.w, color: AppColor.blackBorder),
          ),
          child: TextField(
            controller: widget.controller,
            maxLines: 1,
            minLines: 1,
            textAlign: TextAlign.center,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: 'Comment here',
              hintStyle:
                  TextStyle(color: AppColor.subTextColor, fontSize: 16.sp),
              isCollapsed: true,
            ),
          ),
        ),
        GestureDetector(
          onTap: widget.press,
          child: Container(
            alignment: Alignment.center,
            height: 50.h,
            width: 51.w,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(15.r),
                  bottomRight: Radius.circular(15.r)),
              border: Border.all(width: 2.w, color: AppColor.blackBorder),
            ),
            child: Image(
              image: AssetImage('assets/icons/comment.png'),
              width: 35.w,
              height: 35.w,
            ),
          ),
        ),
      ],
    );
  }
}
