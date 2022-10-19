import 'package:firebase_tutorial/config/export.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LiveListScreen extends ConsumerStatefulWidget {
  const LiveListScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LiveListScreenState();
}

class _LiveListScreenState extends ConsumerState<LiveListScreen> {

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            title: Text(
              'ChatRoom',
              style: AppTextStyle.appbarTitle,
            ),
            centerTitle: true,
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: Padding(
              padding: EdgeInsets.only(top: 17.h, left: 10.w),
              child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: AppIcon.back),
            ),
            actions: [
              GestureDetector(
                onTap: () {},
                child: AppIcon.searchBlue,
              ),
            ],
          ),
        body: Center(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 21.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 84.h,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    buildType(true, 'All', () { }),
                    buildType(false, 'Famous', () { }),
                    buildType(true, 'Follow', () { }),
                  ],
                ),
                SizedBox(height: 24.h,),
                Text('Result'),
                SizedBox(height: 8.h,),
                Divider(thickness: 3, endIndent: 20,),
                GridView.builder(
                  itemCount: 10,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    mainAxisSpacing: 10,
                                    crossAxisSpacing: 5,
                                    childAspectRatio: 1), 
                  itemBuilder: (context, index){
                    return Container();
                  })

              ],
            ),
          ),
        ),
        ));
  }
  Widget buildType(bool isSelected, String title, VoidCallback press){
    return GestureDetector(
      onTap: press,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 17.w),
        decoration: BoxDecoration(
          border: Border.all(width: 1.5.w, color: AppColor.blackBorder),
          borderRadius: BorderRadius.circular(15.r),
          color: isSelected == true ? AppColor.blueButton : AppColor.subTextColor,
        ),
        child: Text(title),
      ),
    );
  }
}