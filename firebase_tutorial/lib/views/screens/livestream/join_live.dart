import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:firebase_tutorial/config/app_call.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

class JoinLiveScreen extends ConsumerStatefulWidget {
  const JoinLiveScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _JoinLiveScreenState();
}

class _JoinLiveScreenState extends ConsumerState<JoinLiveScreen> {
  final controller = TextEditingController();
  bool validateErr = false;
  bool _isJoined = false;

  ClientRoleType? hostRole = ClientRoleType.clientRoleBroadcaster;
  late RtcEngine agoraEngine;
  int? _remoteUid;

  Future<void> setupVoiceSDKEngine() async {
    // retrieve or request microphone permission
    await [Permission.microphone].request();

    //create an instance of the Agora engine
    agoraEngine = createAgoraRtcEngine();
    await agoraEngine.initialize(const RtcEngineContext(appId: appID));

    // Register the event handler
    agoraEngine.registerEventHandler(
      RtcEngineEventHandler(
        onJoinChannelSuccess: (RtcConnection connection, int elapsed) {
          print('create channel to connect');
          setState(() {
            _isJoined = true;
          });
        },
        onUserJoined: (RtcConnection connection, int remoteUid, int elapsed) {
          print('user connnect');
          setState(() {
            _remoteUid = remoteUid;
          });
        },
        onUserOffline: (RtcConnection connection, int remoteUid,
            UserOfflineReasonType reason) {
          print("disconnect");
          setState(() {
            _remoteUid = null;
          });
        },
      ),
    );
  }

  Future<void> onJoin() async {
    Permission.microphone.request();
    ChannelMediaOptions options = const ChannelMediaOptions(
      clientRoleType: ClientRoleType.clientRoleBroadcaster,
      channelProfile: ChannelProfileType.channelProfileCommunication,
    );

    await agoraEngine.joinChannel(
      token: token,
      channelId: channel,
      options: options,
      uid: userID,
      
    );
  }

  void leave() {
    setState(() {
      _isJoined = false;
      _remoteUid = null;
    });
    agoraEngine.leaveChannel();
  }

  @override
  void initState() {
    super.initState();
    // Set up an instance of Agora engine
    setupVoiceSDKEngine();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Agora Test'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              const SizedBox(
                height: 40,
              ),
              TextField(
                controller: controller,
                decoration: InputDecoration(
                  errorText: validateErr ? 'Channel is mandantory' : null,
                  hintText: 'channel name',
                ),
              ),
              ElevatedButton(onPressed: onJoin, child: const Text('Join')),
              ElevatedButton(onPressed: leave, child: const Text('Leave')),
            ],
          ),
        ),
      ),
    );
  }
}
