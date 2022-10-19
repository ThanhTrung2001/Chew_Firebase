import 'package:firebase_tutorial/config/export.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:photo_view/photo_view.dart';

// ignore: must_be_immutable
class PhotoScreen extends ConsumerStatefulWidget {
  String url;
  PhotoScreen({Key? key, required this.url}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _PhotoScreenState();
}

class _PhotoScreenState extends ConsumerState<PhotoScreen> {

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.black,
            elevation: 0,
            leading: Padding(
              padding: EdgeInsets.only(top: 17.h, left: 10.w),
              child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: AppIcon.back),
            ),
        ),
        body: Container(
          child: PhotoView(
            imageProvider: NetworkImage(widget.url),
          ),
        ),
        ));
  }
}