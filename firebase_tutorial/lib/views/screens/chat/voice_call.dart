import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_tutorial/config/export.dart';
import 'package:firebase_tutorial/services/call/calling_service.dart';
import 'package:firebase_tutorial/services/chat/chat_service.dart';
import 'package:firebase_tutorial/services/user/user_service.dart';
import 'package:firebase_tutorial/views/components/search/search_component.dart';
import 'package:firebase_tutorial/views/screens/chat/chatroom.dart';
import 'package:firebase_tutorial/views/screens/chat/widget/chat_item.dart';
import 'package:firebase_tutorial/views/screens/contact/widget/contact_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class VoiceCallingScreen extends ConsumerStatefulWidget {
  const VoiceCallingScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _VoiceCallingScreenState();
}

class _VoiceCallingScreenState extends ConsumerState<VoiceCallingScreen> {
  final voiceCallFunction = CallingFunction();
  late RtcEngine agoraEngine;


  @override
  void initState() {
    super.initState();
    voiceCallFunction.setupVoiceSDKEngine();
  }

  @override
  void dispose() async {
      // await voiceCallFunction.leaveChannel();
      super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Agora Test'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          height: size.height - 200,
          width: size.width,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              SizedBox(),
              Spacer(),
              ElevatedButton(onPressed: (){
                print('Infor: ${token} + ${userID} + ${channel}');
                voiceCallFunction.onVoiceJoin();
              }, child: const Text('Join')),
              ElevatedButton(onPressed: (){
                voiceCallFunction.leaveChannel();
                Navigator.of(context).pop();
              }, child: const Text('Leave')),
              SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}