import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_tutorial/config/export.dart';
import 'package:firebase_tutorial/main.dart';
import 'package:firebase_tutorial/models/chatroom_model.dart';
import 'package:firebase_tutorial/models/user_model.dart';
import 'package:firebase_tutorial/services/auth/authenticate_service.dart';
import 'package:firebase_tutorial/services/chat/chat_service.dart';
import 'package:firebase_tutorial/services/user/user_service.dart';
import 'package:firebase_tutorial/views/components/search/search_component.dart';
import 'package:firebase_tutorial/views/screens/contact/contact_profile.dart';
import 'package:firebase_tutorial/views/screens/contact/widget/contact_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../chat/chatroom.dart';

class ContactScreen extends ConsumerStatefulWidget {
  const ContactScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ContactScreenState();
}

class _ContactScreenState extends ConsumerState<ContactScreen> {
  final searchController = TextEditingController();
  final userFunction = UserFunction();
  final chatRoomFunction = ChatRoomFuction();
  final users = FirebaseFirestore.instance;
  late Stream<QuerySnapshot> userStream;

  void search() {
    if (searchController.text == "") {
      setState(() {
        userStream = userFunction.getUserList();
      });
    } else {
      setState(() {
        userStream = userFunction.searchuserByName(searchController.text);
      });
    }
  }

  @override
  void initState() {
    userStream = userFunction.getUserList();
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
            'Contact',
            style: AppTextStyle.appbarTitle,
          ),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
          actions: [
            // GestureDetector(
            //   onTap: () {},
            //   child: AppIcon.userSetting,
            // ),
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
                      stream: userStream,
                      builder:
                          (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.hasData) {
                          return ListView.separated(
                            itemCount: snapshot.data!.docs.length,
                            padding: EdgeInsets.zero,
                            shrinkWrap: false,
                            itemBuilder: (BuildContext context, int index) {
                              DocumentSnapshot ds = snapshot.data!.docs[index];
                              if (ds['uid'] !=
                                  FirebaseAuth.instance.currentUser!.uid) {
                                return buildUser(ds['uid'], ds['name'],
                                    ds['status'], ds['avtLink']);
                              } else {
                                return SizedBox();
                              }
                              // return buildUser(ds['uid'],
                              //     ds['name'], ds['status'], ds['avtLink']);
                            },
                            separatorBuilder:
                                (BuildContext context, int index) {
                              return SizedBox(
                                height: 10.h,
                              );
                            },
                          );
                        } else if (snapshot.hasError) {
                          print(snapshot.error);
                          return Text(
                              'No information about user "${searchController.text}"');
                        } else {
                          return Text('loading');
                        }
                      })),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildUser(String uid, String name, String status, String avtLink) {
    return ContactItem(
      name: name,
      status: status,
      avtLink: avtLink,
      onPressedAvatar: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ContactProfileScreen(
                    uid: uid,
                  )),
        );
      },
      onPressedMessage: () async {
        final userUID = await FirebaseAuth.instance.currentUser?.uid;
        final chatRoomModel = ChatRoomModel('', name, '', '',
            FirebaseAuth.instance.currentUser!.uid, [], avtLink);
        final i =
            await chatRoomFunction.createChatRoom(chatRoomModel, uid, userUID!);
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ChatRoomScreen(chatRoomID: i!)),
        );
      },
    );
  }
}
