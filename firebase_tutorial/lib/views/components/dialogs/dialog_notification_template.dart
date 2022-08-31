import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// ignore: must_be_immutable
class DialogNotificationTemplate extends ConsumerStatefulWidget {
  String title;
  String content;
  Color color;
  String imgLink;
  DialogNotificationTemplate(
      {Key? key,
      required this.title,
      required this.content,
      required this.color,
      required this.imgLink})
      : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _DialogNotificationTemplateState();
}

class _DialogNotificationTemplateState extends ConsumerState<DialogNotificationTemplate> {

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      elevation: 3,
      backgroundColor: Colors.black.withOpacity(0.3),
      child: Container(
        height: 180.h,
        width: 340.w,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.black, width: 2.h),
            borderRadius: const BorderRadius.all(Radius.circular(15.0))),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: 340.w,
              height: 20.h,
              decoration: BoxDecoration(
                color: widget.color,
                borderRadius: const BorderRadius.only(topLeft: Radius.circular(12.0), topRight: Radius.circular(12.0),),
              ),
            ),
            Container(
              height: 2.h,
              width: 340,
              color: Colors.black,
            ),
            SizedBox(height: 14.h,),
            Image.asset(widget.imgLink, scale: 3.25,),
            SizedBox(height: 4.h,),
            Text(widget.title, style: TextStyle(fontSize: 18.sp, fontFamily: 'FreckleFace', color: Colors.black),),
            SizedBox(height: 9.h),
            Text(widget.content, style: TextStyle(fontSize: 15.sp, color: Colors.black),),
            
          ],
        ),
      ),
    );
  }
  }
