import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppIcon{
  static const String assetIconUrl = 'assets/icons'; // link

  static final back = Image.asset('${assetIconUrl}/Back.png', scale: 3.h,);

  static final heart = Image.asset('${assetIconUrl}/Heart.png', scale: 3.h,);

  static final gift = Image.asset('${assetIconUrl}/Gift.png', scale: 3.h,);

  static final userSetting = Image.asset('${assetIconUrl}/User Settings.png', scale: 5.h,);
  
  static final report = Image.asset('${assetIconUrl}/Error.png', scale: 3.h,);
  
  static final micCall = Image.asset('${assetIconUrl}/Call.png', scale: (100/35*3).h,);

  static final videoCall = Image.asset('${assetIconUrl}/Video Call.png', scale: (100/35*3).h,);

  static final info = Image.asset('${assetIconUrl}/Info.png', scale: (100/35*3).h,);

  static final chatActive = Image.asset('${assetIconUrl}/Chat.png', scale: (100/35*3).h,);

  static final chatUnActive = Image.asset('${assetIconUrl}/Chat-1.png', scale: (100/35*3).h,);

  static final homeActive = Image.asset('${assetIconUrl}/Home-1.png', scale: (100/35*3).h,);

  static final homeUnActive = Image.asset('${assetIconUrl}/Home.png', scale: (100/35*3).h,);

  static final notificationActive = Image.asset('${assetIconUrl}/Notification-1.png', scale: (100/35*3).h,);

  static final notificationUnActive = Image.asset('${assetIconUrl}/Notification.png', scale: (100/35*3).h,);

  static final contactActive = Image.asset('${assetIconUrl}/People-1.png', scale: (100/35*3).h,);

  static final contactUnActive = Image.asset('${assetIconUrl}/People.png', scale: (100/35*3).h,);

  static final settingActive = Image.asset('${assetIconUrl}/Settings-1.png', scale: (100/35*3).h,);

  static final settingUnActive = Image.asset('${assetIconUrl}/Settings.png', scale: (100/35*3).h,);

  static final searchWhite = Image.asset('${assetIconUrl}/Search-2.png', scale: (100/35)*4.h,);

  static final searchBlue = Image.asset('${assetIconUrl}/Search-1.png', scale: (100/35*3).h,);
}