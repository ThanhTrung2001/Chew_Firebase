import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_tutorial/config/export.dart';
import 'package:firebase_tutorial/services/chat/chat_service.dart';
import 'package:firebase_tutorial/services/chat/message_service.dart';
import 'package:firebase_tutorial/views/screens/chat/widget/message_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChatRoomScreen extends ConsumerStatefulWidget {
  String chatRoomID;
  ChatRoomScreen({Key? key, required this.chatRoomID}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ChatRoomScreenState();
}

class _ChatRoomScreenState extends ConsumerState<ChatRoomScreen> {
  TextEditingController messageController = TextEditingController();
  final chatRoomFunction = ChatRoomFuction();
  final messageFunction = MessageFunction();
  bool isImage = false;
  bool isYour = false;
  late Stream<QuerySnapshot> listMessage;

  @override
  void initState() {
    listMessage = messageFunction.getMessageList(widget.chatRoomID);
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
                child: AppIcon.gift,
              ),
            ],
          ),
          body: Stack(
            children: [
              CustomScrollView(
                slivers: [
                  SliverFillRemaining(
                    hasScrollBody: false,
                    child: GestureDetector(
                      onTap: () {
                        FocusScope.of(context).unfocus();
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                              child: Container(
                                  padding: const EdgeInsets.only(top: 5.0),
                                  child: buildConversation())),
                          MessageBar(
                              controller: messageController,
                              pressImage: () {},
                              sendMessage: () {
                                messageFunction.sendTextMessage(widget.chatRoomID, FirebaseAuth.instance.currentUser!.uid, messageController.text);
                              }),
                        ],
                      ),
                    ),
                  )
                ],
              )
            ],
          )),
    );
  }

  Widget buildConversation() {
    Size size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0 * size.width / 414),
      height: (896 - 50 - 75) * size.height / 896,
      width: double.infinity,
      child: StreamBuilder(
          stream: listMessage,
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot){
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data?.docs.length,
                itemBuilder: (BuildContext context, int index) {
                  DocumentSnapshot ds = snapshot.data!.docs[index];
                  return buildMessage(ds['isImage'], ds['senderUID'], ds['content']);
                },
              );
            }
            else if(snapshot.hasError)
            {
              return Text('Error');
            }
            else{
              return Text('Loading');
            }
          }),
    );
  }

  Widget buildMessage(bool isImage, String uid, String content) {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        SizedBox(
          height: 10 * size.height / 896,
        ),
        Row(
          mainAxisAlignment: (uid != FirebaseAuth.instance.currentUser!.uid)
              ? MainAxisAlignment.start
              : MainAxisAlignment.end,
          children: [
            Container(
                padding: const EdgeInsets.all(10.0),
                constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width * 0.6),
                decoration: BoxDecoration(
                  color: (uid != FirebaseAuth.instance.currentUser!.uid)
                      ? AppColor.primaryTextColor
                      : AppColor.blueButton,
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: (isImage == false)
                    ? Text(
                        content,
                        style: TextStyle(
                            color: (uid != FirebaseAuth.instance.currentUser!.uid)
                                ? AppColor.secondaryTextColor
                                : AppColor.primaryTextColor),
                      )
                    : Image.network(content)),
          ],
        ),
      ],
    );
  }
}
