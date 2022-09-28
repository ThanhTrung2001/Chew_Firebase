import 'package:firebase_tutorial/config/export.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// ignore: must_be_immutable
class MessageBar extends ConsumerStatefulWidget {
  TextEditingController controller;
  VoidCallback pressImage;
  VoidCallback sendMessage;
  MessageBar(
      {Key? key,
      required this.controller,
      required this.pressImage,
      required this.sendMessage})
      : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MessageBarState();
}

class _MessageBarState extends ConsumerState<MessageBar> {
  @override
  Widget build(BuildContext context) {
     Size size = MediaQuery.of(context).size;
    return Container(
      height: 65 * size.height / 896,
      decoration: BoxDecoration(
        color: AppColor.secondaryTextColor,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(8.0),
          topRight: Radius.circular(8.0),
        ),
        
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          GestureDetector(
            onTap: widget.pressImage,
            child: Image.asset(
              'assets/icons/Image.png',
              scale: 4,
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 5.0 * size.height / 896),
            height: 55 * size.height / 896,
            width: 300 * size.width / 414,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: AppColor.secondaryTextColor,
              borderRadius: BorderRadius.circular(18.0),
              border: Border.all(color: AppColor.blackBorder, width: 2),
            ),
            child: TextField(
              textAlign: TextAlign.center,
              textAlignVertical: TextAlignVertical.center,
              maxLines: 1,
              style: TextStyle(color: AppColor.primaryTextColor, fontSize: 16),
              controller: widget.controller,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Type message here...',
                isCollapsed: true,
                hintStyle: TextStyle(color: AppColor.subTextColor, fontSize: 16),
                suffixIcon: GestureDetector(
                  onTap: widget.sendMessage,
                  child: Image.asset(
                    'assets/icons/EmailSend.png',
                    scale: 5,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
