import 'dart:math';

//AppID
const String appID = "1f34d2fafcb94412a9939349ce282aad";
//Token
String token = "00617cb7ec4e5d845498de0f75eeac4273aIAAhwWV5ZL7WZcA4VwCdlc9NKH3KgkQ2csDgRiKjjuZI+mHTcgm379yDEADTR+sCyVB6YwEAAQDphXpj";
//Channelid / channelName
String channel = "123456";
//AppCertificate
const appcertificate = "a26885dbbcda4b7297f66f16de59eae0";
//userID -> Random
int userID = 1;
//Token ROle
int tokenRole = 1; // use 1 for Host/Broadcaster, 2 for Subscriber/Audience
//ServerURL
String serverUrl = "https://agora-token-service-production-92ff.up.railway.app"; 
// String serverUrl = "localhost:8080"; // The base URL to your token server, for example "https://agora-token-service-production-92ff.up.railway.app" => use for NodeJS

//Token ExpiringTIme
int tokenExpireTime = 86400; // Expire time in Seconds.
//Is Token expiring for renew
bool isTokenExpiring = false; // Set to true when the token is about to expire
