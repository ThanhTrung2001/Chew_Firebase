int tokenRole = 1; // use 1 for Host/Broadcaster, 2 for Subscriber/Audience
String serverUrl = "https://agora-token-service-production-92ff.up.railway.app"; 
// String serverUrl = "localhost:8080"; // The base URL to your token server, for example "https://agora-token-service-production-92ff.up.railway.app"
int tokenExpireTime = 86400; // Expire time in Seconds.
bool isTokenExpiring = false; // Set to true when the token is about to expire
