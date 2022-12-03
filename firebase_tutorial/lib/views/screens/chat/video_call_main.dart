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
  bool _isMuted = false;
  bool _isAvoidCam = false;
  bool _isFrontCam = true;
  @override
  void initState() {
    setupVideoSDKEngine();
    // setState(() {
    //   _isJoined == true;
    // });
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
      _isJoined = true;
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

  void pressMute() {
    setState(() {
      _isMuted = !_isMuted;
    });
    agoraEngine.muteLocalAudioStream(_isMuted);
  }

  void pressCamera() {
    setState(() {
      _isAvoidCam = !_isAvoidCam;
    });
    agoraEngine.muteLocalVideoStream(_isAvoidCam);
  }

  void toggleCamera() {
    setState(() {
      _isFrontCam = !_isFrontCam;
    });
    agoraEngine.switchCamera();
  }

  @override
  void dispose() async {
    await agoraEngine.leaveChannel();
    setState(() {
      _isJoined = false;
      _remoteUid = null;
    });
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Agora Video Calling'),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: Center(
        child: Container(
          color: Colors.black,
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              //Remote View
              Positioned(
                  top: 0,
                  child: Container(
                    width: size.width,
                    height: size.height * 0.7,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.black, width: 2),
                    ),
                    child: _remoteVideo(),
                  )),
              //UserView
              Positioned(
                  top: size.height * 0.7 - 150,
                  right: 0,
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
              //Button Mic
              Positioned(
                  top: size.height * 0.72,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      //Button Mic
                      ElevatedButton(
                        onPressed: () {
                          pressMute();
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.white,
                          shape: CircleBorder(),
                          padding: EdgeInsets.all(7.0),
                        ),
                        child: Icon(
                          Icons.mic,
                          color:
                              (_isMuted == false) ? Colors.blue : Colors.grey,
                          size: 25.0,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      //Button Camera
                      ElevatedButton(
                        onPressed: () {
                          pressCamera();
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.white,
                          shape: CircleBorder(),
                          padding: EdgeInsets.all(7.0),
                        ),
                        child: Icon(
                          Icons.camera_alt_rounded,
                          color: (_isAvoidCam == false)
                              ? Colors.blue
                              : Colors.grey,
                          size: 25.0,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      //Button Switch Camera
                      ElevatedButton(
                        onPressed: () {
                          toggleCamera();
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.white,
                          shape: CircleBorder(),
                          padding: EdgeInsets.all(7.0),
                        ),
                        child: Icon(
                          Icons.swap_calls,
                          color:
                              (_isFrontCam == false) ? Colors.red : Colors.blue,
                          size: 25.0,
                        ),
                      ),
                    ],
                  )),
              //Join & Leave Channel button
              Positioned(
                top: size.height * 0.785,
                child: (_isJoined == false)
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
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _localPreview() {
    if (_isJoined == true) {
      return AgoraVideoView(
        controller: VideoViewController(
          rtcEngine: agoraEngine,
          canvas: VideoCanvas(uid: 0),
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
