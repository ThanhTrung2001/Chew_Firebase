import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_tutorial/config/export.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../services/call/calling_service.dart';

class VideoCallMainScreen extends ConsumerStatefulWidget {
  const VideoCallMainScreen({Key? key}) : super(key: key);
  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _VideoCallMainScreenState();
}

class _VideoCallMainScreenState extends ConsumerState<VideoCallMainScreen> {
  final videoCallFunction = CallingFunction();
  late RtcEngine agoraEngine;
  int? _remoteUid; // uid of the remote user
  bool _isJoined = false; // Indicates if the local user has joined the channel
  @override
  void initState() {
    //  setupVideoSDKEngine();
    setState(() {
      _isJoined == true;
    });
    super.initState();
  }

  Future<void> setupVideoSDKEngine() async {
    // retrieve or request camera and microphone permissions
    await [Permission.microphone, Permission.camera].request();

    //create an instance of the Agora engine
    agoraEngine = createAgoraRtcEngine();
    await agoraEngine.initialize(const RtcEngineContext(appId: appID));

    await agoraEngine.enableVideo();

    // Register the event handler
    agoraEngine.registerEventHandler(
      RtcEngineEventHandler(
        onJoinChannelSuccess: (RtcConnection connection, int elapsed) {
          print("Local user uid:${connection.localUid} joined the channel");
          setState(() {
            _isJoined = true;
          });
        },
        onUserJoined: (RtcConnection connection, int remoteUid, int elapsed) {
          print("Remote user uid:$remoteUid joined the channel");
          setState(() {
            _remoteUid = remoteUid;
          });
        },
        onUserOffline: (RtcConnection connection, int remoteUid,
            UserOfflineReasonType reason) {
          print("Remote user uid:$remoteUid left the channel");
          setState(() {
            _remoteUid = null;
          });
        },
      ),
    );
  }

  void join() async {
    print('Inforss: ${token} + ${userID} + ${channel}');
    await agoraEngine.startPreview();

    // Set channel options including the client role and channel profile
    ChannelMediaOptions options = const ChannelMediaOptions(
      clientRoleType: ClientRoleType.clientRoleBroadcaster,
      channelProfile: ChannelProfileType.channelProfileCommunication,
    );
    setState(() {
      _isJoined == true;
    });
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
  void dispose() async {
    if (_isJoined == false) {
      // await agoraEngine.leaveChannel();
      setState(() {
        _isJoined = false;
        _remoteUid = null;
      });
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Agora Video Calling'),
        centerTitle: true,
      ),
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          Positioned(
              top: 10,
              child: Container(
                width: size.width * 0.8,
                height: size.height * 0.6,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  border: Border.all(color: Colors.black, width: 2),
                ),
                child: _remoteVideo(),
              )),
          Positioned(
              top: size.height * 0.6 - 140,
              right: size.width * 0.1,
              child: Container(
                width: 120,
                height: 150,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.cyan,
                  border: Border.all(color: Colors.black, width: 2),
                ),
                child: _localPreview(),
              )),
          Positioned(
              top: size.height * 0.7,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: _isJoined == true ? null : () => {join()},
                    child: const Text("Join"),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: _isJoined == true ? () => {leave()} : null,
                    child: const Text("Leave"),
                  ),
                ],
              ))
        ],
      ),
    );
  }

  Widget _localPreview() {
    if (_isJoined == true) {
      return AgoraVideoView(
        controller: VideoViewController(
          rtcEngine: agoraEngine,
          canvas: VideoCanvas(uid: userID, view: 1),
        ),
      );
    } else {
      return const Text(
        'Join a channel',
        textAlign: TextAlign.center,
      );
    }
  }

// Display remote user's video
  Widget _remoteVideo() {
    if (_remoteUid != null) {
      return AgoraVideoView(
        controller: VideoViewController.remote(
          rtcEngine: agoraEngine,
          canvas: VideoCanvas(uid: _remoteUid),
          connection: RtcConnection(channelId: channel),
        ),
      );
    } else {
      String msg = '';
      if (_isJoined) msg = 'Waiting for a remote user to join';
      return Text(
        msg,
        textAlign: TextAlign.center,
      );
    }
  }
}
