import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_tutorial/views/screens/contact/contact_profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../config/export.dart';

class Comment extends ConsumerStatefulWidget {
  String uid;
  String postUserID;
  String avtLink;
  String content;
  VoidCallback onPressedDelete;
  Comment(
      {Key? key,
      required this.postUserID,
      required this.uid,
      required this.avtLink,
      required this.content,
      required this.onPressedDelete})
      : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CommentState();
}

class _CommentState extends ConsumerState<Comment> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            GestureDetector(
              onTap: () {
                if (FirebaseAuth.instance.currentUser!.uid != widget.uid) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ContactProfileScreen(
                              uid: widget.uid,
                            )),
                  );
                }
              },
              child: Container(
                padding: const EdgeInsets.all(2),
                width: 40.w,
                height: 40.w,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.r),
                    color: AppColor.blackBorder),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(20.r),
                    child: Image.network(widget.avtLink, fit: BoxFit.fill)),
              ),
            ),
            SizedBox(
              width: 20.w,
            ),
            Container(
              width: 240.w,
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 199, 199, 199),
                border: Border.all(width: 1),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Text(widget.content),
            ),
          ],
        ),
        SizedBox(
          width: 10.w,
        ),
        (FirebaseAuth.instance.currentUser!.uid == widget.uid ||
                FirebaseAuth.instance.currentUser!.uid == widget.postUserID)
            ? Container(
                width: 25.w,
                height: 25.w,
                child: GestureDetector(
                  onTap: widget.onPressedDelete,
                  child: Icon(
                    Icons.delete,
                    color: Color(0xFF567BC3),
                  ),
                ),
              )
            : SizedBox(),
      ],
    );
  }
}
