import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_tutorial/models/chatroom_model.dart';
import 'package:firebase_tutorial/models/message_model.dart';
import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:firebase_tutorial/config/app_call.dart';
import 'package:permission_handler/permission_handler.dart';

class VoiceCallFunction{

  ClientRoleType? hostRole = ClientRoleType.clientRoleBroadcaster;
  late RtcEngine agoraEngine;
  int? _remoteUid;
  RtcConnection connect = RtcConnection();

  Future generateToken()async{
    
  }


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
          
        },
        onUserJoined: (RtcConnection connection, int remoteUid, int elapsed) {
          print('user connnect');
        },
        onUserOffline: (RtcConnection connection, int remoteUid,
            UserOfflineReasonType reason) {
          print("disconnect");
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
      uid: 1,
    );
  }

  void leaveChannel()
  {
    agoraEngine.leaveChannel();
  }
}