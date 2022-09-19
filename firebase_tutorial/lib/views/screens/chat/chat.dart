import 'package:firebase_tutorial/config/export.dart';
import 'package:firebase_tutorial/views/components/search/search_component.dart';
import 'package:firebase_tutorial/views/screens/chat/widget/chat_item.dart';
import 'package:firebase_tutorial/views/screens/contact/widget/contact_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChatScreen extends ConsumerStatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ChatScreenState();
}

class _ChatScreenState extends ConsumerState<ChatScreen> {
  final searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          extendBodyBehindAppBar: true,
        appBar: AppBar(
          title: Text('Chat', style: AppTextStyle.appbarTitle,),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
          actions: [
            GestureDetector(
              onTap: (){},
              child: AppIcon.userSetting,
            ),
          ],
        ),
        
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 59.h,),
              SearchComponent(controller: searchController, press: (){},),
              SizedBox(height: 21.h,),
              Divider(indent: 157.w, endIndent: 157.w, color: AppColor.blackBorder, thickness: 3,),
              SizedBox(height: 21.h,),
              Container(
                alignment: Alignment.center,
                width: 300.w,
                height: 600.h,
                child: ListView.separated(
                  padding: EdgeInsets.zero,
                  itemCount: 50,
                  itemBuilder: (_, index){
                    return ChatItem(name: 'Username${index}', latest: 'status${index}', time: '11:30' , avtLink: '');
                  }, separatorBuilder: (BuildContext context, int index) { return SizedBox(height: 10.h,); },)),
              
            ],
          ),
        ),
      ),
    );
  }
}