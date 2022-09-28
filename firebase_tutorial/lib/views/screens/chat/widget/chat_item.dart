import 'package:firebase_tutorial/config/export.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// ignore: must_be_immutable
class ChatItem extends ConsumerStatefulWidget {
  String avtLink;
  String name;
  String latest;
  String time;
  VoidCallback press;
  ChatItem({Key? key,  required this.name, required this.latest, required this.time, required this.avtLink, required this.press}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ChatItemState();
}

class _ChatItemState extends ConsumerState<ChatItem> {

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.press,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
                  padding: const EdgeInsets.all(2),
                  width: 70.w,
                  height: 70.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.r),
                    color: AppColor.blackBorder
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20.r),
                    child: Image.network('https://i.imgur.com/AOZhwOx.png', fit: BoxFit.fill)),
                ),
          SizedBox(width: 26.w,),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(widget.name,),
              SizedBox(height: 2.h,),
              Row(
                children: [
                  Text(widget.latest),
                  SizedBox(width: 13.w,),
                  Text(widget.time),
                ],
              )
              
            ],
          ),
        ],
      ),
    );
  }
}