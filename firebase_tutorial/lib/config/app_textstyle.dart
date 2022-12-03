import 'package:firebase_tutorial/config/export.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppTextStyle {
  static final appbarTitle = TextStyle(
      color: AppColor.primaryTextColor,
      fontFamily: 'FreckleFace',
      fontSize: 35.sp);

  static final subWaiting = TextStyle(
      color: AppColor.primaryTextColor,
      fontFamily: 'FreckleFace',
      fontSize: 18.sp);

  static final hint = TextStyle(
      color: AppColor.primaryTextColor,
      fontFamily: 'EBGaramond',
      fontSize: 18.sp);

  static final forgotText = TextStyle(
      color: AppColor.forgotTextColor,
      fontFamily: 'EBGaramond',
      fontWeight: FontWeight.w300,
      fontSize: 18.sp);

  static final buttonText = TextStyle(
      color: AppColor.secondaryTextColor,
      fontFamily: 'EBGaramond',
      fontWeight: FontWeight.w800,
      fontSize: 22.sp);

  //LiveItem
  static final liveTitleGrid = TextStyle(
      color: AppColor.primaryTextColor,
      fontFamily: 'EBGaramond',
      fontWeight: FontWeight.w600,
      fontSize: 22);

  static final statusOrTag = TextStyle(
      color: AppColor.primaryTextColor,
      fontFamily: 'EBGaramond',
      fontSize: 13.sp);

  static final numView = TextStyle(
      color: AppColor.subTextColor, fontFamily: 'EBGaramond', fontSize: 11.sp);

//Dialog
  static final titleDialog = TextStyle(
      color: AppColor.primaryTextColor,
      fontFamily: 'FreckleFace',
      fontSize: 23.sp);

  static final subTitleDialog = TextStyle(
      color: AppColor.primaryTextColor,
      fontFamily: 'EBGaramond',
      fontSize: 15.sp);

  static final buttonDialogText = TextStyle(
      color: AppColor.secondaryTextColor,
      fontFamily: 'EBGaramond',
      fontWeight: FontWeight.w600,
      fontSize: 16.sp);
}
