import 'dart:math';

//AppID
const String appID = "1f34d2fafcb94412a9939349ce282aad";
//Token
String token = "";
//Channelid / channelName
String channel = "123456";
//AppCertificate
const appcertificate = "a26885dbbcda4b7297f66f16de59eae0";
//userID
int userID = 0;
//Token ROle
int tokenRole = 1; // use 1 for Host/Broadcaster, 2 for Subscriber/Audience
//ServerURL
String serverUrl = "chewnodejstokengenerator-production.up.railway.app";
// String serverUrl =
//     "localhost:8080"; // The base URL to your token server, for example "https://agora-token-service-production-92ff.up.railway.app" => use for NodeJS

//Token ExpiringTIme
int tokenExpireTime = 100; // Expire time in Seconds.

//Is Token expiring for renew
bool isTokenExpiring = false; // Set to true when the token is about to expire

//userinfo
String id = "";
String name = "";
String email = "";
String avtLink = "";
String description = "123";
