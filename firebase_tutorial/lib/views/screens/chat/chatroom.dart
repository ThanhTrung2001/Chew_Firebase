import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_tutorial/config/export.dart';
import 'package:firebase_tutorial/services/call/calling_service.dart';
import 'package:firebase_tutorial/services/chat/chat_service.dart';
import 'package:firebase_tutorial/services/chat/message_service.dart';
import 'package:firebase_tutorial/services/images/image_service.dart';
import 'package:firebase_tutorial/views/screens/chat/voice_call.dart';
import 'package:firebase_tutorial/views/screens/chat/widget/message_bar.dart';
import 'package:firebase_tutorial/views/screens/photo/photo.dart';
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
  final imageFunction = ImageFunction();
  final callingFunction = CallingFunction();
  bool isImage = false;
  bool isYour = false;
  late Stream<QuerySnapshot> listMessage;
  late RtcEngine agoraEngine;

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
              'Room',
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
                onTap: () {
                  callingFunction.setInformation(widget.chatRoomID);
                  // await callingFunction.onJoin();
                  Navigator.of(context).pushNamed('/voice');
                  // Navigator.of(context).pushNamed('/voice_test');
                },
                child: Icon(
                  Icons.call_rounded,
                  color: AppColor.blueBorder,
                  size: 35,
                ),
              ),
              SizedBox(
                width: 10,
              ),
              GestureDetector(
                onTap: () {
                  callingFunction.setInformation(widget.chatRoomID);
                  Navigator.of(context).pushNamed('/video');
                  // //use for test
                  // Navigator.of(context).pushNamed('/video_test');
                },
                child: Icon(
                  Icons.video_camera_back,
                  color: AppColor.blueBorder,
                  size: 35,
                ),
              ),
              SizedBox(
                width: 10,
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
                              pressImage: () async {
                                final result =
                                    await FilePicker.platform.pickFiles(
                                  allowMultiple: false,
                                  type: FileType.custom,
                                  allowedExtensions: ['png', 'jpg'],
                                );
                                if (result != null) {
                                  final path = result.files.single.path!;
                                  final name = result.files.single.name;
                                  await imageFunction.uploadFile(path, name);
                                  final url =
                                      await imageFunction.downloadURL(name);
                                  print(path + '----' + name);
                                  if (url != null) {
                                    messageFunction.sendImageMessage(
                                        widget.chatRoomID,
                                        FirebaseAuth.instance.currentUser!.uid,
                                        url);
                                  } else {
                                    print("error");
                                  }
                                }
                              },
                              sendMessage: () async {
                                await messageFunction.sendTextMessage(
                                    widget.chatRoomID,
                                    FirebaseAuth.instance.currentUser!.uid,
                                    messageController.text);
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
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data?.docs.length,
                itemBuilder: (BuildContext context, int index) {
                  DocumentSnapshot ds = snapshot.data!.docs[index];
                  return buildMessage(
                      ds['isImage'], ds['senderUID'], ds['content']);
                },
              );
            } else if (snapshot.hasError) {
              return Text('Error');
            } else {
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
                            color:
                                (uid != FirebaseAuth.instance.currentUser!.uid)
                                    ? AppColor.secondaryTextColor
                                    : AppColor.secondaryTextColor),
                      )
                    : GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      PhotoScreen(url: content)));
                        },
                        child: Image.network(content))),
          ],
        ),
      ],
    );
  }
}
