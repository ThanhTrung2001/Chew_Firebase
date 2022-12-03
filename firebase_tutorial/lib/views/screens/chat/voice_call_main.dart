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

class VoiceCallMainScreen extends ConsumerStatefulWidget {
  const VoiceCallMainScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _VoiceCallMainScreenState();
}

class _VoiceCallMainScreenState extends ConsumerState<VoiceCallMainScreen> {
  final voiceCallFunction = CallingFunction();
  late RtcEngine agoraEngine;
  int? _remoteUid; // uid of the remote user
  bool _isJoined = false; // Indicates if the local user has joined the channel
  bool _isMuted = false;

  @override
  void initState() {
    super.initState();
    voiceCallFunction.setupVoiceSDKEngine();
  }

  void pressMute() {
    setState(() {
      _isMuted = !_isMuted;
    });
    voiceCallFunction.pressMute(_isMuted);
  }

  void join() {
    print('Inforss: ${token} + ${userID} + ${channel}');
    voiceCallFunction.onVoiceJoin();
    setState(() {
      _isJoined = true;
    });
  }

  void leave() {
    setState(() {
      _isJoined = false;
      _remoteUid = null;
    });
    voiceCallFunction.leaveChannel();
  }

  @override
  void dispose() async {
    setState(() {
      _isJoined = false;
      _remoteUid = null;
    });
    await voiceCallFunction.leaveChannel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('Agora Voice Call'),
        centerTitle: true,
      ),
      body: Container(
        color: Colors.black,
        width: size.width,
        height: size.height,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            SizedBox(
              height: 250,
            ),
            Icon(
              Icons.mic,
              color: Colors.white,
              size: 200,
            ),
            const SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Visibility(
                  visible: true,
                  child: ElevatedButton(
                    onPressed: () {
                      pressMute();
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.white,
                      shape: CircleBorder(),
                      padding: EdgeInsets.all(10.0),
                    ),
                    child: Icon(
                      Icons.mic_none_rounded,
                      color: (_isMuted == false) ? Colors.red : Colors.grey,
                      size: 35.0,
                    ),
                  ),
                ),
                (_isJoined == false)
                    ? ElevatedButton(
                        onPressed: () {
                          join();
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Color.fromARGB(255, 63, 133, 66),
                          shape: CircleBorder(),
                          padding: EdgeInsets.all(10.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: const Text("Start"),
                        ),
                      )
                    : ElevatedButton(
                        onPressed: () {
                          leave();
                          Navigator.of(context).pop();
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.red,
                          shape: CircleBorder(),
                          padding: EdgeInsets.all(10.0),
                        ),
                        child: const Icon(
                          Icons.call_end,
                          color: Colors.white,
                          size: 35.0,
                        ),
                      ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
