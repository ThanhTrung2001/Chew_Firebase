import 'package:firebase_tutorial/config/export.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// ignore: must_be_immutable
class ContactItem extends ConsumerStatefulWidget {
  String avtLink;
  String name;
  String status;
  VoidCallback onPressedAvatar;
  VoidCallback onPressedMessage;
  ContactItem(
      {Key? key,
      required this.name,
      required this.status,
      required this.avtLink,
      required this.onPressedAvatar,
      required this.onPressedMessage})
      : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ContactItemState();
}

class _ContactItemState extends ConsumerState<ContactItem> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: widget.onPressedAvatar,
          child: CircleAvatar(
            radius: 35.w,
            backgroundColor: AppColor.blackBorder,
            backgroundImage: NetworkImage(
              widget.avtLink,
            ),
          ),
        ),
        SizedBox(
          width: 17.w,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(widget.name),
            SizedBox(
              height: 2.h,
            ),
            Text(widget.status),
          ],
        ),
        Spacer(),
        GestureDetector(
            onTap: widget.onPressedMessage, child: AppIcon.chatActive),
      ],
    );
  }
}
