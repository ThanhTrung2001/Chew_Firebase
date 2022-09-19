import 'package:firebase_tutorial/config/export.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// ignore: must_be_immutable
class ContactItem extends ConsumerStatefulWidget {
  String avtLink;
  String name;
  String status;
  ContactItem({Key? key, required this.name, required this.status, required this.avtLink}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ContactItemState();
}

class _ContactItemState extends ConsumerState<ContactItem> {

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius: 40.w,
          backgroundColor: AppColor.blackBorder,
          backgroundImage: NetworkImage('https://i.imgur.com/AOZhwOx.png',),
        ),
        SizedBox(width: 17.w,),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(widget.name),
            SizedBox(height: 2.h,),
            Text(widget.status),
          ],
        ),
        Spacer(),
        AppIcon.chatActive,
      ],
    );
  }
}