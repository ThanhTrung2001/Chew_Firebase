import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_tutorial/config/export.dart';
import 'package:firebase_tutorial/services/chat/chat_service.dart';
import 'package:firebase_tutorial/services/user/user_service.dart';
import 'package:firebase_tutorial/views/components/search/search_component.dart';
import 'package:firebase_tutorial/views/screens/chat/chatroom.dart';
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
  final chatRoomFunction = ChatRoomFuction();
  final searchController = TextEditingController();
  late Stream<QuerySnapshot> chatRoomStream;

  void search() {
    if (searchController.text == "") {
      setState(() {
        chatRoomStream = chatRoomFunction.getChatRoomList(FirebaseAuth.instance.currentUser?.displayName);
      });
    } else {
      setState(() {
        chatRoomStream = chatRoomFunction.getChatRoomList(FirebaseAuth.instance.currentUser?.displayName);
      });
    }
  }

  @override
  void initState() {
    chatRoomStream = chatRoomFunction.getChatRoomList(FirebaseAuth.instance.currentUser?.displayName);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          title: Text(
            'Chat',
            style: AppTextStyle.appbarTitle,
          ),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
          actions: [
            GestureDetector(
              onTap: () {
              },
              child: AppIcon.userSetting,
            ),
          ],
        ),
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 59.h,
              ),
              SearchComponent(
                controller: searchController,
                press: () {
                  search();
                },
              ),
              SizedBox(
                height: 21.h,
              ),
              Divider(
                indent: 157.w,
                endIndent: 157.w,
                color: AppColor.blackBorder,
                thickness: 3,
              ),
              SizedBox(
                height: 21.h,
              ),
              Container(
                  alignment: Alignment.center,
                  width: 300.w,
                  height: 600.h,
                  child: StreamBuilder(
                    stream: chatRoomStream,
                    builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.hasData) {
                        print(snapshot.data!.docs.length);
                        return ListView.separated(
                          itemCount: snapshot.data!.docs.length,
                          padding: EdgeInsets.zero,
                          itemBuilder: (BuildContext context, index) {
                            DocumentSnapshot ds = snapshot.data!.docs[index];
                            return ChatItem(
                                name: ds['title'],
                                latest: ds['latestMessageContent'] ?? '',
                                time: '',
                                avtLink: 'https://i.imgur.com/AOZhwOx.png',
                                press: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              ChatRoomScreen(chatRoomID: ds['id'],)));
                                });
                          },
                          separatorBuilder: (BuildContext context, int index) {
                            return SizedBox(
                              height: 10.h,
                            );
                          },
                        );
                      } else if (snapshot.hasError) {
                        return Text('Error');
                      } else {
                        return Text('Loading');
                      }
                    },
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
